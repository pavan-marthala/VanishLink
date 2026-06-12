# Integrations - VanishLink

This document details how external service platforms, native OS call handling packages, audio media components, and permission handlers are integrated within the VanishLink codebase.

---

## 1. Firebase Integration
VanishLink relies extensively on Firebase services to handle authentication, permanent user records, and real-time operations (signaling, presence tracking, messaging).

### A. Firebase Authentication (`firebase_auth`)
- **Initialization**: Triggered during bootstrap in `lib/main.dart` with environment configurations mapped via `firebase_options.dart`.
- **Purpose**: Authenticates user credentials, generates JWT tokens, and exposes state streams (`authStateChanges()`).
- **Usage**:
  - `AuthBloc` registers hooks to monitor changes in sign-in states.
  - `GoRouter` reads authorization status to dynamically redirect unauthenticated users to `/signin` / `/signup` pages and authenticated users to `/chats`.

### B. Firebase Realtime Database (`firebase_database`)
Low-latency sync is required for real-time signaling, typing indicators, read status counters, and presence trackers.

1. **Presence Monitoring (`presence/$userId`)**
   - **Fields**: `{ online: bool, lastSeen: timestamp }`
   - **Mechanics**:
     - Tracks user active status using Flutter's `WidgetsBindingObserver` to detect app lifecycle changes (`paused`, `resumed`, `detached`).
     - Listens to `.info/connected` status on RTDB.
     - Registers a `setupOnDisconnect()` listener, utilizing `onDisconnect().update(...)` to automatically switch status to `online: false` and set a final `lastSeen` timestamp when the socket connection drops.

2. **Call Signaling & Setup (`calls/$callId`)**
   - **Fields**: `{ callId, callerId, receiverId, type, status, createdAt, acceptedAt, endedAt, duration }`
   - **Mechanics**:
     - Establishes calls in `CallRepositoryImpl.createCall()` using `calls/$callId` nodes.
     - Updates states like `calling`, `ringing`, `accepted`, `declined`, `cancelled`, `ended`, or `busy`.
     - Watches incoming entries via `.orderByChild('receiverId').equalTo(userId)` to detect incoming calls.

3. **Message Sync (`messages/$chatId/$messageId`)**
   - **Fields**: `{ messageId, chatId, senderId, receiverId, type, content, createdAt, expiresAt, status, replies, reactions }`
   - **Mechanics**:
     - Pushes text messages directly under chat channels.
     - Handles ephemeral expirations (6-hour lifespan defaults) dynamically checked before displaying.
     - Performs real-time typing indicators (`typing/$chatId/$userId` sub-nodes) and increments/resets unread message logs (`unreadCounts/$userId/$chatId` nodes).

### C. Cloud Firestore (`cloud_firestore`)
Firestore is utilized for permanent data persistence.
- **`users` Collection**: Stores persistent user profile schemas (ID, Vanish ID, username, displayName, photoUrl, custom status logs).
- **`callHistory` Collection**: When calls terminate, call metadata logs are saved permanently under the Firestore `callHistory` collection for record audits.

---

## 2. Calling & Notification Services

### A. CallKit Integration (`flutter_callkit_incoming`)
To enable native call-screen UI overlays during call states when the device is locked or the app is running in the background.
- **`CallPresentationAdapter` Pattern**:
  - Defines platform-specific behaviors.
  - **`AndroidCallAdapter`**: Emits `CallKitParams` configuring ringtone assets, colors, and dynamic label buttons (`Accept`, `Decline`).
  - **`IOSCallAdapter`**: Passes `IOSParams` controlling custom ringtone paths, audio session configuration (44.1kHz sample rate, custom preferred buffer durations), and multigroup configurations.
  - **`WebCallAdapter` & `DesktopCallAdapter`**: Stub implementations that rely on responsive in-app screen widgets.
- **Event Mappings**: Listens to native `FlutterCallkitIncoming.onEvent` stream and dispatches BLoC events:
  - `CallEventActionCallAccept` -> `CallEvent.acceptCall()`
  - `CallEventActionCallDecline` / `CallEventActionCallTimeout` -> `CallEvent.declineCall()`
  - `CallEventActionCallEnded` -> `CallEvent.endCall()`

### B. Local Notifications (`flutter_local_notifications`)
Provides notification system integration for call states.
- **Service**: `CallNotificationService`
- **Incoming Calls**: Shows high-importance notifications configured with `fullScreenIntent` and category `AndroidNotificationCategory.call`.
- **Missed Calls**: Presents missed call info channels with priority high flags when calls expire or get declined.
- **Cleanups**: Dynamically triggers `cancel(id)` when calls connect or end.

---

## 3. Audio Support (`audioplayers`)
Audio playback integration for local ringing and dial tones.
- **Service**: `RingtoneService`
- **Mechanics**:
  - Configures an loop release mode (`ReleaseMode.loop`).
  - Plays `audio/ringtone.mp3` for incoming calls when the app is active in the foreground (`CallAudioType.incomingRingtone`).
  - Plays `audio/dialing_tone.mp3` for outgoing dials (`CallAudioType.outgoingDialTone`).
  - Automatically releases/stops resources when calls change status to connected, declined, ended, or failed.

---

## 4. Hardware Permissions (`permission_handler`)
System-level authorization request triggers before call initiations.
- **Audio Calls**: Dynamically checks and requests `Permission.microphone`.
- **Video Calls**: Dynamically checks and requests both `Permission.microphone` and `Permission.camera`.
- Prevents database call record creations if the caller does not grant required device permissions.
