# 🎤 AI Entry — SDD Setup & Context Assessment

> **When Claude Code reads this file, it assesses context, installs the enforcement gates, then runs SDD (AI-EXECUTION.md).**
> There are no modes. The flow is always the same; the assessment only sets the enforcement level and whether a Step 0 survey is needed.

---

## 🎯 Mission

The purpose is to **assess the project's context** and configure SDD accordingly — not to pick a mode. Two things are decided:

```
1. Enforcement level:
   [ ] standard : default (R1–R5; R3/R4 bypassable once with logged override)
   [ ] strict   : auto when production signals detected (R1–R6; no bypass)

2. Does the flow need a Step 0 survey?
   [ ] yes : existing code present → understand before changing (adds survey, regression)
   [ ] no  : greenfield → nothing to preserve
```

The same SDD flow runs in every case. Context changes only *how strict the gates are*, never *what SDD does*.

---

## 1. Assessment Procedure

### Phase A: Auto-Scan (no user involvement)

Run the following:

```bash
# 1. Understand directory structure
ls -la
tree -L 3 -a -I 'node_modules|.git|venv|__pycache__|dist|build' 2>/dev/null || find . -maxdepth 3 -type d

# 2. Count code files
find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.tsx" -o -name "*.go" -o -name "*.rs" -o -name "*.java" \) | grep -v node_modules | grep -v .git | wc -l

# 3. Count documentation files
find . -type f -name "*.md" | grep -v node_modules | wc -l

# 4. Git status
git log --oneline 2>/dev/null | wc -l
git status --short 2>/dev/null | head -20

# 5. Check for production signals (→ sets enforcement level)
ls deploy* deployment* docker-compose.prod.* k8s/ kubernetes/ .env.production .env.prod 2>/dev/null
find . -name "Dockerfile.prod*" -o -name "docker-compose.prod*" -o -name "*production*" 2>/dev/null | head -5
grep -r "production" package.json 2>/dev/null | head -3

# 6. Check AI config
ls CLAUDE.md .claude/ 2>/dev/null

# 7. Search for existing handoff/harness
find . -type d \( -name "*handoff*" -o -name "*hand-off*" -o -name "*harness*" \) 2>/dev/null

# 8. Package info
cat package.json 2>/dev/null | head -20
cat pyproject.toml 2>/dev/null | head -20
cat Cargo.toml 2>/dev/null | head -20
```

### Phase B: Start the Assessment (report to user + ask)

Report the auto-scan results to the user in this format:

```markdown
## 🔍 Auto-Scan Results

### Project Overview
- **Location**: [current directory]
- **Type estimate**: [language/framework]
- **Code files**: __
- **Doc files**: __

### Git Status
- **Commits**: __
- **Current branch**: __
- **Uncommitted changes**: __

### Existing Assets
- **CLAUDE.md**: [present/absent]
- **.claude/ directory**: [present/absent]
- **handoff directory**: [present/absent + path]
- **harness directory**: [present/absent + path]

### Production Signals
- **production config**: [found/none]
- **deploy scripts**: [found/none]
- **production signal strength**: [high/medium/low/none]

---

## 🤖 AI's Assessment

Based on the above, my read is:

**Enforcement level**: [standard / strict (if production signals)]
**Step 0 survey**: [on (existing code) / off (greenfield)]
**Reasoning**: [specific reason]

I'll ask a few questions to confirm. Each question has a recommended answer —
if you agree, you can simply reply "yes".
```

### Phase C: Core Questions (5 required)

Ask these **in order**. One at a time; wait for an answer before the next.

#### 🚨 Q1: Production Signal Check (sets enforcement level)

```markdown
## Q1. Does this project match any of the following?

- [ ] A service currently used by real users
- [ ] Deployed to a production environment
- [ ] Directly affects revenue or business
- [ ] Holds external customer data
- [ ] A system where downtime is unacceptable

**AI recommendation**: [based on auto-scan — "yes" or "no"]

ℹ️ If any apply, SDD still applies — but at strict enforcement (non-bypassable gates).
```

**Handling**:
- If the user says "yes" or any item applies → set `ENFORCEMENT_LEVEL=strict` (not blocked), then proceed to Q2
- "no" / "none apply" → `standard`, proceed to Q2

