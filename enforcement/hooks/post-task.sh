#!/usr/bin/env bash
# SDD post-task gate — enforces R5 (no silent handoff gaps).
# This is a WARNING, not a block: it reminds, it does not stop you.
#
# Install: copy to .claude/hooks/post-task.sh, make executable,
# wire to your Claude Code Stop / task-completion hook.

set -euo pipefail

# Feature = current git branch (spec-kit convention); artifacts under specs/<branch>/.
FEATURE_ID="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
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
