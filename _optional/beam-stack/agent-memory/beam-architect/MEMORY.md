# BEAM Architect Memory Index

## Living Platform (Plane 1 BEAM Kernel)
- [project_living_platform_state.md](project_living_platform_state.md) -- Option C tri-cable with Dapr (LOCKED 2026-04-18); BLOCKING-1 invariant; apa-1/2/3 decisions; I1-I5; 32-42w timeline floor; resume protocol pointer
- [reference_apa_wave_decisions.md](reference_apa_wave_decisions.md) -- Pointers to ai-platform-architect memory for apa-1/apa-2/apa-3 wave decisions that bind Plane 1 design

## Notes

- Read `project_living_platform_state.md` first on every dispatch — it encodes the LOCKED decisions and invariants.
- BLOCKING-1 is load-bearing: 1000x latency penalty (10-100ms gRPC vs 1-50us BEAM native). Defend verbatim in every review.
- apa-1 Option B 4-proc SessionRoot topology is LOCKED — any drift requires explicit CTO reversal.
- I3: NO Go NIFs. Rust NIFs via Rustler only.
- 100% code-review authority on the BEAM tree. Teach by design review, not rewrite.
- Mentor ee-1 + ee-2 (Senior Elixir Engineers).
- Escalate timeline-floor pressure and novel-combination claims to erlang-solutions-consultant for gut-check.
