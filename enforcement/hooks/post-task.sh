#!/usr/bin/env bash
# SDD post-task gate — enforces R5 (no silent handoff gaps).
# This is a WARNING, not a block: it reminds, it does not stop you.
#
# Install: copy to .claude/hooks/post-task.sh, make executable,
# wire to your Claude Code Stop / task-completion hook.
#
# Flow (top → bottom) / 흐름 (위 → 아래):
#   1. Resolve feature = current git branch (HEAD/unborn → none).
#      feature = 현재 git 브랜치 (HEAD/unborn → 없음).
#   2. No branch or no specs/<branch>/ dir → exit 0.
#      브랜치 없음 또는 specs/<branch>/ 없음 → exit 0.
#   3. R5: if specs/<branch>/handoff.md is missing or trivial (<20 words) → WARN only
#      (never blocks; exit 0 regardless).
#      R5: specs/<branch>/handoff.md 없음/빈약(20단어 미만) → 경고만 (절대 차단 안 함).

set -euo pipefail

# Feature = current git branch (spec-kit convention); artifacts under specs/<branch>/.
FEATURE_ID="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
[ "$FEATURE_ID" = "HEAD" ] && FEATURE_ID=""   # unborn/detached HEAD → no named feature branch
FEATURE_DIR="specs/$FEATURE_ID"
[ -n "$FEATURE_ID" ] && [ -d "$FEATURE_DIR" ] || exit 0

# handoff.md is this package's addition (spec-kit has no handoff artifact).
HANDOFF="$FEATURE_DIR/handoff.md"

if [ ! -f "$HANDOFF" ] || [ "$(wc -w < "$HANDOFF" 2>/dev/null || echo 0)" -lt 20 ]; then
  echo "⚠️  SDD (R5): feature '$FEATURE_ID' has no meaningful specs/$FEATURE_ID/handoff.md." >&2
  echo "    Next session will lack context. Consider running handoff." >&2
  echo "    (warning only — not blocking; see .specify/memory/constitution.md R5)" >&2
fi

exit 0
