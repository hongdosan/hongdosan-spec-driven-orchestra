# 🎼 Orchestra Guide — SDD and Its Skills

> **SDD is the framework — the conductor.** The other tools are not equals; they are **skills the conductor calls** when the score needs them.
> Applies universally: new, early, legacy, maintenance, or production projects (no modes — SDD adapts to context).
>
> **Rule R (defer to the originals).** This package does not re-explain spec-kit/harness; it invokes their real commands (`/speckit.*`) and adds only its own *delta* — blocking gates, orchestration order, legacy survey/regression, and Korean onboarding. Any Korean helper text is for human understanding only and non-authoritative; the installed spec-kit command definitions and the English source govern execution.

---

## 1. The Hierarchy — One Conductor, Several Instruments

There is exactly one framework here: **SDD (Spec-Driven Development)**. Everything else is a skill it invokes. This is not a democracy of five equal tools; it is a conductor directing instruments.

```
            🎼 SDD — THE FRAMEWORK (Conductor)
        Spec → Clarify → Plan → Tasks → Verify → Implement → Handoff
            + Enforcement layer (hooks / CI gates)
                          │
        ┌─────────────┬───┴───┬─────────────┐
        │             │       │             │
   🎻 Violin      🎹 Piano  🎺 Brass     🎸 Guitar
   Karpathy 4     grill-me  Handoff      Harness
   (quality)      (clarify) (handover)   (agent teams)
        └────────── skills the conductor calls ────────┘
```

The instruments never lead. SDD decides *when* a skill is needed and calls it; a skill never drives the flow on its own.

### The Conductor

