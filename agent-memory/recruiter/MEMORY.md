# Recruiter Memory Index

## Overview

This is the persistent memory index for `recruiter` — the team's Deep Domain Research + Prompt Synthesis + Validated Hiring Execution engine. Recruiter owns the 8-phase hiring pipeline: intake → research → scar-tissue mining → synthesis → contract validation → challenger review → meta-agent handoff → probation tracking.

## Memory Directory Structure

- `.claude/agent-memory/recruiter/MEMORY.md` — this index
- `.claude/agent-memory/recruiter/drafts/` — per-requisition artifacts:
  - `<req-id>.brief.md` — DOMAIN BRIEF (10 KB research synthesis)
  - `<req-id>.inherited.md` — inherited scar-tissue bundle from adjacent agents
  - `<slug>.md.draft` — synthesized agent prompt draft (before meta-agent handoff)
  - `<req-id>.abort.md` — abort log if the requisition fails the 3-iteration contract cap
- `.claude/agent-memory/recruiter/probation/` — per-new-hire YAML state files:
  - `<slug>.yaml` — probation tracking (dispatch count, refutation rate, trust weight, evaluation state)

## Active Requisitions

_(none — recruiter is newly registered; first requisition expected from talent-scout)_

## Probation Tracking

_(none — no hires yet)_

## Seed Memories

- [project_hiring_pipeline_state.md](project_hiring_pipeline_state.md) — Current state of in-flight requisitions (initially empty with schema documentation)
- [reference_agent_template_dependency.md](reference_agent_template_dependency.md) — Points to `.claude/docs/team/AGENT_TEMPLATE.md` as the canonical skeleton dependency

## Requisition Outcomes Archive

_(none yet — log successes/aborts/rejections here as they occur)_

## Retirement Archive

_(none yet — log retirements here as they occur)_

## Pipeline Adaptations (Deviations From Canonical 8-Phase Flow)

_(none yet — record deviations with pattern-extension rationale so future requisitions can learn)_

## Notes

- AGENT_TEMPLATE.md at `.claude/docs/team/AGENT_TEMPLATE.md` is a BLOCKING dependency for recruiter. If missing or drifted, abort all requisitions and escalate to meta-agent for template repair.
- Single-writer invariant on `.claude/agents/*.md` is sacred: recruiter NEVER writes there. Always hand off finalized drafts to meta-agent via `[NEXUS:SPAWN] meta-agent | prompt=...`.
- Contract tests iteration cap is 3; after 3 consecutive failures, ABORT the requisition with a detailed failure log.
- Challenger gate is mandatory: every draft routes through challenger (7 dimensions). APPROVED or APPROVED_WITH_NOTES are the only verdicts that permit meta-agent handoff.
- Probation gate: 5 dispatches at ≤40% refutation rate + 10 dispatches at ≥0.5 trust weight. Failure triggers retirement via meta-agent.
