#!/usr/bin/env bash
# install.sh — place the Spec-Driven Orchestra package into a target project.
#
# SCOPE (intentionally narrow): this performs only the MECHANICAL file placement
# that the docs spell out as `cp` commands (Quick Start, enforcement/README,
# AI-EXECUTION Phase 1). It does NOT:
#   - install spec-kit (`uv tool install specify-cli ...`) — a documented prerequisite,
#   - run `specify init` (spec-kit, interactive) — runs later via Claude Code,
#   - create the skills under .claude/skills/ — authored during the AI flow,
#   - wire the hooks into Claude Code settings (PreToolUse/Stop) — see Claude Code docs.
# After this script, follow Quick Start Step 3: launch Claude Code with AI-INTERVIEW.
#
# Language: copies ONE language's docs (you pick), not both.
#   --lang en   (default; SPEC.yml languages.default = en)
#   --lang ko
#
# Usage:
#   ./install.sh [--lang en|ko] [TARGET_DIR]        # run from a clone/extract
#   curl -sL https://raw.githubusercontent.com/hongdosan/hongdosan-spec-driven-orchestra/main/install.sh \
#     | bash -s -- [--lang en|ko] [TARGET_DIR]      # one-liner (downloads a tarball)
# TARGET_DIR defaults to the current directory.

set -euo pipefail

REPO="hongdosan/hongdosan-spec-driven-orchestra"
BRANCH="main"
LANG_CHOICE="en"
TARGET=""

# --- args ---
while [ $# -gt 0 ]; do
  case "$1" in
    --lang) LANG_CHOICE="${2:-}"; shift 2 ;;
    --lang=*) LANG_CHOICE="${1#--lang=}"; shift ;;
    -h|--help) sed -n '2,30p' "$0"; exit 0 ;;
    -*) echo "Unknown option: $1" >&2; exit 2 ;;
    *) TARGET="$1"; shift ;;
  esac
done
TARGET="${TARGET:-$PWD}"
case "$LANG_CHOICE" in
  en|ko) ;;
  *) echo "Invalid --lang '$LANG_CHOICE' (use 'en' or 'ko')" >&2; exit 2 ;;
esac

# --- locate the package source: local checkout, else fetch a tarball ---
CLEANUP=""
cleanup() { [ -n "$CLEANUP" ] && rm -rf "$CLEANUP"; return 0; }
trap cleanup EXIT

# Korean docs carry a .ko suffix; English docs have none.
SUF=""; [ "$LANG_CHOICE" = "ko" ] && SUF=".ko"

SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]:-}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/symphony" ] && [ -d "$SCRIPT_DIR/enforcement" ]; then
  SRC="$SCRIPT_DIR"
else
  command -v curl >/dev/null 2>&1 || { echo "curl is required to fetch the package" >&2; exit 1; }
  command -v tar  >/dev/null 2>&1 || { echo "tar is required to extract the package"  >&2; exit 1; }
  CLEANUP="$(mktemp -d)"
  echo "Fetching $REPO@$BRANCH ..."
  curl -fsSL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" | tar xz -C "$CLEANUP"
  SRC="$CLEANUP/$(basename "$REPO")-$BRANCH"
fi

[ -d "$SRC/symphony" ] && [ -d "$SRC/enforcement" ] && [ -f "$SRC/SPEC.yml" ] \
  || { echo "Package source incomplete at: $SRC" >&2; exit 1; }

# Refuse to install into the package repo itself.
if [ -f "$TARGET/SPEC.yml" ] && [ "$(cd "$TARGET" && pwd)" = "$SRC" ]; then
  echo "Refusing to install into the package source directory." >&2; exit 1
fi

mkdir -p "$TARGET"
echo "Installing Spec-Driven Orchestra (--lang $LANG_CHOICE) into: $TARGET"

