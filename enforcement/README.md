# Enforcement Layer — Making SDD Non-Negotiable

> This folder turns SDD from *advice the AI may follow* into *gates that block
> non-compliance*. Markdown asks; these gates enforce.

## What's here

| File | Enforces | Type |
|---|---|---|
| `sdd/CONSTITUTION.md` | The R1–R7 rule **text** — merged into spec-kit's `.specify/memory/constitution.md`, which the gates read and `/speckit.analyze` treats as non-negotiable | Reference |
| `hooks/pre-implement.sh` | R1, R2 — no code without spec & plan | Local hook (blocks) |
| `hooks/pre-commit.sh` | R3, R4, R6 — no commit without passing verification | Local hook (blocks) |
| `hooks/post-task.sh` | R5 — warn on missing handoff | Local hook (warns) |
| `sync-check.sh` | R7 — all docs agree with SPEC.yml | Script + CI (blocks) |
| `github-workflows/sdd-gate.yml` | R1, R3, R6, R7 — non-bypassable merge gate | CI (blocks merge) |

> **SPEC.yml** (repo root) is the single source of truth for *facts* (instrument
> counts, sources, licenses, modes-absence). `sync-check.sh` verifies every document
> agrees with it. Change a fact in SPEC.yml, run sync-check, fix what it flags.

## Why both local hooks and CI

Local hooks give fast feedback but can be skipped (`git commit --no-verify`). The CI
gate cannot be skipped on a protected branch — it is the backstop that makes
enforcement real for shared code. Use both: hooks for speed, CI for guarantee.

## Install

```bash
# 1. Constitution: spec-kit owns it. Run /speckit.constitution to create
#    .specify/memory/constitution.md, then merge the R1–R7 rules from
#    enforcement/sdd/CONSTITUTION.md into it. The gates read that file, and
#    /speckit.analyze treats constitution rules as non-negotiable (CRITICAL).

# 2. Local hooks
mkdir -p .claude/hooks
cp enforcement/hooks/pre-implement.sh .claude/hooks/
cp enforcement/hooks/post-task.sh    .claude/hooks/
cp enforcement/hooks/pre-commit.sh   .git/hooks/pre-commit
chmod +x .claude/hooks/*.sh .git/hooks/pre-commit

# 3. CI gate
mkdir -p .github/workflows
cp enforcement/github-workflows/sdd-gate.yml .github/workflows/

# 4. Tell the gates how to verify your project
export SDD_TEST_CMD="npm test"      # or: pytest -q | go test ./... | cargo test
# For CI: set repo variable SDD_TEST_CMD (Settings → Actions → Variables)
```

Wire `pre-implement.sh` and `post-task.sh` to your Claude Code hooks (PreToolUse for
file writes, Stop for task completion). See Claude Code's hooks documentation for the
exact config location, as it may change over time.

## Levels

- **standard** (default): R1–R5; R3/R4 bypassable once with `SDD_OVERRIDE="reason"` (logged).
- **strict** (auto when production signals detected): R1–R6; no bypass.

## Honest caveat

These gates enforce **process minimums** (a spec exists, tests pass, behavior is
preserved). They cannot enforce *quality of thought* — a spec can exist and still be
shallow. The gates remove the easy failure modes (skipping tests, coding with no
plan); they do not replace human judgment or review.
