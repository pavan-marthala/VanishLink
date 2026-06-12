# Roadmap - VanishLink Calling Stabilization

## Milestone 1: Web Calling & Audio Stabilization

### Phase 1: Web Calling Stabilization [COMPLETED]
- Implement safe map decoding to fix Web crashes.
- Restore incoming call overlays.
- Verify answer and decline behaviors.

### Phase 2: Call Audio Separation [COMPLETED]
- Introduce separate MP3 dialing and ringing assets.
- Route audio types based on role (caller vs receiver) and status (calling vs ringing).
- Enforce immediate release/stop on state changes.