#### 📊 Q2: Existing Code

```markdown
## Q2. What's the current state of the codebase?

A. 🌱 **Almost none** — kicking off with this integration
B. 🌿 **Some** — 1-2 weeks of work, structure forming
C. 🌳 **Substantial** — months of work, structure largely set
D. 🧱 **Legacy** — existing code you'll be changing carefully

**AI recommendation**: [based on code file count + Git commit count]

Reasoning:
- N code files, M commits → estimated [A/B/C/D]
```

**Handling** (sets whether Step 0 survey runs — not a mode):
- A → greenfield, survey **off**
- B/C/D → existing code present, survey **on** (adds survey, regression)

#### 🎯 Q3: Purpose of Adoption

```markdown
## Q3. What's the main reason for applying this package?

A. Want to set up a solid AI coding workflow from the very start
B. Made some progress but the direction is muddled — want to reorganize
C. Existing code/structure is too messy — starting over
D. Joining a team / forming a TF to adopt a new approach
E. Other

**AI recommendation**: [based on Q2 answer]

Reasoning:
- Q2 answer was [X] → [reason] is likely
```

**Handling**:
- Provides additional context on the goal
- Informs how thorough the survey/spec should be (no mode involved)

#### 📁 Q4: Existing Asset Handling

```markdown
## Q4. How should existing assets be handled?

Auto-scan results:
- Existing code: [N files]
- Existing docs: [M files]
- Existing handoff: [found/none]
- Existing harness: [found/none]

A. Leave everything as is, only add new structure
B. Back up everything to archive/ then rebuild with new structure
C. Keep existing code, but redo docs/structure
D. Archive everything and start fresh
E. Almost no existing assets (N/A)

**AI recommendation**: [based on Q2 answer]
```

**Handling**:
- Determines archive strategy (independent of enforcement level)
- B, D → create archive directory
- A, C, E → skip or partially apply archive

#### 👥 Q5: Work Style

```markdown
## Q5. What's the work style of this project?

A. Solo (personal side project)
B. Small group (2-5 people)
C. TF team (short-term focus)
D. Team (ongoing collaboration)

**AI recommendation**: [based on Git commit author diversity]

Reasoning:
- Number of Git commit authors: [N]
```

**Handling**:
- Adjust the tone of CLAUDE.md, CONSTITUTION.md
- Team work → reinforce conventions
- Solo → learning-friendly tone

### Phase D: (Optional) Supplementary Questions

Ask these **only if needed** (skip if the 5 above already make the setup clear):

#### Q6: Tech Stack Check (when auto-scan is unclear)

```markdown
## Q6. What's your primary tech stack?

- Frontend: ___
- Backend: ___
- DB: ___
- Other: ___

(skip if already identified by auto-scan)
```

#### Q7: Priority (when a qualitative call is needed)

```markdown
## Q7. What's the priority for integration?

A. Fast application (automate as much as possible)
B. Accurate application (precise even if it takes time)
C. Safe application (rollback-ability above all)

**AI recommendation**: [based on context]
- greenfield → A (fast)
- existing code → B (accurate)
- strict/production → C (safe)
```

### Phase E: Assessment Result + User Approval

After synthesizing answers, report in this format:

