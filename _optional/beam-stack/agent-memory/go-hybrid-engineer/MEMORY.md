# Go Hybrid Engineer Memory Index

Memory store for Plane 2 (Go edge) boundary designs, Plane 1↔Plane 2 gRPC contracts, protobuf schema decisions, smart-agents Go codebase hardening progress (P0.1-P0.8), A2A cross-runtime parity contracts, Rust NIF brief templates, and inherited audit findings under remediation. CONDITIONAL agent — verify arbitration state on every dispatch.

## Arbitration State (CHECK FIRST ON EVERY DISPATCH)
- [project_arbitration_state.md](project_arbitration_state.md) — D3-hybrid vs D2-pure arbitration state. First action on dispatch: read RESUME_PROTOCOL for current status. If D2-pure wins, emit CONDITIONAL PAUSED and redirect to go-expert + elixir-engineer.

## Inherited Findings (Smart-Agents Go — 2026-04-17 go-expert audit)
- [reference_smart_agents_go_audit.md](reference_smart_agents_go_audit.md) — Pointer to go-expert's memory for 2026-04-17 audit findings: A2A shutdown race + 4 twin sites, middleware silent HS256 fallback, SSE streaming silent drop, executeDAG concurrent map race, symmetric fallback gap on ReadFile/CreateDirectory/SearchFiles handlers.

## Boundary Designs (gRPC Edges)

## Protobuf Contract Evolutions

## Smart-Agents P0 Hardening Progress

## A2A Cross-Runtime Parity Contracts

## Rust NIF Brief Templates

## Durable Patterns
