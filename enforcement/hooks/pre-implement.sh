#!/usr/bin/env bash
# SDD pre-implement gate — enforces R1 (no code without spec) and R2 (no code without plan).
#
# Install: copy to .claude/hooks/pre-implement.sh, make executable (chmod +x),
# and wire it to your Claude Code PreToolUse hook for file-writing tools.
# It reads the active feature id from sdd/.active-feature (written at Tasks step).
#
# Exit non-zero = block the action. The point of R1/R2 is that implementation
# cannot start before Specify and Plan exist — enforced, not requested.

set -euo pipefail

SDD_DIR="${SDD_DIR:-sdd}"
ACTIVE_FILE="$SDD_DIR/.active-feature"

# No active feature declared → nothing to gate yet (e.g. pre-spec exploration).
[ -f "$ACTIVE_FILE" ] || exit 0
FEATURE_ID="$(cat "$ACTIVE_FILE" | tr -d '[:space:]')"
[ -n "$FEATURE_ID" ] || exit 0

FEATURE_DIR="$SDD_DIR/features/$FEATURE_ID"
SPEC="$FEATURE_DIR/01-spec.md"
PLAN="$FEATURE_DIR/03-plan.md"

fail() { echo "⛔ SDD GATE BLOCKED: $1" >&2; echo "   See sdd/CONSTITUTION.md ($2)." >&2; exit 1; }

# R1 — spec must exist and be non-trivial
[ -f "$SPEC" ] || fail "implementing '$FEATURE_ID' without 01-spec.md" "R1"
[ "$(wc -w < "$SPEC")" -ge 20 ] || fail "01-spec.md for '$FEATURE_ID' is effectively empty" "R1"

# R2 — plan must exist
[ -f "$PLAN" ] || fail "implementing '$FEATURE_ID' without 03-plan.md" "R2"

exit 0