```markdown
## 🎯 Assessment Result

### Enforcement level: [standard / strict]
- **standard** by default
- **strict** auto-selected if production signals were detected in Phase A (Q1) → R3/R4 non-bypassable (R6)

### Step 0 survey: [needed / not needed]
- **needed** if existing code is present → adds `survey.md` + `regression.md` (R4)
- **not needed** for greenfield

### Recommended tier: TIER_[1/2/3]
- **Tier 1 (Core)**: SDD + Karpathy + grill-me — solo / small / early work
- **Tier 2 (Flow)**: + Handoff — needs repeatable structure & handoffs
- **Tier 3 (Full)**: + Harness — large features, team work
- Reasoning: [based on project size, work style (Q5), and complexity]
- 🎸 Harness (Tier 3) is suggested only if a task looks too large for a single agent; it's optional & experimental.

### Rationale
- Q1: production signals [yes → strict / no → standard]
- Q2: [answer] → existing code? [survey needed/not]
- Q3: [answer] → goal
- Q4: [answer] → archive strategy [yes/no]
- Q5: [answer] → tier signal

### Setup Plan

**1. Enforcement gates to install**
- `.claude/hooks/pre-implement.sh` (R1, R2)
- `.git/hooks/pre-commit` (R1, R2, R3, R4, R6)
- `.claude/hooks/post-task.sh` (R5)
- `.github/workflows/sdd-gate.yml` (R1, R2, R3, R6, R7)
- `.specify/memory/constitution.md` (the rules the gates read; R1–R7 text from `sdd/CONSTITUTION.md`)

**2. SDD templates to create**
- spec-kit's spec/plan/tasks always; this package's survey/regression if survey needed

**3. Existing assets to be handled**
[archive targets or none]

**4. First SDD cycle**
001-[slug]

**5. Starting tier**
TIER_[1/2/3] — you can climb later as needed

**6. Estimated time**
[10-30 min estimate]

### Approval Request

Shall I proceed with the setup above?

- "yes" / "go ahead" → install gates, then autonomous execution
- "modify [specific part]" → adjust plan and re-confirm
- "no" / "cancel" → stop

On approval, I'll install the enforcement gates and proceed with AI-EXECUTION.md.
```

### Phase F: Execution Start

After user approval:

```markdown
Approval confirmed. Installing enforcement gates, then starting AI-EXECUTION.md.

⏱️ When done, I'll run the Day 0 verification in INTEGRATION-CHECKLIST.md.

[Starting execution...]
```

→ From here, follow AI-EXECUTION.md

---

## 2. Production Context Handling (strict enforcement, not blocked)

If Q1 reveals production signals, **do not block**. Instead set `strict` and report:

```markdown
## 🔒 Production Context Detected → Strict Enforcement

This is a production project, so SDD applies with **strict** enforcement (not blocked).

### What "strict" means here
- R3 (tests pass) and R4 (regression preserves behavior) are **mandatory**
- No bypass: the `SDD_OVERRIDE` escape hatch is disabled
- A Step 0 survey runs before any change to existing code
- The pre-commit and CI gates will refuse anything that skips tests/regression

### Why not block?
Production is where safe AI-assisted change matters most. Rather than refuse, SDD
raises the bar so the gates become non-negotiable. The flow is the same as anywhere
else — only the strictness rises.

### Recommended approach (still your choice)
1. Start on a feature branch with no production impact
2. Apply SDD to one new feature first; let the gates prove themselves
3. Expand after team consensus

Proceeding with: enforcement level = **strict**, Step 0 survey = **on**.
```

**Handling**:
- Production signals → `ENFORCEMENT_LEVEL=strict`, proceed with the normal flow
- The gates (not a refusal) are what protect the production codebase

---

## 3. Context-Based Setup Guide

There are no modes to choose. Read the context signals and configure two things: the enforcement level and whether a Step 0 survey runs. The SDD flow itself is identical in every case.

### Signal → Enforcement level

| Signal | Level | Effect |
|---|---|---|
| Production signals (deploy configs, `.env.production`, `Dockerfile.prod`, etc.) | **strict** | R3/R4 mandatory, no bypass (R6) |
| None of the above | **standard** | R1–R5; R3/R4 bypassable once with logged override |

### Signal → Step 0 survey

| Signal | Survey | Adds |
|---|---|---|
| Existing code present (code files > ~10, or meaningful git history) | **on** | `survey.md`, `regression.md` (R4) |
| Greenfield (almost no code, no history) | **off** | nothing — flow starts at Specify |

### Always the same

Regardless of context:
- The 7-step SDD flow is the entry point (scaled full/mini/none by task size)
- The enforcement gates are installed (`pre-implement`, `pre-commit`, `post-task`, CI)
- `SPEC.yml` (package facts) and `.specify/memory/constitution.md` (R1–R7 rules) are the single sources of truth
- The first feature is just the first branch `001-[slug]` (no special bootstrap step)

### Tier (independent of context)

Recommend a starting tier from project size and work style, not from any mode:
- **Tier 1**: SDD + Karpathy + grill-me
- **Tier 2**: + Handoff
- **Tier 3**: + Harness (large/team work; Harness optional & experimental)

---

## 4. Assessment Cautions

### 🎯 What the AI MUST do

