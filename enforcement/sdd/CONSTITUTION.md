# Project Constitution — SDD Enforcement Rules (R1–R7)

> **This file is the rule text.** Its home at runtime is spec-kit's
> `.specify/memory/constitution.md`: run `/speckit.constitution`, then merge these
> R1–R7 rules into it. Both layers then enforce them — this package's hooks/CI gates
> (blocking) and spec-kit's `/speckit.analyze` (treats constitution rules as CRITICAL).
> Changing a rule here changes what the gates block. Loosening a rule loosens every gate
> that depends on it.

---

## 0. How enforcement works

SDD is not advisory. These rules are enforced by deterministic gates, not by asking the AI nicely:

- **Local hooks** (`.claude/hooks/`) block actions during a session.
- **CI gate** (`.github/workflows/sdd-gate.yml`) blocks merges.
- **spec-kit `/speckit.analyze`** flags constitution violations as CRITICAL (advisory).

If the AI (or a human) tries to skip a step, the gate fails and the action stops. The point is that compliance does not depend on the model remembering to comply.

---

## 1. Rules (RULE IDs are referenced by hooks)

### R1 — No code without a spec
Implementation files may not be created or modified for a feature that has no
`specs/<branch>/spec.md` (produced by spec-kit's `/speckit.specify`). Enforced by:
`pre-implement` hook (in-session) **and** `pre-commit` + CI gate (fail-closed: code
staged/changed without the branch's `spec.md` is blocked; not bypassable by override).

### R2 — No code without a plan
A feature being implemented must have `specs/<branch>/plan.md` (from `/speckit.plan`).
Enforced by: `pre-implement` hook **and** `pre-commit` + CI gate (same fail-closed check).

### R3 — No commit without passing verification
A commit touching implementation files must have a passing test/verification run.
A no-op test command (`true`, `:`, `echo …`) is rejected. Enforced by: `pre-commit`
hook + CI gate. (The no-op check is a best-effort denylist — it stops accidental/lazy
no-ops, not a determined evader who wraps a no-op, e.g. `bash -c true`.)

### R4 — Preserve existing behavior (context-dependent)
If the feature touches existing code, regression checks (`specs/<branch>/regression.md`,
this package's addition) must exist and pass before commit. On greenfield code with
nothing to preserve, this rule is satisfied trivially. Enforced by: `pre-commit` hook.
**Scope limit:** R4 fires only when a `survey.md` exists for the feature (the interview
turns the Step-0 survey on for existing-code projects). Without a survey, the gate cannot
tell that existing code was touched, so R4 does not trigger — keep the survey on for
legacy/maintenance work.

### R5 — No silent handoff gaps
Completing a feature without `specs/<branch>/handoff.md` (this package's addition) is
allowed but warned. Enforced by: `post-task` hook (warning, non-blocking).

### R6 — Production strictness
If production signals are detected (deploy configs, `.env.production`, etc.), R3 and
R4 are mandatory and non-bypassable. There is no "skip tests" path in production
context. Enforced by: all gates reading `ENFORCEMENT_LEVEL=strict`.

### R7 — Document synchronization
All documentation must agree with `SPEC.yml` (the single source of truth): instrument
counts, sources, licenses, mode-absence, bilingual pairing, and EN/KO heading
correspondence. Hardcoded star counts are forbidden (they drift). Enforced by:
`sync-check.sh` + CI gate. Note: this checks *structural* sync only — semantic
equivalence between languages still requires human review.

---

## 2. Enforcement level

```
ENFORCEMENT_LEVEL = standard   # default
ENFORCEMENT_LEVEL = strict     # auto-set when production signals are detected
```

- **standard**: R1–R5 apply; R3/R4 may be bypassed once with an explicit, logged override.
- **strict**: R1–R6 apply; R3/R4 cannot be bypassed.

> This is the *only* place context changes behavior — it raises or lowers the
> enforcement level (standard/strict) based on context, and changes nothing else.

---

## 3. Override (standard level only)

A bypass must be explicit and logged — never silent:

```
SDD_OVERRIDE="<reason>" git commit ...
```

Every override is appended to `DECISION-LOG.md` with timestamp and reason. Overrides
are impossible at `strict` level.

---

## 4. What this constitution does NOT do

- It does not make the AI "understand" your project — it makes non-compliance *fail*.
- It does not replace human review — it guarantees the minimums a reviewer would otherwise chase.
- It is not a substitute for tests — it refuses to proceed *without* them.
