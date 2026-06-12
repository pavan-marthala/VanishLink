# Technical Concerns & Stabilization Items

This document outlines the architectural concerns, technical debt, and platform discrepancies identified in the `vanish_link` codebase, with a specific focus on the calling feature, WebRTC implementation, and CallKit discrepancies.

---

## 1. Calling Stabilization & Reliability

### A. Missing TURN Servers (ICE Gathering Failures)
* **Current Setup**: The WebRTC peer connection configuration in `WebRtcRepositoryImpl` only defines public STUN servers:
  ```dart
  'iceServers': [
    {'urls': 'stun:stun.l.google.com:19302'},
    {'urls': 'stun:stun1.l.google.com:19302'},
    {'urls': 'stun:stun2.l.google.com:19302'},
  ]
  ```
* **Impact**: While STUN is sufficient for resolving public IP addresses under simple network topologies, it fails in environments with symmetric NATs (common on mobile networks and corporate Wi-Fi). Without a TURN (Traversal Using Relays around NAT) server, media/data relay will fail, resulting in calls that hang in the `connecting` or `checking` state and eventually fail.
* **Stabilization Item**: Integrate a TURN server provider (e.g., Coturn, Twilio Network Traversal, or Xirsys) into the configuration.

### B. Race Conditions and Call Collisions
* **Current Setup**: `CallCoordinator.initiateCall` checks the local `CallBloc` state to verify that the user does not have an active call, and checks the peer's online status.
* **Impact**: If two users attempt to dial each other at the same fraction of a second:
  - Both will see the other user as "online."
  - Both will successfully write to different session paths or overwrite the same path in Firebase Realtime Database.
  - There is no server-side transaction or locking mechanism to handle simultaneous call initiation, which can lead to split-brain states or orphaned signaling nodes.
* **Stabilization Item**: Implement a centralized server-side database rule/transaction (or Cloud Function) to enforce lock control and resolve simultaneous dialing conflicts.

### C. Signaling Cleanup & Connection Loss
* **Current Setup**: The signaling node uses Firebase Realtime Database's `onDisconnect().remove()` to clean up nodes when a client goes offline.
* **Impact**: If a client experiences a temporary network drop and re-establishes a connection within seconds, the `onDisconnect` hook may fire late or clean up the active call state unexpectedly, terminating an ongoing call. Alternatively, if the app crashes without cleanly disposing of the WebRTC PeerConnection, resource leaks can occur on the client side.
* **Stabilization Item**: Introduce heartbeat/keepalive mechanisms for signaling sessions rather than relying solely on raw connection states.

---

## 2. WebRTC Implementation Status

### A. P2P Data Channels Only (No Audio/Video Streams)
* **Current Setup**: Both `createOffer` and `createAnswer` in `WebRtcRepositoryImpl` explicitly disable audio and video negotiation:
  ```dart
  'mandatory': {
    'OfferToReceiveAudio': false,
    'OfferToReceiveVideo': false,
  }
  ```
  The connection only establishes a custom peer-to-peer data channel (`chat`):
  ```dart
  _dataChannel = await pc.createDataChannel('chat', RTCDataChannelInit());
  ```
* **Impact**: The actual voice and video transmission code has not been implemented. The WebRTC setup is currently built to establish low-latency P2P data channels, possibly for secure chat messaging, but does not support voice or video calls.
* **Stabilization Item**: Enable media capture and track injection (`getUserMedia`, `addTrack`) and set `OfferToReceiveAudio`/`OfferToReceiveVideo` to `true` when actual voice/video calls are initiated.

### B. Missing UI Renderers
* **Current Setup**: The codebase has no instances of `RTCVideoRenderer` or `RTCVideoView` widgets.
* **Impact**: Even if WebRTC media tracks were enabled, there is no UI component configured to render local or remote video feeds.
* **Stabilization Item**: Implement UI views containing `RTCVideoView` widgets with proper initialization, state handling, and disposal.

---

## 3. Web vs. Native CallKit Discrepancies

The presentation of incoming calls differs significantly between native platforms and Web/Desktop:

| Feature / Capability | Native (iOS) | Native (Android) | Web / Desktop |
| :--- | :--- | :--- | :--- |
| **Integration Hook** | Native Apple CallKit API | Native ConnectionService / Custom | Custom Overlay UI in Flutter |
| **UI Presentation** | System incoming call UI | System incoming call UI | Standard in-app Flutter banners |
| **Background / Terminated State** | Can wake the app via PushKit (VoIP) | Wakes app via background service/FCM | Cannot display call UI if browser/app is closed |
| **Silent Decline / OS Control** | Handled natively by OS dialer | Handled by CallKit Incoming package | No OS integration; must run in active session |

### A. Web & Desktop Stub Limitations
* `WebCallAdapter` and `DesktopCallAdapter` are currently empty stubs:
  ```dart
  class WebCallAdapter implements CallPresentationAdapter {
    @override
    Stream<ck.CallEvent?>? get onEvent => const Stream.empty();

    @override
    Future<void> showIncomingCall({required String callId, required String callerName, required String type}) async {}
    // ...
  }
  ```
* If the user is on a web browser or desktop app and does not have the app open in an active foreground tab, they will miss calls entirely since push notifications cannot wake up a native calling experience on those platforms without active browser service workers.

### B. iOS PushKit (VoIP) Dependency
* **Issue**: iOS has strict requirements regarding background CallKit triggers. Incoming calls in a backgrounded or terminated state must be woken up using **Apple PushKit (VoIP)** push notifications (not standard APNs/FCM). 
* **Impact**: Once a VoIP push is received, the app *must* register the incoming call with CallKit within a few seconds, or iOS will crash the app process. The codebase currently lacks specific PushKit listener integration in the native Swift side of the runner, meaning background calls on iOS will fail or be highly unstable.
