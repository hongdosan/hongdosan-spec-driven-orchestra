#!/usr/bin/env bash
# SDD pre-commit gate — enforces R3 (no commit without passing verification),
# R4 (regression for existing code), and R6 (production strictness).
#
# Install: copy to .git/hooks/pre-commit (or wire via your hook manager),
# make executable (chmod +x). Blocks the commit if verification hasn't passed.
#
# The test command is project-defined via $SDD_TEST_CMD (e.g. "npm test",
# "pytest -q", "go test ./..."). If unset, the gate refuses to assume success.

set -euo pipefail

SDD_DIR="${SDD_DIR:-sdd}"
LEVEL="${ENFORCEMENT_LEVEL:-standard}"
OVERRIDE="${SDD_OVERRIDE:-}"

fail() { echo "⛔ SDD COMMIT GATE BLOCKED: $1" >&2; echo "   See $SDD_DIR/CONSTITUTION.md ($2)." >&2; exit 1; }
note() { echo "ℹ️  SDD: $1" >&2; }

# Detect production signals → force strict (R6)
if ls .env.production .env.prod docker-compose.prod.* 2>/dev/null | grep -q . \
   || find . -maxdepth 2 -name 'Dockerfile.prod*' 2>/dev/null | grep -q .; then
  LEVEL="strict"
  note "production signals detected → ENFORCEMENT_LEVEL=strict (R6); overrides disabled"
fi

# Are any implementation files staged? (skip gate for docs-only commits)
STAGED="$(git diff --cached --name-only || true)"
echo "$STAGED" | grep -qE '\.(py|js|ts|tsx|jsx|go|rs|java|rb|php|c|cc|cpp|h|hpp)$' || exit 0

# R3 — verification must pass
if [ -z "${SDD_TEST_CMD:-}" ]; then
  fail "no verification command set (export SDD_TEST_CMD, e.g. 'npm test')" "R3"
fi

if [ "$LEVEL" = "standard" ] && [ -n "$OVERRIDE" ]; then
  note "override accepted: \"$OVERRIDE\" — logging to DECISION-LOG.md"
  printf '%s | OVERRIDE | %s\n' "$(date -u +%FT%TZ)" "$OVERRIDE" >> DECISION-LOG.md
  exit 0
fi

note "running verification: $SDD_TEST_CMD"
if ! eval "$SDD_TEST_CMD"; then
  if [ "$LEVEL" = "strict" ]; then
    fail "verification failed at strict level — no bypass in production context" "R3/R6"
  fi
  fail "verification failed (set SDD_OVERRIDE=\"reason\" to bypass at standard level)" "R3"
fi

# R4 — if feature touches existing code, regression must exist
ACTIVE_FILE="$SDD_DIR/.active-feature"
if [ -f "$ACTIVE_FILE" ]; then
  FEATURE_ID="$(cat "$ACTIVE_FILE" | tr -d '[:space:]')"
  REG="$SDD_DIR/features/$FEATURE_ID/05b-regression.md"
  if [ -f "$SDD_DIR/features/$FEATURE_ID/00-survey.md" ] && [ ! -f "$REG" ]; then
    fail "existing code touched but 05b-regression.md missing for '$FEATURE_ID'" "R4"
  fi
fi

exit 0
