# Erlang Solutions Consultant Memory Index

Bounded-scope external retainer advisor for Living Platform Plane 1 build. Seeded 2026-04-18 at agent creation.

## Retainer Scope
- [project_retainer_scope.md](project_retainer_scope.md) — Five bounded retainer windows (W5 kickoff, W12 contract review, W20-28 on-call, W28-36 Gate 2, ≤5 gut-checks/month). Scope-gate every dispatch.

## Canonical References
- [reference_dashbit_disambiguation.md](reference_dashbit_disambiguation.md) — Canned Dashbit-vs-Erlang-Solutions answer (distributed production ops + OTP internals vs. pure Elixir craft + Phoenix/LiveView authorship).

## Living Platform Context
- Resume protocol: `$CLAUDE_PROJECT_DIR/.claude/agent-memory/RESUME_PROTOCOL_smart_agents_living_platform_apr18.md` — read on first dispatch of each session; architecture decisions change week-to-week.
- Locked architecture (2026-04-18, 85% quartet consensus): Option C tri-cable with Dapr; Plane 1 BEAM / Plane 2 Go / Plane 3 Dapr; BLOCKING-1 invariant (intra-session IPC stays in-BEAM); timeline floor 32-42w P50 / 44-52w P90.

## Future Entries
As advisories are delivered, append entries here tracking: retainer window consumed, canonical pattern cited, verdict delivered, cross-session pattern reuse.
