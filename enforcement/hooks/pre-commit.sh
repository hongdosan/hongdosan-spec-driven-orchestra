#!/usr/bin/env bash
# SDD pre-commit gate — enforces R1/R2 (no code without spec+plan), R3 (verification
# passes), R4 (regression for existing code), R6 (production strictness).
#
# Install: copy to .git/hooks/pre-commit (or wire via your hook manager),
# make executable (chmod +x). Blocks the commit if a rule fails.
#
# The test command is project-defined via $SDD_TEST_CMD (e.g. "npm test",
# "pytest -q", "go test ./..."). If unset, the gate refuses to assume success.
#
# Flow (top → bottom) / 흐름 (위 → 아래):
#   1. Detect production signals → raise level to strict (R6).
#      운영 시그널 감지 → 레벨을 strict로 (R6).
#   2. No implementation files staged → exit 0 (docs-only commits pass).
#      스테이징된 구현 파일 없음 → exit 0 (문서 전용 커밋 통과).
#   3. Resolve feature = current git branch; artifacts under specs/<branch>/.
#      feature = 현재 git 브랜치; 산출물은 specs/<branch>/.
#   4. R1/R2: require specs/<branch>/spec.md (non-trivial) + plan.md — NOT bypassable.
#      R1/R2: specs/<branch>/spec.md(비자명) + plan.md 필수 — 우회 불가.
#   5. R3: SDD_TEST_CMD must be set and not a no-op (true / : / echo …).
#      R3: SDD_TEST_CMD 설정 + no-op(true / : / echo …) 아님.
#   6. standard + SDD_OVERRIDE set → log to DECISION-LOG.md and pass (covers R3/R4 only).
#      standard + SDD_OVERRIDE → DECISION-LOG.md 기록 후 통과 (R3/R4만 우회).
#   7. Run SDD_TEST_CMD; fail the commit if it fails (no bypass at strict).
#      SDD_TEST_CMD 실행; 실패 시 커밋 차단 (strict는 우회 없음).
#   8. R4: if specs/<branch>/survey.md exists, require regression.md.
#      R4: specs/<branch>/survey.md 있으면 regression.md 필수.

set -euo pipefail

LEVEL="${ENFORCEMENT_LEVEL:-standard}"
OVERRIDE="${SDD_OVERRIDE:-}"

fail() { echo "⛔ SDD COMMIT GATE BLOCKED: $1" >&2; echo "   See .specify/memory/constitution.md ($2)." >&2; exit 1; }
note() { echo "ℹ️  SDD: $1" >&2; }

# Detect production signals → force strict (R6)
if ls .env.production .env.prod docker-compose.prod.* 2>/dev/null | grep -q . \
   || find . -maxdepth 2 \( -name 'Dockerfile.prod*' -o -name '*.tf' -o -name 'Chart.yaml' \) 2>/dev/null | grep -q . \
   || ls -d k8s kubernetes helm 2>/dev/null | grep -q .; then
  LEVEL="strict"
  note "production signals detected → ENFORCEMENT_LEVEL=strict (R6); overrides disabled"
fi

# Are any implementation files staged? (skip gate for docs-only commits)
STAGED="$(git diff --cached --name-only || true)"
echo "$STAGED" | grep -qE '\.(py|js|ts|tsx|jsx|go|rs|java|kt|kts|swift|scala|cs|rb|php|c|cc|cpp|h|hpp|m|mm|vue|svelte|dart|ex|exs|sql|sh)$' || exit 0

# Feature = current git branch (spec-kit convention); artifacts under specs/<branch>/.
FEATURE_ID="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
[ "$FEATURE_ID" = "HEAD" ] && FEATURE_ID=""   # unborn/detached HEAD → no named feature branch
FEATURE_DIR="specs/$FEATURE_ID"

# R1/R2 — no code without spec + plan. NOT bypassable (override only covers R3/R4).
[ -n "$FEATURE_ID" ] || fail "implementation staged but not on a spec-kit feature branch (no specs/<branch>/)" "R1"
SPEC="$FEATURE_DIR/spec.md"; PLAN="$FEATURE_DIR/plan.md"
[ -f "$SPEC" ] || fail "implementation staged but $SPEC missing (run /speckit.specify on a feature branch)" "R1"
[ "$(wc -w < "$SPEC" 2>/dev/null || echo 0)" -ge 20 ] || fail "spec.md for '$FEATURE_ID' is effectively empty" "R1"
[ -f "$PLAN" ] || fail "implementation staged but $PLAN missing (run /speckit.plan)" "R2"

# R3 — verification must pass
if [ -z "${SDD_TEST_CMD:-}" ]; then
  fail "no verification command set (export SDD_TEST_CMD, e.g. 'npm test')" "R3"
fi
# Reject obvious no-ops that fake a pass (true, :, echo ...).
case "$(printf '%s' "$SDD_TEST_CMD" | tr -d ' ')" in
  true|:|echo*|''|exit0) fail "SDD_TEST_CMD looks like a no-op ('$SDD_TEST_CMD') — set a real test command" "R3" ;;
esac

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

# R4 — if feature touches existing code, regression must exist.
# (FEATURE_ID / FEATURE_DIR already resolved above.)
if [ -d "$FEATURE_DIR" ]; then
  REG="$FEATURE_DIR/regression.md"
  if [ -f "$FEATURE_DIR/survey.md" ] && [ ! -f "$REG" ]; then
    fail "existing code touched but specs/$FEATURE_ID/regression.md missing" "R4"
  fi
fi

exit 0
