# Project: VanishLink

VanishLink is a secure cross-platform chat and calling application built using Flutter.

## Context
- **Repository**: `vanish_link`
- **Architecture**: Feature-first Clean Architecture (Domain, Data, Presentation)
- **Key Modules**:
  - **Auth**: Firebase Auth, splash flow, custom signIn/signUp routes.
  - **Chat**: Realtime chat repository, message expiry tracking (ephemeral messages).
  - **Presence**: Realtime user presence monitoring (online, lastSeen).
  - **Calling**: Realtime Database-driven call state synchronization, web incoming call UI (overlays), platform audio routing, and flutter_callkit_incoming for background native integration.

## Active Milestones
- **Milestone 1**: Web Calling & Audio Stabilization [COMPLETED]
- **Milestone 2**: Presence V2 & Call Reachability Implementation [ACTIVE]

## Guidelines
- Strict single active call policy.
- Clean separation of UI logic and business logic via BLoCs.
- Comprehensive platform adapters to decouple third-party plugins.
