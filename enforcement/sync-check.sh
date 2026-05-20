#!/usr/bin/env bash
# sync-check — enforces R7 (document synchronization) against SPEC.yml (SSOT).
#
# Runs the cross-checks we used to do by hand: instrument counts, sources,
# bilingual pairing, EN/KO heading correspondence, forbidden hardcoded stars,
# and code-fence balance. Exit non-zero = docs are out of sync = block merge.
#
# Scope: structural synchronization only. Semantic equivalence ("do these two
# sentences mean the same thing") still needs human review — see README.
#
# Usage: ./sync-check.sh [doc_dir]   (default: current dir)

set -uo pipefail

DOC_DIR="${1:-.}"
SPEC="$DOC_DIR/SPEC.yml"
FAIL=0

red()  { echo "❌ $1"; FAIL=1; }
ok()   { echo "✅ $1"; }
info() { echo "ℹ️  $1"; }

[ -f "$SPEC" ] || { echo "FATAL: SPEC.yml not found at $SPEC"; exit 2; }

# --- read canonical values from SPEC.yml (simple greps, no yaml dep) ---
N_SKILLS=$(awk '/^counts:/{f=1} f&&/skills:/{print $2; exit}' "$SPEC")
N_INSTR=$(awk '/instruments_total:/{print $2; exit}' "$SPEC")
N_STEPS=$(awk '/sdd_steps:/{print $2; exit}' "$SPEC")

echo "=== SSOT canonical values ==="
echo "skills=$N_SKILLS  instruments_total=$N_INSTR  sdd_steps=$N_STEPS"
echo ""

# Document set (12 docs); adjust globs to your layout.
EN_DOCS=$(find "$DOC_DIR" -name '*.md' ! -name '*.ko.md' ! -name 'README.ko.md' ! -name 'SPEC*' ! -path '*/enforcement/*' ! -name '_*' 2>/dev/null)
KO_DOCS=$(find "$DOC_DIR" \( -name '*.ko.md' \) ! -name '_*' 2>/dev/null)

# --- CHECK 1: bilingual pairing (every EN doc has a KO counterpart) ---
echo "=== Check 1: bilingual pairing ==="
for en in $EN_DOCS; do
  base=$(basename "$en" .md)
  dir=$(dirname "$en")
  if [ "$base" = "README" ] && [ "$dir" = "$DOC_DIR" ]; then
    ko="$dir/README.ko.md"        # root uses dot
  else
    ko="$dir/$base.ko.md"         # symphony uses dot
  fi
  [ -f "$ko" ] && ok "pair: $(basename "$en") ↔ $(basename "$ko")" || red "missing KO pair for $en"
done
echo ""

# --- CHECK 2: forbidden hardcoded star counts ---
echo "=== Check 2: no hardcoded star counts (stars drift; use qualitative maturity) ==="
# Match real star notations only, using ASCII-safe anchors to avoid false positives
# on ordinary numbers (e.g. "7 steps", "Tier 2"):
#   - a number immediately followed by a star glyph: 138k★ / 2⭐
#   - a number followed by the word star(s): "~2 stars", "3.5k stars", "84k star"
#   - Korean "약 N★" / "별 N개"
# fgrep the star glyph first (byte-safe), then refine.
STAR_HITS=$(
  { grep -rnoE '[0-9]+(\.[0-9]+)?k?[[:space:]]?(stars?|개 ?★|★|⭐)' $EN_DOCS $KO_DOCS 2>/dev/null \
      | grep -E '(star|★|⭐)'; } || true
)
if [ -n "$STAR_HITS" ]; then
  red "hardcoded star counts found (forbidden by SPEC.yml):"
  echo "$STAR_HITS"
else
  ok "no hardcoded star counts"
fi
echo ""

# --- CHECK 3: instrument count consistency ---
echo "=== Check 3: instrument/skill counts match SSOT ==="
# Any doc that states a number of instruments must say $N_INSTR, not 5.
BAD_COUNT=$(grep -rnoE '\b5 (instruments|powerful|AI coding)' $EN_DOCS 2>/dev/null || true)
[ -z "$BAD_COUNT" ] && ok "no stale '5 instruments' claims" || { red "stale instrument count (should be $N_INSTR):"; echo "$BAD_COUNT"; }
echo ""

# --- CHECK 4: no leftover modes (SPEC says modes: none) ---
echo "=== Check 4: no mode references (SSOT: modes=none) ==="
MODE_HITS=$(grep -rln 'MODE_GREENFIELD\|MODE_EARLY\|MODE_REBUILD' $EN_DOCS $KO_DOCS 2>/dev/null || true)
[ -z "$MODE_HITS" ] && ok "no mode references" || { red "mode references remain (SSOT forbids modes):"; echo "$MODE_HITS"; }
echo ""

# --- CHECK 5: source/license accuracy for each skill ---
echo "=== Check 5: skill sources present where expected ==="
for src in github/spec-kit multica-ai/andrej-karpathy-skills mattpocock/skills revfactory/harness; do
  CNT=$(grep -rl "$src" $EN_DOCS 2>/dev/null | wc -l | tr -d ' ')
  [ "$CNT" -gt 0 ] && ok "$src referenced in $CNT EN doc(s)" || red "$src not referenced in any EN doc"
done
# Harness must be Apache-2.0 wherever its license appears
BADLIC=$(grep -rn 'revfactory/harness' $EN_DOCS $KO_DOCS 2>/dev/null | grep -i 'MIT' || true)
[ -z "$BADLIC" ] && ok "Harness never mislabeled MIT" || { red "Harness mislabeled (should be Apache-2.0):"; echo "$BADLIC"; }
echo ""

# --- CHECK 6: EN/KO heading-count correspondence (symphony pairs) ---
echo "=== Check 6: EN/KO heading correspondence (symphony) ==="
for en in $EN_DOCS; do
  base=$(basename "$en" .md); dir=$(dirname "$en")
  [ "$base" = "README" ] && [ "$dir" = "$DOC_DIR" ] && continue   # root readmes differ by design
  ko="$dir/$base.ko.md"; [ -f "$ko" ] || continue
  e=$(grep -cE '^#{1,4} ' "$en"); k=$(grep -cE '^#{1,4} ' "$ko")
  [ "$e" = "$k" ] && ok "$base: EN=$k KO=$k headings" || red "$base heading mismatch: EN=$e KO=$k"
done
echo ""

# --- CHECK 7: code-fence balance ---
echo "=== Check 7: code-fence balance ==="
FENCE_BAD=0
for f in $EN_DOCS $KO_DOCS; do
  c=$(grep -c '^```' "$f")
  [ $((c % 2)) -eq 0 ] || { red "odd code fences in $f ($c)"; FENCE_BAD=1; }
done
[ $FENCE_BAD -eq 0 ] && ok "all fences balanced"
echo ""

# --- result ---
if [ $FAIL -eq 0 ]; then
  echo "🟢 sync-check PASSED — documents are synchronized with SPEC.yml (R7)."
  exit 0
else
  echo "🔴 sync-check FAILED — fix the items above. Docs are out of sync (R7)."
  echo "   Remember: structural checks only; semantic review is still required."
  exit 1
fi
