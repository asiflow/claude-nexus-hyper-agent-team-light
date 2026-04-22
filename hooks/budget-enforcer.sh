#!/usr/bin/env bash
# budget-enforcer.sh — PostToolUse hook for session cost awareness.
#
# MVP implementation: tracks dispatch count per session and warns when
# approaching a configurable threshold. Intended as a scaffold for a future
# token-accounting layer that tracks real dollar cost per dispatch.
#
# Configuration (settings.json env):
#   TEAM_BUDGET_DISPATCH_THRESHOLD  — warn threshold for Agent dispatch count (default 20)
#   TEAM_BUDGET_POLICY              — "warn" (default), "halt", or "off"
#   TEAM_BUDGET_VERBOSE             — "1" to log every dispatch (default off)
#
# State file: $CLAUDE_PROJECT_DIR/.claude/agent-memory/signal-bus/session-budget.json
#
# Honest limitations:
#   - This is a DISPATCH-COUNT heuristic, NOT a dollar-cost meter.
#     A single opus dispatch can cost 10x a sonnet dispatch; this script treats
#     them as equal. Real cost accounting needs hook-level token counting.
#   - Session boundaries are approximate. New Claude Code sessions reset the
#     counter; if the counter file is not cleaned, stale values persist.
#   - This hook is advisory. It does not prevent opus dispatches from running.
#     For hard enforcement, pair with a settings.json permissions policy.

set -euo pipefail

# Parse hook input (stdin JSON, format varies by Claude Code version)
INPUT=$(cat 2>/dev/null || echo "{}")

# Only count Agent tool invocations toward the dispatch budget
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // .toolName // empty' 2>/dev/null || echo "")
if [ "$TOOL_NAME" != "Agent" ]; then
  exit 0
fi

# Paths and configuration
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
BUDGET_FILE="${PROJECT_DIR}/.claude/agent-memory/signal-bus/session-budget.json"
THRESHOLD="${TEAM_BUDGET_DISPATCH_THRESHOLD:-20}"
POLICY="${TEAM_BUDGET_POLICY:-warn}"
VERBOSE="${TEAM_BUDGET_VERBOSE:-0}"

if [ "$POLICY" = "off" ]; then
  exit 0
fi

# Initialize state file if absent
if [ ! -f "$BUDGET_FILE" ]; then
  mkdir -p "$(dirname "$BUDGET_FILE")"
  printf '{"session_start":"%s","dispatch_count":0}\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$BUDGET_FILE"
fi

# Increment dispatch counter
CURRENT=$(jq -r '.dispatch_count // 0' "$BUDGET_FILE" 2>/dev/null || echo 0)
NEW=$((CURRENT + 1))
jq --argjson c "$NEW" '.dispatch_count = $c | .last_dispatch = now' "$BUDGET_FILE" > "$BUDGET_FILE.tmp" \
  && mv "$BUDGET_FILE.tmp" "$BUDGET_FILE"

if [ "$VERBOSE" = "1" ]; then
  echo "[budget] dispatch #$NEW (threshold $THRESHOLD)" >&2
fi

# Threshold check
if [ "$NEW" -ge "$THRESHOLD" ]; then
  case "$POLICY" in
    halt)
      echo "[budget] Session dispatch count $NEW reached threshold $THRESHOLD. Halting." >&2
      echo "[budget] To raise the threshold: export TEAM_BUDGET_DISPATCH_THRESHOLD=<n>" >&2
      echo "[budget] To disable: export TEAM_BUDGET_POLICY=off" >&2
      exit 2
      ;;
    warn)
      # Warn only at exact threshold to avoid spam on every subsequent dispatch
      if [ "$NEW" = "$THRESHOLD" ]; then
        echo "[budget] Session dispatch count reached $THRESHOLD. Consider reviewing scope." >&2
      fi
      ;;
  esac
fi

exit 0
