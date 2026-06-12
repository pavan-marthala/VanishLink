# Requirements - Presence V2 & Call Reachability Implementation

This document tracks the requirements for Milestone 2: Presence V2 and Call Reachability.

## R1: PresenceStatus Enum
- **R1.1**: Define standard `PresenceStatus` enum or model supporting `online`, `background`, and `offline` states.
- **R1.2**: Preserve backward compatibility with legacy `online` boolean values (e.g., if parsing old data where only `online` is a boolean).

## R2: RTDB Schema Updates
- **R2.1**: Update `presence/$userId` node to store `status` as a string (`online`, `background`, `offline`) instead of or alongside `online` boolean.

## R3: Presence Repository & Service Lifecycle
- **R3.1**: Update `PresenceRepository` to write string status values to the database.
- **R3.2**: Modify lifecycle handler in `PresenceService` to set state to `background` when the app is paused, instead of immediately marking them as `offline`.
- **R3.3**: Ensure `onDisconnect` transitions the database status to `offline`.

## R4: Call reachability Eligibility Logic
- **R4.1**: Update `CallCoordinator` to allow incoming/outgoing calls when user is `online` or `background`.
- **R4.2**: Block calls only if the receiver's presence status is explicitly `offline`.
