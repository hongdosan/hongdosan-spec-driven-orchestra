#!/usr/bin/env bash
# SDD pre-implement gate — enforces R1 (no code without spec) and R2 (no code without plan).
#
# Install: copy to .claude/hooks/pre-implement.sh, make executable (chmod +x),
# and wire it to your Claude Code PreToolUse hook for file-writing tools.
#
# The active feature follows spec-kit's convention: one git branch per feature
# (e.g. 001-create-taskify) with artifacts under specs/<branch>/ produced by the
# /speckit.* commands (spec.md, plan.md, tasks.md).
#
# Exit non-zero = block the action. The point of R1/R2 is that implementation
# cannot start before Specify and Plan exist — enforced, not requested.

set -euo pipefail

# Feature id = current git branch (spec-kit's NNN-slug convention).
FEATURE_ID="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
FEATURE_DIR="specs/$FEATURE_ID"

# No spec-kit feature directory for this branch → nothing to gate yet
# (e.g. pre-spec exploration, or a non-feature branch).
[ -n "$FEATURE_ID" ] && [ -d "$FEATURE_DIR" ] || exit 0

SPEC="$FEATURE_DIR/spec.md"
PLAN="$FEATURE_DIR/plan.md"

fail() { echo "⛔ SDD GATE BLOCKED: $1" >&2; echo "   See .specify/memory/constitution.md ($2)." >&2; exit 1; }

# R1 — spec must exist and be non-trivial
[ -f "$SPEC" ] || fail "implementing '$FEATURE_ID' without specs/$FEATURE_ID/spec.md" "R1"
[ "$(wc -w < "$SPEC")" -ge 20 ] || fail "spec.md for '$FEATURE_ID' is effectively empty" "R1"

# R2 — plan must exist
[ -f "$PLAN" ] || fail "implementing '$FEATURE_ID' without specs/$FEATURE_ID/plan.md" "R2"

exit 0
