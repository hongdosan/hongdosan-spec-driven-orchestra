#!/usr/bin/env bash
# SDD post-task gate — enforces R5 (no silent handoff gaps).
# This is a WARNING, not a block: it reminds, it does not stop you.
#
# Install: copy to .claude/hooks/post-task.sh, make executable,
# wire to your Claude Code Stop / task-completion hook.

set -euo pipefail

SDD_DIR="${SDD_DIR:-sdd}"
ACTIVE_FILE="$SDD_DIR/.active-feature"

[ -f "$ACTIVE_FILE" ] || exit 0
FEATURE_ID="$(cat "$ACTIVE_FILE" | tr -d '[:space:]')"
[ -n "$FEATURE_ID" ] || exit 0

HANDOFF="$SDD_DIR/features/$FEATURE_ID/07-handoff.md"

if [ ! -f "$HANDOFF" ] || [ "$(wc -w < "$HANDOFF" 2>/dev/null || echo 0)" -lt 20 ]; then
  echo "⚠️  SDD (R5): feature '$FEATURE_ID' has no meaningful 07-handoff.md." >&2
  echo "    Next session will lack context. Consider running handoff-writer." >&2
  echo "    (warning only — not blocking; see $SDD_DIR/CONSTITUTION.md R5)" >&2
fi

exit 0
