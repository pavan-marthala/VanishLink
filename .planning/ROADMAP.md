# Roadmap - VanishLink Calling Stabilization & Presence V2

## Milestone 1: Web Calling & Audio Stabilization [COMPLETED]

### Phase 1: Web Calling Stabilization
- Implement safe map decoding to fix Web crashes.
- Restore incoming call overlays.
- Verify answer and decline behaviors.

### Phase 2: Call Audio Separation
- Introduce separate MP3 dialing and ringing assets.
- Route audio types based on role (caller vs receiver) and status (calling vs ringing).
- Enforce immediate release/stop on state changes.

---

## Milestone 2: Presence V2 & Call Reachability Implementation [ACTIVE]

### Phase 3: Presence V2 Phase 1
- Replace boolean presence with status enum (`online`, `background`, `offline`).
- Update `PresenceRepository` and `PresenceService` lifecycle logic.
- Prevent background/paused apps from disconnecting and being marked offline immediately.
- Update `CallCoordinator` to allow calls to users who are `online` or `background`, blocking only when `offline`.
- Preserve backward compatibility with legacy boolean values.