| | Framework | Role | Source |
|---|---|---|---|
| 🎼 | **SDD** | The single framework. Owns the 7-step flow and the enforcement gates. | [github/spec-kit](https://github.com/github/spec-kit) |

### The Skills (called by SDD)

| Instrument | Skill | Called during | Source |
|---|---|---|---|
| 🎻 1st Violin | **karpathy-guidelines** | Implement — enforce 4 principles | [multica-ai](https://github.com/multica-ai/andrej-karpathy-skills) |
| 🎹 Piano | **grill-me** | Any step — remove ambiguity, on demand | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎺 Brass | **handoff** | Handoff — hand off work | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎸 Guitar | **harness** | Tasks — design an agent team for large tasks (optional, external) | [revfactory/harness](https://github.com/revfactory/harness) |

> **Adopt in tiers.** SDD always runs; the skills layer on as needed. **Tier 1**: SDD + 🎻 Karpathy + 🎹 grill-me. **Tier 2** adds 🎺 Handoff (verification is part of SDD's own flow). **Tier 3** adds 🎸 Harness (large/team work; optional & experimental). The framework is constant; only how many skills it calls changes.

---

## 2. Context Adaptation (no modes)

SDD does **not** branch into modes. It runs one flow and adapts to whatever it finds:

```
🎼 SDD assesses context at start (code size, git history, production signals)
   │
   ├─ Existing code present → a light survey precedes Specify
   │                          (understand before changing)
   ├─ Production signals     → enforcement gates tighten
   │                          (tests/regression become mandatory, not optional)
   └─ Greenfield             → same gates, but nothing to preserve, so they pass easily
```

Context never changes *what* SDD does — only **how strict the enforcement gates are**. The flow is single and universal.

---

## 3. The 7-Step Flow (single, universal)

There is one flow. SDD scales it to the work (full / mini / none), and adds context-driven steps when existing code is present — these are **not modes**, just the conductor responding to what it sees.

```
User request
    ↓
[SDD scales the flow]
    ├─ Full  → all of 1~7
    ├─ Mini  → 1, 6, 7 only
    └─ None  → code immediately (still under enforcement gates)

[Full SDD flow]
0. Survey*   🎼 (if existing code: understand before changing)
   ↓
1. Specify   🎼 (What & Why)
   ↓
2. Clarify   🎹 (grill-me — called on demand)
   ↓
3. Plan      🎼 (How)
   ↓
4. Tasks     🎼 (break down)
   ↓  └─ optional: 🎸 Harness — if a task is too large for one
   ↓              agent, design an agent team to split the work
5. Verify    🎼 (SDD-owned; verification criteria → 05-verify.md)
   ↓  └─ if existing code: also add regression checks
   ↓     (preserve existing behavior — B1, B2, ...)
6. Implement 🎻 (karpathy-guidelines + ⛔ gates: no code without spec/plan)
   ↓
7. Handoff   🎺 (handoff)
   ↓
⛔ Commit/PR gate: verification must pass, or the gate blocks it
```

> **\*Step 0 (Survey)** appears only when there is existing code to understand. On a greenfield project there's nothing to survey, so SDD skips it. No separate "rebuild mode" — the same flow simply includes a survey and regression checks when the context calls for them.

> **Provenance — what is spec-kit and what we added.** This 7-step flow is *our* orchestration, not a verbatim copy of spec-kit's commands. Steps that map directly to spec-kit commands: **Specify** (`/speckit.specify`), **Clarify** (`/speckit.clarify`), **Plan** (`/speckit.plan`), **Tasks** (`/speckit.tasks`), **Implement** (`/speckit.implement`). Steps **Survey (0)**, **Verify (5)**, and **Handoff (7)** are *our additions* — they are not spec-kit commands. Conversely, spec-kit's `/speckit.constitution` (its first step) and `/speckit.analyze` are not flow steps here: we reuse the constitution idea in `sdd/CONSTITUTION.md` rather than as a numbered step. "SDD owns the 7-step flow" means SDD conducts *this* sequence; it does not mean spec-kit defines these seven steps.

## 4. The Enforcement Layer — Why This Isn't Just Advice

A markdown file telling an AI "write a spec first" is a *request*. Over a long session the request fades, and the step gets skipped. SDD here is backed by **deterministic gates** that block non-compliance regardless of whether the model remembers the rule:

| Gate | Blocks | Rule |
|---|---|---|
| `pre-implement` hook | writing code before `01-spec.md` + `03-plan.md` exist | R1, R2 |
| `pre-commit` hook | committing implementation when verification hasn't passed | R3, R4 |
| `sdd-gate.yml` (CI) | merging a PR with no spec / failing tests — **non-bypassable** | R1, R3, R6 |
| `post-task` hook | (warns) finishing without a handoff | R5 |

The rules live in one place — `sdd/CONSTITUTION.md` — which the gates read. Context only changes **how strict** the gates are (production → `strict`, no bypass), never *what* they check. See the `enforcement/` folder for the actual scripts and install steps.

> This is the core of the approach: compliance does not depend on the AI choosing to comply. If the spec is missing, the implement step fails. If tests don't pass, the commit fails. The orchestra plays in time because the metronome is wired to the doors, not because the players promise to keep tempo.

---

## 5. Movement-by-Movement Guide

### 🎼 Movement 1: Specify

**Lead**: SDD

#### What it does
- Write 01-spec.md
- Articulate What & Why
- Define scope

#### Anti-Patterns
- ❌ Writing How prematurely
- ❌ Unbounded scope creep
- ❌ What without Why

---

### 🎹 Movement 2: Clarify

**Lead**: grill-me (Piano)

#### What it does
- Write 02-clarify.md
- Remove all ambiguity

#### Trigger
```
"grill me - F[ID] clarify"
```

#### Flow
1. AI asks 15-50 questions (with recommended answers)
2. User answers (or "yes")
3. Until decisions are clear
4. AI summary → 02-clarify.md

#### Anti-Patterns
- ❌ "Whatever"
- ❌ "Decide later"
- ❌ Reflexively rejecting recommendations

---

### 🎼 Movement 3: Plan

**Lead**: SDD

#### What it does
- Write 03-plan.md
- Tech selection
- Architecture

#### Other Instruments
- 🎻 Karpathy: review for a simpler approach
- 🎹 grill-me: trigger when tech is ambiguous

---

### 🎼 Movement 4: Tasks

**Lead**: SDD

#### What it does
- Write 04-tasks.md
- Break into 30min-2h units

#### Other Instruments
- 🎻 Karpathy: Goal-Driven → verification criteria per task
- 🎸 Harness: if a task is too large for a single agent → design an agent team

#### 🎸 When to bring in Harness (agent teams)
[Harness](https://github.com/revfactory/harness) is a meta-skill that designs domain-specific agent teams, defines specialized agents, and generates the skills they use. Reach for it when the broken-down tasks reveal that a single agent isn't enough — for example, work that naturally splits into distinct specialties (frontend / backend / QA), or a large research-and-build effort.

How it fits the flow:
- Trigger: `"Build a harness for this project"` / `"Design an agent team for this domain"`
- It generates `.claude/agents/` (agent definitions) and `.claude/skills/` (their skills)
- Pick an architecture pattern: Pipeline, Fan-out/Fan-in, Expert Pool, Producer-Reviewer, Supervisor, or Hierarchical Delegation
- The conductor (SDD) still owns the overall cycle; Harness only sets up the players for a heavy task

Skip it for ordinary tasks — a single agent under standard SDD is enough.

---

### 🎼 Movement 5: Verification

**Lead**: SDD (verification is part of SDD's own flow, not a separate skill; grill-me may assist)

#### What it does
- Write 05-verify.md
- Cover all 5 categories

#### Trigger
```
"grill me - F[ID] verification design"
```

#### The 5 Categories
1. Happy Path
2. Sad Path
3. Edge Cases
4. Adversarial
5. Performance

> **Source lineage.** These categories are not a cited external taxonomy. Four map to
> spec-kit's `spec-template.md` sections — Happy/Sad Path → Acceptance Scenarios (:34),
> Edge Cases → Edge Cases (:71), Performance → Success Criteria (:106) — and Adversarial
> maps to spec-kit's Red Team extension. Phase 3 of the migration folds these into `spec.md`
> directly; until then `05-verify.md` holds them.

---

### 🎼 Movement 5b: Regression (when existing code is touched)

**Lead**: SDD (with the Step 0 survey as input)

> Not a mode — this movement simply appears whenever the work touches existing
> code. On greenfield work it's absent. Enforced by R4: if a `00-survey.md` exists,
> a `05b-regression.md` must exist and pass before commit.

#### What it does
- Write 05b-regression.md
- Verify preservation of existing behavior

#### Work
1. Bring over "B1, B2, ..." (behaviors to preserve) from `00-survey.md`
2. Write a verification scenario for each behavior
3. Define gradual transition steps
4. Specify rollback scenarios

---

### 🎻 Movement 6: Implement

**Lead**: Karpathy's 4 (1st Violin)

#### What it does
- Write code
- Update 06-implementation-notes.md

#### Applying the 4 Principles

##### Think Before Coding
```
- State assumptions
- If ambiguous, grill-me
- Surface tradeoffs
```

##### Simplicity First
```
- Possible in 50 lines?
- Speculative features?
- Single-use abstraction?
```

##### Surgical Changes
```
- Only affected files?
- Protect adjacent code?
- Keep existing style?
```

##### Goal-Driven Execution
```
- Which H in the verification scenarios is satisfied?
- Is it verifiable?
```

#### When migrating existing code (context-driven, not a mode)
If Implement touches existing behavior, apply gradual-transition techniques:
- Strangler Fig pattern
- Feature Flag
- Branch by Abstraction

---

### 🎺 Movement 7: Handoff

**Lead**: handoff (Brass)

#### What it does
- Write 07-handoff.md
- Detect omissions
- Context for the next worker

#### Trigger
```
"grill me - F[ID] handoff"
```

#### Anti-Patterns
- ❌ "It works fine"
- ❌ "No real issues"
- ❌ Ending without next actions

---

## 6. Duets and Ensembles

### SDD + grill-me

The most common collaboration:
```
Ambiguity found during Specify
   ↓
grill-me auto-triggers
   ↓
Clarify, then update Spec
```

### Karpathy + Verification

Quality combo:
```
During verification design
   ↓
"Is it verifiable?" (Karpathy)
   ↓
If not verifiable, redesign
```

### grill-me + Handoff

Closeout combo:
```
Writing Handoff
   ↓
grill-me triggers
   ↓
Detect omissions → fill them
```

### Survey + Verification (when existing code is present)

Existing-code combo:
```
Step 0 Survey excavates existing behavior (B1, B2, ...)
   ↓
the verification step turns each into a regression scenario
   ↓
Gradual, safe transition (Strangler Fig / Feature Flag)
```

---

## 7. Real-World Scenarios (one flow, adapting to context)

Same SDD flow every time. What differs is only what the context adds — a survey when there's existing code, tighter gates in production. No modes.

### Greenfield: First Feature

```
User: "new feature [name]"

AI: [sdd-conductor] create F001-[name]/
    (no existing code → no Step 0 survey)
AI: 01-spec.md → 02-clarify.md (grill-me) → 03-plan.md
AI: 04-tasks.md → 05-verify.md (verification)
AI: 06-implement (karpathy-guidelines) → 07-handoff.md
    ⛔ gates: spec+plan before implement; tests before commit
```

### Existing / In-Progress Code

```
User: "improve feature X"

AI: 00-survey.md (understand current behavior first)
AI: 01-spec.md → ... → 04-tasks.md
AI: 05-verify.md + 05b-regression.md (preserve B1, B2, ...)
AI: 06-implement — Strangler Fig / Feature Flag if replacing behavior
    ⛔ R4 gate: regression must pass before commit
AI: 07-handoff.md
```

### Production Context

```
User: "fix the billing rounding bug"  (in a deployed service)

AI: detects production signals → ENFORCEMENT_LEVEL=strict (R6)
AI: 00-survey.md → 01-spec.md → ... → 05b-regression.md
AI: 06-implement
    ⛔ strict gates: tests + regression MANDATORY, no override path
AI: 07-handoff.md
```

> Notice: the steps are the same. Production didn't trigger a different "mode" —
> it raised the enforcement level so the existing gates became non-bypassable.

---

## 8. Anti-Orchestra

> Note: deliberately staying in a lower tier is **not** an anti-pattern — it's encouraged. The anti-patterns below are about *ignoring a tool you've already committed to using*, not about choosing a smaller tier.

### When Instruments Conflict
The tools can pull against each other. Resolve predictably:
- 🎹 grill-me's relentless questioning vs a "move fast" priority → for trivial work, drop to Tier 1; grill-me is for decisions that matter.
- 🎼 Verification rigor vs speed → match verification depth to risk, not to ceremony.
- 🎸 Harness (multi-agent) vs simplicity → default to a single agent; only split when the task truly demands it.
- **Rule of thumb**: when in doubt, prefer the lower tier and the user's explicit intent over maximal process.

### Solo Playing (within a tier you've adopted)
- ❌ Committed to SDD but ignoring its flow
- ❌ Using grill-me's output then discarding the decisions
- ❌ Cherry-picking templates while violating the Constitution

### Dissonance
- ❌ Ignoring Spec decisions during Implement
- ❌ PR-ing while ignoring verification
- ❌ False info in Handoff

### Ignoring the Beat
- ❌ Plan without Clarify
- ❌ Implement without Plan
- ❌ PR without verification design
- ❌ Touching existing code without a Step 0 survey

### Ignoring the Conductor
- ❌ Working outside sdd/features/
- ❌ Ignoring templates
- ❌ Violating the Constitution

---

## 9. Learning Curve

### First Week
- Don't use Full SDD too often
- Get used to it with 1-2 Mini SDDs
- Read CLAUDE.md, ORCHESTRA-GUIDE.md thoroughly

### First Month
- Full SDD 2-3 times
- Make updating DECISION-LOG.md a habit

### Afterward
- Natural flow
- The gates become invisible — you stop noticing them because you're never fighting them

### When working with existing code
- Understand the Strangler Fig pattern
- Leverage Feature Flags
- Branch by Abstraction

---

## 10. As the Project Evolves (no mode switching)

Because there are no modes, there is nothing to "switch". The same SDD flow follows the project through its whole life; only two things shift, automatically:

```
Project grows / gains existing code
   → Step 0 survey starts appearing before Specify
   → regression checks (R4) start applying

Project gets deployed (production signals)
   → ENFORCEMENT_LEVEL rises to strict (R6)
   → tests/regression become non-bypassable
```

No tone changes, no mode migration, no CONSTITUTION rewrite. The framework is constant; the context dials the strictness. This is the whole point of dropping modes — there is never a "we've outgrown our mode" moment.

---

## 11. A Final Word

> The goal is **not fast code, but code and context that stay solid over time** — and gates that make that the path of least resistance rather than a promise.
>
> SDD holds the baton. The skills play only when called. The gates keep everyone in time. That's not a democracy of tools — it's one framework with instruments at its command.
>
> New, legacy, or production — the framework never changes; only how strictly it holds the line.

🎼
