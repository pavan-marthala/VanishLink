# Requirements - VanishLink Calling & Audio Stabilization

This document tracks the requirements for the stabilized calling and audio feedback modules.

## R1: Web Calling Stabilization
- **R1.1**: Eliminate all `LegacyJavaScriptObject is not a subtype of CallEvent` type cast crashes by using a cross-platform parser (`safeMapCast`).
- **R1.2**: Ensure incoming call listeners do not terminate or abort on browser database maps.
- **R1.3**: Restore the incoming call custom overlay UI (Answer/Decline) for receivers using Web.

## R2: Audio Feedback & Separation
- **R2.1**: Replace low-quality or incompatible WAV assets with standard MP3 formats.
- **R2.2**: Play distinct audio for outgoing calls (`dialing_tone.mp3`) and incoming calls (`ringtone.mp3`).
- **R2.3**: Stop all active ringtones immediately on all termination state changes (`connected`, `declined`, `missed`, `ended`, `failed`, `cancelled`).
- **R2.4**: Keep background native CallKit ringtones operational while overriding app-level foreground audio.