# --- 1. Methodology docs (chosen language only) ---
if [ "$LANG_CHOICE" = "ko" ]; then
  for f in "$SRC"/symphony/*.ko.md; do cp "$f" "$TARGET"/; done
else
  for f in "$SRC"/symphony/*.md; do
    case "$f" in *.ko.md) continue ;; esac
    cp "$f" "$TARGET"/
  done
fi

# --- 2. Constitution reference (for the documented /speckit.constitution merge) ---
#     R7/sync-check is package-internal (it validates THIS package's bilingual doc
#     set against SPEC.yml), so neither sync-check.sh nor SPEC.yml is copied here.
mkdir -p "$TARGET/enforcement/sdd"
cp "$SRC/enforcement/sdd/CONSTITUTION${SUF}.md" "$TARGET/enforcement/sdd/"

# --- 3. Local hooks (runtime locations) ---
mkdir -p "$TARGET/.claude/hooks"
cp "$SRC/enforcement/hooks/pre-implement.sh" "$TARGET/.claude/hooks/"
cp "$SRC/enforcement/hooks/post-task.sh"     "$TARGET/.claude/hooks/"
chmod +x "$TARGET/.claude/hooks/"*.sh
if [ -d "$TARGET/.git" ]; then
  if [ -e "$TARGET/.git/hooks/pre-commit" ]; then
    cp "$TARGET/.git/hooks/pre-commit" "$TARGET/.git/hooks/pre-commit.bak"
    echo "  (existing pre-commit backed up to pre-commit.bak)"
  fi
  cp "$SRC/enforcement/hooks/pre-commit.sh" "$TARGET/.git/hooks/pre-commit"
  chmod +x "$TARGET/.git/hooks/pre-commit"
  GIT_HOOK_NOTE="installed .git/hooks/pre-commit"
else
  GIT_HOOK_NOTE="SKIPPED pre-commit (no .git here) — run 'git init', then:
       cp enforcement/hooks/pre-commit.sh .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit"
fi

# --- 4. CI gate, with R7 stripped (doc-sync is package-internal, not portable) ---
#     Keeps R1/R2/R3 + production-level detection; drops the R7 step and its
#     flow-comment lines so the consumer gate has no sync-check dependency.
mkdir -p "$TARGET/.github/workflows"
awk '
  /^      - name: R7/ { skip=1; next }
  /^      - name: /   { skip=0 }
  /^#.*R7/            { next }
  skip                { next }
  { print }
' "$SRC/enforcement/github-workflows/sdd-gate.yml" > "$TARGET/.github/workflows/sdd-gate.yml"

# --- next steps (honest about what is NOT done) ---
if command -v specify >/dev/null 2>&1; then SPECIFY_NOTE="found"; else SPECIFY_NOTE="NOT found — install it"; fi

cat <<EOF

✅ File placement done. What was installed:
   - methodology docs (--lang $LANG_CHOICE)        → $TARGET/
   - enforcement/sdd/CONSTITUTION (--lang $LANG_CHOICE)
   - local hooks (pre-implement, post-task)        → .claude/hooks/
   - $GIT_HOOK_NOTE
   - CI gate (R1/R2/R3, R7 stripped)               → .github/workflows/sdd-gate.yml

Next steps (NOT done by this script — see Quick Start):
   1. spec-kit prerequisite ($SPECIFY_NOTE):
        uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
   2. Launch Claude Code and hand off:
        Read AI-INTERVIEW${SUF}.md and start the integration process.
        Assess the context, run \`specify init\`, install the enforcement gates, then proceed with SDD.
      Claude Code runs \`specify init\`, creates the skills, and wires the hooks.
   3. CI: set repo variable SDD_TEST_CMD (Settings → Actions → Variables) for R3,
      and enable required-PR branch protection to make the gate non-bypassable.

Note: R7 (document sync-check) is package-internal — it validates this package's own
bilingual doc set against SPEC.yml and is not meaningful in your project, so it is
omitted from the installed gate. The portable gates are R1/R2/R3 plus the local hooks.
EOF
