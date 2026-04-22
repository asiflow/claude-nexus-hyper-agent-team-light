# Claude Code 26-Agent Team — Light Edition

> A cost-conscious variant of the [31-agent Claude Code team](https://github.com/asiflow/claude-nexus-hyper-agent-team) distribution. Same runtime discipline, adversarial review, Bayesian trust calibration, NEXUS syscall protocol, and Shadow Mind cognitive layer — with the 5-agent BEAM/Elixir stack moved to an opt-in `_optional/` directory and a session-budget hook bundled in.

**If you work on a BEAM/Erlang/OTP platform, you want the [full 31-agent distribution](https://github.com/asiflow/claude-nexus-hyper-agent-team), not this one.**

**If you work on Go / Python / TypeScript services, K8s/GCP infrastructure, React/Next.js frontends, and AI-platform work — this is the lower-friction starting point.**

---

## What's the same as the full distribution

Everything that makes the full team worth using is preserved, unchanged:

- **Hook-enforced protocol** — `SubagentStop` hooks fire `exit 2` when agents skip closing-protocol sections. Agents can't talk their way past `exit 2`.
- **NEXUS syscall protocol** — privileged operations (spawn, scale, install MCP, ask user) are kernel-only; teammates emit `[NEXUS:*]` messages. Full syscall table + log in `CLAUDE.md`.
- **Evidence-validator + challenger verification gates** — every HIGH-severity finding routes through evidence-validator before reaching the user; every CTO synthesis gets stress-tested by challenger along 5 dimensions.
- **Bayesian trust ledger** — per-agent accuracy scored by evidence-validator verdicts; CTO weights conflicting findings by trust during synthesis. CLI: `agent-memory/trust-ledger/ledger.py`.
- **Pattern F self-improvement loop** — session-end consolidation: memory-coordinator + meta-agent drain the signal bus into per-agent memory + prompt evolutions.
- **Dynamic hiring pipeline** — `talent-scout` detects coverage gaps via 5-signal composite; `recruiter` runs an 8-phase pipeline (research → synthesis → contract tests → challenger review → atomic registration → probation). Proven end-to-end in the full distribution's production environment.
- **Shadow Mind — parallel cognitive layer** — Observer + Pattern Computer + Speculator + Dreamer + intuition-oracle. Production-validated (7,228+ observations, 154+ transitions, structured INTUIT_RESPONSE envelopes with honest INSUFFICIENT_DATA handling). Delete-to-disable without breaking the conscious team.
- **Contract tests on every commit** — 286 structural assertions (26 agents × 11 contracts) gate every agent-file edit.

---

## What's different (the "light" part)

### 1. 26 default agents instead of 31

5 BEAM-focused agents are moved to `_optional/beam-stack/`. They're not in the default roster, not in `CLAUDE.md`'s dispatch table, and not loaded per-session unless you enable them. If you don't use BEAM, you don't pay for them.

| Tier | Full distribution (31) | Light (26) |
|---|---|---|
| BUILDERS | 6 (incl. `beam-architect`, `elixir-engineer`, `go-hybrid-engineer`) | 3 (BEAM builders moved to `_optional/`) |
| GUARDIANS | 11 (incl. `beam-sre`) | 10 (`beam-sre` moved to `_optional/`) |
| INTELLIGENCE | 6 (incl. `erlang-solutions-consultant`) | 5 (`erlang-solutions-consultant` moved to `_optional/`) |
| STRATEGISTS / META / GOVERNANCE / CTO / VERIFICATION | 8 (unchanged) | 8 (unchanged) |

### 2. Bundled budget-awareness hook

`hooks/budget-enforcer.sh` — a `PostToolUse` hook that tracks Agent-dispatch count per session and warns at a configurable threshold. **It's not a dollar-cost meter** (a real one requires token accounting we haven't built yet), but it's a useful first-line signal for "this session is getting expensive."

Configure via `settings.json` env:

```json
{
  "env": {
    "TEAM_BUDGET_DISPATCH_THRESHOLD": "20",
    "TEAM_BUDGET_POLICY": "warn",
    "TEAM_BUDGET_VERBOSE": "0"
  }
}
```

Policies:
- `warn` (default) — logs a single warning at the threshold
- `halt` — exits 2 when threshold reached, blocking further Agent dispatches
- `off` — disables the hook

### 3. Simpler CLAUDE.md

Dispatch tables collapsed: 5 BEAM-specific rows consolidated into a single "requires enabling `_optional/beam-stack/`" row. Full roster block lists 26 default + 5 optional. Contract-test count updated everywhere from 341 → 286.

### 4. No BLOG_POST.md bundled

The full engineering writeup lives with the [full distribution](https://github.com/asiflow/claude-nexus-hyper-agent-team). The architecture, innovations, limitations, and production telemetry are all documented there — this repo is the trimmed runtime, not a re-told story.

---

## Enabling the BEAM stack (opt-in)

```bash
# From the repo root:
cp _optional/beam-stack/agents/*.md agents/
cp -R _optional/beam-stack/agent-memory/* agent-memory/ 2>/dev/null || true

# Update tests/agents/run_contract_tests.py CUSTOM_AGENTS list — add these 5 names:
#   beam-architect, elixir-engineer, beam-sre, go-hybrid-engineer, erlang-solutions-consultant

# Run contract tests to verify:
python3 tests/agents/run_contract_tests.py
# Expected: 341 passed, 0 failed  (== full distribution counts)
```

Then update your project's `CLAUDE.md` to restore the BEAM dispatch rows — the full distribution's `CLAUDE.md` has the reference template.

If you enable the BEAM stack, you've effectively upgraded to the full distribution — just use that repo instead.

---

## Installation

```bash
# 1. Copy the team into your project
cp -R claude-nexus-hyper-agent-team-light/agents           YOUR_PROJECT/.claude/agents/
cp -R claude-nexus-hyper-agent-team-light/hooks            YOUR_PROJECT/.claude/hooks/
cp -R claude-nexus-hyper-agent-team-light/tests            YOUR_PROJECT/.claude/tests/
cp -R claude-nexus-hyper-agent-team-light/docs             YOUR_PROJECT/.claude/docs/
cp -R claude-nexus-hyper-agent-team-light/agent-memory     YOUR_PROJECT/.claude/agent-memory/
cp    claude-nexus-hyper-agent-team-light/settings.json    YOUR_PROJECT/.claude/settings.json
cp    claude-nexus-hyper-agent-team-light/CLAUDE.md        YOUR_PROJECT/CLAUDE.md

# 2. Verify installation
python3 YOUR_PROJECT/.claude/tests/agents/run_contract_tests.py
# Expected: 286 passed, 0 failed

# 3. Optional — install the git pre-commit hook for agent contract tests
ln -s ../../.claude/hooks/pre-commit-agent-contracts.sh YOUR_PROJECT/.git/hooks/pre-commit

# 4. Optional — tune the budget-awareness hook
# (wired by default in settings.json; adjust TEAM_BUDGET_DISPATCH_THRESHOLD)
```

---

## Prerequisites

- **Claude Code CLI v2.1.32+** for team-mode NEXUS syscalls
- Python 3.8+ (contract tests + trust-ledger CLI)
- `jq` (hooks parse JSON from Claude Code)
- Unix shell (bash/zsh) — hooks are POSIX-compatible
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` to activate team-mode NEXUS (see [Anthropic's agent-teams docs](https://code.claude.com/docs/en/agent-teams))

---

## Known Limitations

Everything in the full distribution's limitations applies here too. Summary of the most important:

1. **Opus-heavy cost profile.** 23/26 default agents default to opus. The bundled `budget-enforcer.sh` dispatch-count hook is a first-line defense but not a real dollar-cost meter. Cost-sensitive deployments should either negotiate committed-use pricing with Anthropic or fork a sonnet-first variant.
2. **Structural contract tests, not behavioral regression.** 286/286 passing means every agent has the right sections, not that every agent produces the right findings. The trust ledger provides behavioral signal (accumulated during sessions via evidence-validator verdicts) but not a deterministic CI suite.
3. **Agent-teams is an experimental Claude Code feature.** If Anthropic ships breaking changes to `TeamCreate` / `SendMessage` semantics, team-mode NEXUS breaks. One-off mode is the fallback, always valid.
4. **N=1 by codebase.** The full distribution was developed on a single production codebase; light inherits that lineage. Multi-codebase transfer is unproven. The trust-ledger is the honest per-agent behavioral validation record.
5. **If your work drifts into BEAM territory**, enable `_optional/beam-stack/` (or just use the full distribution). Don't try to stretch non-BEAM agents onto BEAM work.

---

## Hiring growth path

Light is a starting point, not a final roster. `talent-scout` watches for coverage gaps in your project; when a gap crosses the 5-signal confidence threshold AND `session-sentinel` co-signs, `recruiter` runs the 8-phase pipeline to add the specialist.

Your light distribution can grow into:
- A 27-agent team (light + 1 hire, e.g. `rust-systems-engineer` for a Rust-heavy codebase)
- A 29-agent team (light + an AWS specialist + a data-engineering specialist)
- A 32-agent team (light + all 5 BEAM agents re-enabled from `_optional/` + 1 new hire)

The hiring pipeline doesn't care about starting size — it grows the roster based on your evidence.

---

## Directory structure

```
claude-nexus-hyper-agent-team-light/
├── CLAUDE.md                       # Team operating protocol (26-agent variant)
├── README.md                       # This file
├── LICENSE
├── agents/                         # 26 default agent definitions
├── _optional/
│   └── beam-stack/
│       ├── agents/                 # 5 BEAM agents (opt-in)
│       └── agent-memory/           # BEAM-specific memory scaffolds
├── hooks/                          # Runtime hooks (including budget-enforcer.sh)
├── tests/agents/
│   └── run_contract_tests.py       # 11 contracts × 26 agents = 286 assertions
├── docs/team/                      # Team documentation (unchanged from full)
├── agent-memory/                   # Per-agent memory + signal bus + trust ledger + Shadow Mind
├── settings.json                   # Hook wiring + budget env vars
└── settings.local.json             # Per-user overrides (gitignored)
```

---

## License

MIT — see `LICENSE` file.

## Built by

| | Name | Role | Links |
|---|---|---|---|
| <img src="https://media.licdn.com/dms/image/v2/C4E03AQH9_scF5V9bUw/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1582195036406?e=1778716800&v=beta&t=TWysGYjngmtdYdqRwsVkNv9FUvv9tbQjTT2dbLDJq-U" width="48" /> | **Sherief Attia** | CTO & Co-founder | [LinkedIn](https://www.linkedin.com/in/sheriefattia/) / [GitHub](https://github.com/SheriefAttia) |
| <img src="https://media.licdn.com/dms/image/v2/D4D03AQF3olDQ6AkP5Q/profile-displayphoto-crop_800_800/B4DZo0XgfPH0AM-/0/1761815172205?e=1778716800&v=beta&t=SYIKLllXxmcWteKD64GKNpWxSdKk_l6xAFjQPXIDlYQ" width="48" /> | **Khaled El Azab** | Chief of AI Strategies & Co-founder | [LinkedIn](https://www.linkedin.com/in/ikhaled-elazab/) / [GitHub](https://github.com/shw2ypro) |
| <img src="https://media.licdn.com/dms/image/v2/D4D03AQHZ0YySq3I_Xg/profile-displayphoto-crop_800_800/B4DZyU__W6IYAI-/0/1772026331936?e=1778716800&v=beta&t=qbDMWBFxEg7_sPBZj5O-_Aw5oyeMgoEy7IOEnoYEVNg" width="48" /> | **Hossam Hegazy** | Chief of Engineering & Co-founder | [LinkedIn](https://www.linkedin.com/in/hossam-hegazy-269745a4/) |

Derived from the [full 31-agent Claude Code team distribution](https://github.com/asiflow/claude-nexus-hyper-agent-team). Built while building [**ASIFlow**](https://asiflow.ai) — a sovereign AI agent platform.

## Contributing

- New agents: follow the existing frontmatter schema; contract tests will validate
- Hook improvements: keep hooks POSIX-compatible; use `$CLAUDE_PROJECT_DIR` for paths
- Pattern additions: update `CLAUDE.md` dispatch table
