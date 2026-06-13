# Codebase Concerns & Technical Debt

This document details the critical architectural concerns, technical debt, and missing features/platform discrepancies identified in the calling module of the VanishLink codebase.

---

## 1. Calling Stabilization & Lifecycle Management

### Background Lifecycle & Socket Retention
* **The Issue:** Native mobile platform background transitions are observed by the `CallCoordinator` and `CallLifecycleManager`, but socket/connection retention during app backgrounding is fragile. If the operating system suspends the Dart VM or terminates network connections, signaling listeners in `CallListenerService` will disconnect.
* **Technical Debt:** The current setup relies on the Firebase Realtime Database (RTDB) connection staying alive in the background without explicit background execution tasks (e.g., iOS Background Tasks API or Android Foreground Services).

### Signaling Failure & Exception Recovery
* **The Issue:** In `CallListenerService`, signaling stream subscriptions use a defensive try-catch mechanism but lack structured retry/reconnection policies.
* **Technical Debt:** When errors occur in `watchIncomingCalls`, they are swallowed without alerting the user or calling BLoC. This results in "ghost calls" where the connection terminates silently on one end while the other peer continues to dial.

### ICE Connection Timeouts and Lacking Reconnection
* **The Issue:** `WebRtcService` uses a hardcoded 15-second `_connectionTimeoutTimer` to transition the call state to `failed` if `connected` is not reached. 
* **Technical Debt:** 
  * There is no mechanism to dynamically extend this timeout on slow networks.
  * The `restartIce` function is currently a placeholder (`// Future ICE restart logic`) with no active ICE restart procedures implemented. When a network switch happens (e.g., Wi-Fi to cellular), the call immediately fails.

---

## 2. Web vs. Native CallKit Discrepancies

### Lack of VoIP Wake-Up Capabilities on Web
* **The Issue:** Native iOS and Android platforms utilize `FlutterCallkitIncoming` to hook into system-level calling services (CallKit / ConnectionService), allowing incoming calls to launch the app UI even from a terminated state. 
* **Technical Debt:** On Web and Desktop, CallKit adapters (`WebCallAdapter`, `DesktopCallAdapter`) are empty stubs. If the app is closed or backgrounded on Web, the user cannot receive incoming call notifications or wake-up signals. 

### Audio System Integration (AVAudioSession & Audio Focus)
* **The Issue:** Native platforms manage hardware integrations like switching to speakerphone via `Helper.setSpeakerphoneOn(enabled)`. 
* **Technical Debt:** 
  * On Web, browser security restrictions prevent toggling speakerphone dynamically (`setSpeakerphoneOn` returns early with a debug print).
  * Native apps utilize iOS `AVAudioSession` properties (e.g., `audioSessionPreferredSampleRate: 44100.0` configured in `IOSCallAdapter`) to prioritize call audio and pause background music. Web lacks this tight integration, leading to potential audio mixing issues.

---

## 3. WebRTC Implementation Status

### Absence of TURN Server Infrastructure
* **The Issue:** The `WebRtcConfigProviderImpl` defines public Google STUN servers for NAT traversal, but the TURN server configuration is completely commented out as a placeholder.
* **Technical Debt:** Calls between users on restrictive corporate firewalls, symmetric NATs, or cellular data providers will consistently fail to establish a direct P2P media connection because there is no relay (TURN) server to fall back on.

### Web Autoplay Policy Restrictions
* **The Issue:** In `WebRtcService._handleRemoteTrack`, the incoming audio track is manually assigned to a `RTCVideoRenderer` (`_remoteRenderer`). 
* **Technical Debt:** Browsers frequently block programmatically played media unless there is a preceding user gesture (`NotAllowedError`). If a call is answered automatically or without a direct click on the call screen, the remote audio track is muted by the browser's autoplay block, and only a warning log is printed.

### Signaling State Race Conditions
* **The Issue:** The signaling repository supports both deterministic caller/receiver modes and dynamic role detection. 
* **Technical Debt:** The dynamic fallback relies on checking if the RTDB session path is empty to designate the caller. Under high latency, both clients can concurrently write offer objects, causing signaling state clashes and broken handshake connections.
