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
#
# Flow (top → bottom) / 흐름 (위 → 아래):
#   1. Resolve feature = current git branch (HEAD/unborn → none).
#      feature = 현재 git 브랜치 (HEAD/unborn → 없음).
#   2. No branch or no specs/<branch>/ dir → exit 0 (nothing to gate yet).
#      브랜치 없음 또는 specs/<branch>/ 없음 → exit 0 (아직 검사 대상 없음).
#   3. R1: specs/<branch>/spec.md must exist and be non-trivial (≥20 words).
#      R1: specs/<branch>/spec.md 존재 + 비자명(20단어↑).
#   4. R2: specs/<branch>/plan.md must exist.
#      R2: specs/<branch>/plan.md 존재.
#   (This is the in-session hook; pre-commit re-checks R1/R2 fail-closed at commit.)
#   (세션 중 훅이며, 커밋 시 pre-commit이 R1/R2를 fail-closed로 재확인함.)

set -euo pipefail

# Feature id = current git branch (spec-kit's NNN-slug convention).
FEATURE_ID="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
[ "$FEATURE_ID" = "HEAD" ] && FEATURE_ID=""   # unborn/detached HEAD → no named feature branch
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
