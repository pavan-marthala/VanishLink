# Architecture Documentation

This document explains the high-level architecture, design patterns, and main integration flows within the VanishLink codebase.

---

## 1. High-Level Patterns

The codebase is built on **Clean Architecture** principles and structured around **Feature-Driven Development**. It enforces strict separation of concerns through three distinct layers:

```
               ┌───────────────────────────────────────────────┐
               │              Presentation Layer               │
               │  (UI Screens, Widgets, Blocs, Events, States) │
               └───────────────────────┬───────────────────────┘
                                       │
                                       ▼ (depends on interfaces)
               ┌───────────────────────────────────────────────┐
               │                 Domain Layer                  │
               │    (Entities, Service Classes, Repositories)  │
               └───────────────────────▲───────────────────────┘
                                       │
                                       │ (implements interfaces)
               ┌───────────────────────┴───────────────────────┐
               │                  Data Layer                   │
               │  (DataSources, Models, Repo Implementations)  │
               └───────────────────────────────────────────────┘
```

- **Domain Layer**: The core business logic containing pure Dart code (no Flutter UI dependencies). It defines the data structures (Entities), business logic orchestrators (Services/Use Cases), and abstract definitions of how data is fetched (Repository interfaces).
- **Data Layer**: Implements the Domain repository interfaces. It manages raw data fetching from external resources (Firebase Firestore, Firebase Realtime Database) via DataSources, and handles serialization/deserialization (Models).
- **Presentation Layer**: The UI layer using Flutter widgets. It leverages the **BLoC (Business Logic Component)** pattern to manage state, transforming UI user actions (Events) into output states (States) that update the user interface reactively.

---

## 2. State Management (BLoC)

VanishLink relies on the `flutter_bloc` package to manage state reactively. Blocs act as the bridge between UI inputs and the business domain.

### Typical BLoC Execution Flow
1. **User Action**: The user interacts with a widget (e.g., clicks "Start Voice Call").
2. **Dispatch Event**: The Widget dispatches a typed Event (e.g., `CallEvent.createCall(...)`) to the BLoC.
3. **Business Logic Execution**: The BLoC handles the event, calls Domain services or repositories (e.g., `CallCoordinator` or `WebRtcService`), and tracks asynchronous progress.
4. **Emit State**: The BLoC yields a sequence of state configurations (e.g., `CallState.calling`, `CallState.connected`).
5. **UI Rebuild**: The UI listens to these states using `BlocBuilder` or `BlocListener` and updates dynamically.

---

## 3. Presence Service Flow

Real-time user presence (Online/Offline status) is critical for initiating call connections and is coordinated by `PresenceService` and `PresenceRepositoryImpl` using the **Firebase Realtime Database (RTDB)**.

```
       ┌────────────────────────┐
       │   PresenceService      │
       │ (WidgetsBindingObs)    │
       └───────────┬────────────┘
                   │
         Did app change state?
         ├─ Resumed:   goOnline() ──►  Updates DB (online: true) & Sets setupOnDisconnect()
         └─ Paused:    goOffline() ─►  Updates DB (online: false) & closes connection
```

### Steps in Presence Pipeline
1. **Lifecycle Monitoring**: `PresenceService` registers as a `WidgetsBindingObserver` to watch application state updates.
2. **Going Online**:
   - When the user logs in or the application resumes, `goOnline()` is called.
   - It sets the RTDB path `presence/$userId` status to `online: true` and writes the `lastSeen` timestamp.
   - Sets up an **`onDisconnect()` hook** in Firebase RTDB: if the TCP/WebSocket socket drops abruptly, Firebase automatically flags `online: false` server-side.
3. **Going Offline**:
   - When the app is paused, detached, or the user logs out, the service sets `online: false` and closes the RTDB connection.
4. **Reactive Listening**:
   - Widgets use `PresenceBloc` which invokes `PresenceRepository.watchPresence(userId)` to listen to status changes in real-time.

---

## 4. Call & WebRTC Flows

Call coordination involves managing permissions, background notifications, and establishing a peer-to-peer connection via WebRTC.

### Call Initiation Sequence
The call flow is coordinated by `CallCoordinator` to ensure single-call enforcement, network checks, and permission gates.

```
[Caller]                                                       [Receiver]
   │                                                               │
   │─── 1. Click Call ─────────────────────────────────────────────►
   │    (Busy check & verify Receiver Presence)                    │
   │                                                               │
   │─── 2. Request Permissions (Mic/Cam) ─────────┐                │
   │                                              │                │
   │◄── 3. Accept/Grant ──────────────────────────┘                │
   │                                                               │
   │─── 4. Dispatch CallEvent.createCall() ────────┐               │
   │                                               │ (Rings)       │
   │◄── 5. Play Ringtone / Open Signaling Session ─┘               │
   │                                                               │
   │─── 6. Notify Callkit / Remote DB Session ────────────────────►│
   │                                                               │ (Shows Incoming Screen / CallKit)
   │                                                               │─── 7. Accepts Call ───┐
   │                                                               │                       │
   │◄──────────────────────────────────────────────────────────────┼─── 8. Connect WebRTC ─┘
```

### WebRTC Connection Negotiation Flow
Once both parties are ready, `WebRtcService` starts the WebRTC SDP (Session Description Protocol) exchange and ICE candidate gathering:

```
Caller                                                     Receiver
  │                                                           │
  ├── 1. Create RTCPeerConnection                             │
  ├── 2. Create DataChannel ('chat')                          │
  ├── 3. Create SDP Offer                                     │
  ├── 4. Set Local Description (Offer)                        │
  ├── 5. Upload Offer to RTDB Session                         │
  │                                                           │
  │      [RTDB Signaling Session Updated]                     │
  │      ═════════════════════════════════════════════►       │
  │                                                           ├── 6. Create RTCPeerConnection
  │                                                           ├── 7. Set Remote Description (Offer)
  │                                                           ├── 8. Create SDP Answer
  │                                                           ├── 9. Set Local Description (Answer)
  │                                                           └── 10. Upload Answer to RTDB
  │      [RTDB Signaling Session Updated]                     │
  │      ◄════════════════════════════════════════════        │
  ├── 11. Set Remote Description (Answer)                     │
  │                                                           │
  │─── 12. Gather & stream local ICE Candidates ─────────────►│ (Add candidate)
  │◄── 13. Gather & stream remote ICE Candidates ─────────────│ (Add candidate)
  │                                                           │
  └─── Connection Connected (Peer-to-Peer) ◄──────────────────┘
```

1. **Role Determination**: `WebRtcService.connect()` checks if a signaling session document exists in the RTDB. If it's empty, the user acts as the **Caller**. If it exists, they act as the **Receiver**.
2. **SDP Negotiation**:
   - **Caller**: Instantiates `RTCPeerConnection`, adds a data channel, generates a local SDP offer, sets it locally, and publishes the offer to the signaling path.
   - **Receiver**: Downloads the offer, sets it as remote description, generates a local SDP answer, sets it locally, and uploads it to the signaling path.
   - **Caller**: Detects the answer, setting it as remote description.
3. **ICE Candidate Gathering**:
   - Both sides monitor the peer connection's `onIceCandidate` events.
   - Collected candidates are continuously pushed to the database (`callerCandidates` and `receiverCandidates`).
   - Each peer listens to the database stream and calls `addCandidate()` for incoming Ice Candidates, finalizing the Direct/P2P tunnel.
