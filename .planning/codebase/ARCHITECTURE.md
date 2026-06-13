# Architecture of VanishLink

This document outlines the architectural patterns, flow dynamics, and implementation details of the **VanishLink** application.

---

## 1. Architectural Blueprint: Clean Architecture

VanishLink is designed around the principles of **Clean Architecture**, enforcing a strict separation of concerns into three primary layers: **Domain**, **Data**, and **Presentation**. This isolation ensures that the business logic (Domain) remains pure and agnostic of outer concerns, while the UI (Presentation) and backend services (Data) can evolve independently.

```mermaid
graph TD
    subgraph Presentation Layer
        UI[Screens / Widgets] --> |events| BLoC[BLoC States & Events]
    end
    
    subgraph Domain Layer
        BLoC --> |invokes| Services[Domain Services / Use Cases]
        Services --> |defines| RepoInterfaces[Repository Interfaces]
        Services --> |manipulates| Entities[Entities]
    end
    
    subgraph Data Layer
        RepoImpl[Repository Implementations] --> |implements| RepoInterfaces
        RepoImpl --> |fetches| DataSources[Remote/Local Data Sources]
        DataSources --> |parses to| Models[Models]
        Models --> |translates to| Entities
    end
```

### Layer Boundaries
- **Domain Layer:** Containing only core entities, contract interfaces (repositories), and domain-specific services (e.g. `CallCoordinator`, `PresenceService`). It has zero dependencies on external frameworks, databases, or UI.
- **Data Layer:** Implements domain repository interfaces. Handles API calling, Firebase operations, and serialization logic (`Models` extending `Entities`).
- **Presentation Layer:** The Flutter UI layer. Standard UI controls and screens listen to the business logic components (BLoCs), which trigger updates based on domain logic.

---

## 2. State Management Pattern: BLoC

VanishLink relies on **BLoC (Business Logic Component)** for managing UI states reactively. 

Key BLoCs include:
- **`AuthBloc` / `SignInBloc`:** Manages user authentication, authorization state, registration, and Firestore profile synchronization.
- **`ChatsBloc`:** Handles the list of active chats, listing user matches, and overall conversation streams.
- **`MessageBloc`:** Manages real-time message streams, text inputs, vanishing timer transitions, and database persistence.
- **`PresenceBloc`:** Governs online, background, and offline presence status of contacts and friends.
- **`CallBloc` / `WebRtcBloc`:** Coordinates voice/video signaling states, incoming call requests, connection status updates, and peer negotiation states.

---

## 3. Real-Time Presence Flow

VanishLink maintains real-time user presence tracking through a combination of the application lifecycle observer and the **Firebase Realtime Database (RTDB)**.

```mermaid
sequenceDiagram
    participant App as App Lifecycle / PresenceService
    participant RTDB as Firebase RTDB (signaling/presence)
    participant FS as Firestore (user profiles)

    App->>App: startMonitoring() & authStateChanges()
    App->>RTDB: goOnline()
    App->>RTDB: setUserStatus(uid, "online")
    App->>RTDB: setupOnDisconnect(uid) -> remove or set "offline"
    App->>FS: updateDevicePushToken(FCM Token)
    
    Note over App,RTDB: App backgrounded (paused)
    App->>RTDB: setUserStatus(uid, "background")
    
    Note over App,RTDB: App closed or network lost
    RTDB->xRTDB: (Triggered onDisconnect) status -> "offline"
```

### Flow Breakdown
1. **Lifecycle Tracking:** `PresenceService` listens to Flutter's `WidgetsBindingObserver` to capture state transitions (`resumed`, `paused`, `detached`).
2. **Real-time Status Updates:** On `resumed`, the user is marked as `online` in RTDB. On `paused`, they are set to `background`. On `detached` or socket termination, RTDB automatically runs the `onDisconnect` hook to transition the state to `offline`.
3. **FCM Registration:** When the user connects, `PresenceService` requests push permissions, retrieves the FCM device token, and uploads the token alongside microphone/camera permissions to Firestore to facilitate signaling.

---

## 4. End-to-End Call Flow

Voice and video calls are orchestrated by the `CallCoordinator` using a combination of Firestore, Firebase Cloud Messaging (FCM), and CallKit/WebRTC.

```mermaid
sequenceDiagram
    participant Caller as Caller App (CallCoordinator)
    participant Signaling as Firebase RTDB (signaling/)
    participant FCM as Firebase Push Notification
    participant Receiver as Receiver App (CallCoordinator)

    Caller->>Signaling: createSession() (Status: dialing, write callerId)
    Caller->>FCM: Send FCM Push Notification payload (call request)
    FCM->>Receiver: Push Wakeup / CallKit Screen visible
    
    alt Accept Call
        Receiver->>Signaling: Update Session (Status: connecting/accepted)
        Receiver->>Caller: Start WebRTC Negotiation
    else Decline Call
        Receiver->>Signaling: Update Session (Status: declined)
        Caller->>Caller: Terminate Ringtone & Clean Session
    end
```

### Flow Breakdown
1. **Call Initiation:** The caller invokes the `CallCoordinator` to create a call session document in Firestore/RTDB. The state transitions to `calling`.
2. **Push Delivery:** The signaling push notification is sent to the recipient device (via APNs/FCM). On mobile, the `CallPresentationAdapter` intercepts this to trigger native CallKit UI.
3. **Call Accept/Decline:**
   - If **accepted**, the recipient launches the `CallScreen`, updating the call state to `connecting`, and triggers the WebRTC loop.
   - If **declined**, the session state is updated to `declined`, stopping ringtones on both sides and deleting the session.

---

## 5. WebRTC Negotiation Flow

WebRTC negotiation utilizes Firebase Realtime Database as the signaling channel to transfer SDP (Session Description Protocol) offers, answers, and ICE (Interactive Connectivity Establishment) candidates.

```mermaid
sequenceDiagram
    participant Caller as Caller WebRTC Service
    participant RTDB as Signaling Channel (RTDB)
    participant Receiver as Receiver WebRTC Service

    Caller->>Caller: Create PeerConnection & Local Media Stream
    Caller->>Caller: Create SDP Offer
    Caller->>RTDB: Send Offer (signaling/sessionId/offer)
    Caller->>RTDB: Send local ICE Candidates (callerCandidates/)
    
    RTDB->>Receiver: Detects Offer
    Receiver->>Receiver: Create PeerConnection & Local Media Stream
    Receiver->>Receiver: Set Remote Description (Offer)
    Receiver->>Receiver: Create SDP Answer
    Receiver->>RTDB: Send Answer (signaling/sessionId/answer)
    Receiver->>RTDB: Send local ICE Candidates (receiverCandidates/)

    RTDB->>Caller: Detects Answer
    Caller->>Caller: Set Remote Description (Answer)
    
    Note over Caller,Receiver: Ice candidate exchange completes. P2P Voice/Video stream begins.
```

### Key Elements of the Negotiation:
- **Signaling Channel:** Supported by `SignalingRepositoryImpl` which writes `offer`, `answer`, and pushes individual candidate objects to Firebase Realtime Database.
- **ICE Restart Capability:** Facilitated in WebRTC service to handle reconnection on network changes.
- **Clean Disconnection:** Once the call is ended, `deleteSession` cleans the RTDB signaling path, and the `RTCPeerConnection` is closed and garbage collected.
