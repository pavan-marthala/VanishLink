# Core Integrations

VanishLink coordinates several real-time services, external APIs, and hardware peripherals. This document explains the integration flow for Firebase, WebRTC, CallKit, and Audio components.

---

## 1. Firebase Suite

VanishLink relies on Firebase as its primary backend, split across Authentication, Cloud Firestore, Realtime Database (RTDB), and Cloud Messaging.

### Firebase Authentication
- **Purpose**: Authenticates user credentials.
- **Flow**:
  - `AuthRemoteDataSource` signs in / signs up users via email/password.
  - On sign-up, `AuthRepositoryImpl` creates a corresponding profile document in Firestore and generates a random unique `vanishId` (e.g., `vanish_XXXXXX`).

### Cloud Firestore
- **Purpose**: Persistent transactional document storage for profiles and relationships.
- **Key Collections**:
  - `users`: Stores user status, username, display name, photo URL, public keys, and the unique `vanishId`.
  - `friend_requests`: Stores pending, accepted, or declined incoming/outgoing friendship requests.

### Firebase Realtime Database (RTDB)
- **Purpose**: High-speed, real-time sync for messaging, signaling, call status, and presence.
- **Data Nodes**:
  - `/presence/$userId`:
    - Tracks user connectivity status (`online`, `background`, `offline`).
    - Maps `lastSeen` timestamps and registers active device push tokens/permission statuses.
    - Utilizes `onDisconnect` handlers to automatically set user presence to offline when the socket connection drops.
  - `/signaling/$sessionId`:
    - Handles WebRTC SDP exchanges (`offer` and `answer`) and coordinates candidate pools (`callerCandidates` and `receiverCandidates`).
  - `/calls/$callId`:
    - Synchronizes call states (`created`, `ringing`, `accepted`, `declined`, `ended`, `busy`, `cancelled`).
    - Stores timestamps (`createdAt`, `acceptedAt`, `endedAt`) and final call `duration`.
  - `/messages/$chatId`:
    - Stores ephemeral message objects.
    - Messages contain `expiresAt` timestamps.
    - **Message Expiration**: The repository layer filters out messages whose `expiresAt` is in the past. Real database deletion is planned via a scheduled Firebase Cloud Function (run hourly) or client-side batch sweep on launch.
  - `/unreadCounts/$userId/$chatId`:
    - Counters incremented during message sends and reset upon reading a chat.

### Firebase Cloud Messaging (FCM)
- **Purpose**: Delivers foreground and background notifications for incoming messages and calls.
- **Flow**:
  - Managed by `NotificationService`.
  - Registers FCM tokens on login and token refresh, passing permission states to the presence registry.
  - Listens to foreground (`onMessage`), background tap (`onMessageOpenedApp`), and cold-launch (`getInitialMessage`) notifications.

---

## 2. WebRTC Integration (`flutter_webrtc`)

WebRTC enables real-time peer-to-peer audio and video calls.

- **Service**: `WebRtcService`
- **Negotiation Flow**:
  1. Caller creates a peer connection, registers local audio/video tracks, generates an SDP offer, and uploads it to `/signaling/$sessionId`.
  2. Receiver watches `/signaling/$sessionId` for the offer, applies it, registers local tracks, generates an SDP answer, and uploads it.
  3. Both parties listen for ICE candidate additions under `/signaling/$sessionId/callerCandidates` or `receiverCandidates` and add them to their respective peer connections.
- **Media**: Configured dynamically based on call type (audio-only or video/audio). Renders local and remote video streams using `RTCVideoRenderer` UI widgets.

---

## 3. CallKit Integration (`flutter_callkit_incoming`)

CallKit provides system-level incoming call interfaces on mobile devices.

- **Adapters**: Dynamic adapter resolution via `CallPresentationAdapter`:
  - **Android**: `AndroidCallAdapter` registers `AndroidParams` (logo, custom ringtone path, background color, accept/decline action text).
  - **iOS**: `IOSCallAdapter` configures `IOSParams` (system iconName, handleType, supportsVideo, audioSessionMode, ringtonePath).
  - **Web/Desktop**: Custom overlay widgets handle UI updates reactively.
- **Coordination**: `CallCoordinator` listens to event streams from `FlutterCallkitIncoming.onEvent` (e.g., accept call, decline call, mute/unmute, timeout) and triggers corresponding actions in `CallBloc` and RTDB `/calls/$callId`.

---

## 4. Audio Playback (`audioplayers`)

Handles custom ringtones and dialing feedback when the app is active.

- **Service**: `RingtoneService`
- **Assets**:
  - `assets/audio/ringtone.mp3`: Looped for incoming calls if the device is not handled by the system ringtone engine.
  - `assets/audio/dialing_tone.mp3`: Looped for outgoing call state until the receiver answers or declines.