#### 1. One question at a time
- Don't dump all 5 at once
- Get an answer, then the next question
- Keep a natural conversational flow

#### 2. State reasoning for recommendations
- Don't just write "Recommendation: A"
- Write "Recommendation: A (reason: 8 code files suggests new)"

#### 3. Respect the user's answer
- The user's answer overrides the AI's guess
- But if clearly contradictory, confirm once more:
  "There are 50 code files — are you sure it's new?"

#### 4. Reinforce production detection (→ sets strict)
- If Q1 is ambiguous (e.g. "well..."), ask follow-ups
- If production signals exist but the user says "no", explicitly re-confirm:
  "There's a Dockerfile.prod — isn't this production? It would set strict enforcement."

### 🚫 What the AI must NOT do

- Skip the assessment and execute directly ✗
- Ignore the user's answer ✗
- Change the enforcement level silently after deciding ✗
- Treat production as a blocker instead of a strict-level signal ✗

---

## 5. Saving the Assessment Result

After the assessment, create this file:

### `INTERVIEW-RESULT.md`

```markdown
# Assessment Result

## Timestamp
YYYY-MM-DD HH:MM

## Auto-Scan Results
[Phase A results verbatim]

## Q&A Record

### Q1. Production Check
- Answer: [user answer]
- Result: enforcement level = [standard/strict]

### Q2. Existing Code
- AI recommendation: [rec]
- User answer: [answer]
- Step 0 survey: [on/off]

### Q3. Purpose
- AI recommendation: [rec]
- User answer: [answer]

### Q4. Existing Asset Handling
- User answer: [answer]
- Archive strategy: [strategy]

### Q5. Work Style
- User answer: [answer]
- Tier signal: [tier]

### (Optional) Q6, Q7
[if any]

## Configuration
- Enforcement level: [standard / strict]
- Step 0 survey: [on / off]
- Starting tier: TIER_[1/2/3]

## Rationale
- [reason 1]
- [reason 2]
- [reason 3]

## Setup Plan
[gates installed + templates created]

## User Approval
- Timestamp: YYYY-MM-DD HH:MM
- Response: Approved

## Next Step
Install enforcement gates, then proceed with AI-EXECUTION.md
```

This file is always created, with a summary also logged in DECISION-LOG.md.

---

## 6. After the Assessment

```markdown
## ✅ Assessment Complete

### Configuration
- Enforcement level: [standard/strict]
- Proceeding with AI-EXECUTION.md

### Assessment result saved
- File: INTERVIEW-RESULT.md

### Starting autonomous execution

Now proceeding autonomously with AI-EXECUTION.md under the configured enforcement level.

[Starting from Phase 1...]
```

---

## 7. Common Situations During the Interview

### Situation 1: User says "I'm not sure"

```
Response:
1. Adopt the AI's recommended answer as default
2. Log "user undecided, AI recommendation adopted" in INTERVIEW-RESULT.md
3. Move to the next question
```

### Situation 2: Contradictory answers

```
e.g. Q2=new, Q4=archive needed
Response:
1. Confirm once more
2. If intentional, proceed as is
3. If a mistake, correct it
```

### Situation 3: Strong production signals but user denies

```
e.g. Dockerfile.prod exists, .env.production present
Response:
1. Explicitly re-confirm:
   "There are production-related files — is this really not a production
    environment? Is it perhaps a project headed for production?"
2. If still "not production", proceed
3. Log "production signals found, user denied" in INTERVIEW-RESULT.md
```

### Situation 4: User changes their mind mid-assessment

```
e.g. Requests to revise Q2 answer after answering Q5
Response:
1. Revise willingly
2. Log the change history in INTERVIEW-RESULT.md
3. Re-review affected questions
```

### Situation 5: Project unsuitable for the package

```
e.g. Determined to be production
or: Integration offers no benefit (a 5-line codebase)
Response:
1. Say so honestly
2. Explain why it's unsuitable
3. Offer alternatives
4. Decline to proceed
```

---

## 🎯 One-Line Summary

> **This assessment takes 5-10 minutes to read the project context, set the enforcement level (standard/strict), and install the gates. Then AI-EXECUTION.md runs one SDD flow autonomously — no modes, universal application.**

🎤
