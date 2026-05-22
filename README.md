# 🎼 Spec-Driven Orchestra

> **An experimental package that makes the SDD framework the conductor of 4 skills it can call, in one Claude Code workflow. All 5 instruments come from open-source projects (across 4 repositories).**
> 
> For new, early-stage, or refactoring projects. Claude Code interviews your project, then integrates the methodologies semi-autonomously.

> [!NOTE]
> **Status: Experimental.** This is a *proposal* for combining 5 instruments, not a proven best practice. All are well-established open-source projects, but their *combined* effect has not yet been measured with real-world data. Start small (see [Tiered Adoption](#-tiered-adoption)), and treat the orchestra as a hypothesis to test, not a guarantee.

<p align="center">
  🌐 <b>Language</b>: <b>English</b> | <a href="./README.ko.md">한국어</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Method-SDD%20Orchestra-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Instruments-5-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Status-Experimental-red?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Made%20for-Claude%20Code-purple?style=for-the-badge" />
</p>

<p align="center">
  <a href="https://github.com/hongdosan/hongdosan-spec-driven-orchestra/stargazers">
    <img src="https://img.shields.io/github/stars/hongdosan/hongdosan-spec-driven-orchestra?style=social" />
  </a>
  <a href="https://github.com/hongdosan/hongdosan-spec-driven-orchestra/network/members">
    <img src="https://img.shields.io/github/forks/hongdosan/hongdosan-spec-driven-orchestra?style=social" />
  </a>
</p>

<p align="center">
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-the-symphony">The Symphony</a> •
  <a href="#-how-it-works">How It Works</a> •
  <a href="#-faq">FAQ</a> •
  <a href="#-contribute">Contribute</a>
</p>

---

## 🌟 What Is This?

**One framework — SDD — with skills it commands.** This is not five equal tools; it's a conductor (SDD) that calls skills when the work needs them, backed by enforcement gates that make the process non-optional.

**🎼 The framework (conductor):**

| | Framework | Role | Source |
|---|---|---|---|
| 🎼 | **SDD** (Spec-Driven Development) | The single framework. Owns the 7-step flow and the enforcement gates. | [github/spec-kit](https://github.com/github/spec-kit) |

**The skills SDD calls:**

| Instrument | Skill | Called during | Source |
|---|---|---|---|
| 🎻 **1st Violin** | **Karpathy's 4 Principles** | Implement — enforce code quality | [multica-ai](https://github.com/multica-ai/andrej-karpathy-skills) |
| 🎹 **Piano** | **grill-me** | Any step — remove ambiguity on demand | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎺 **Brass** | **Handoff** | Handoff — smooth transitions | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎸 **Guitar** | **Harness** | Tasks — agent teams for large tasks (optional, external) | [revfactory/harness](https://github.com/revfactory/harness) |

**The Idea**: Drop the package into your project. SDD assesses your context, runs its flow, and calls skills as needed — while enforcement gates block anything that skips a step. It applies universally (new, legacy, or production) with no modes; context only changes how strict the gates are. How much it helps still depends on your project — see [Honest Limitations](#-honest-limitations).

---

## 🪜 Tiered Adoption

**Do not adopt everything at once.** SDD always runs, but layering on all the skills plus a 7-step flow is a lot of overhead, and piling it on a small project contradicts the very "Simplicity First" principle this package promotes. Start at the lowest tier that fits, and climb only when you feel the need.

| Tier | Instruments | Best for | Overhead |
|---|---|---|---|
| **Tier 1 — Core** | 🎼 SDD + 🎻 Karpathy's 4 + 🎹 grill-me | Any project, solo work, first day | Low (SDD scales: full/mini/none) |
| **Tier 2 — +Handoff** | + 🎺 Handoff | When you need handoffs between sessions | Moderate |
| **Tier 3 — Full** | + 🎸 Harness | Large features, team/TF work, refactoring | High |

The AI interview recommends a tier based on context. You can always override it. SDD is the framework, so it is in every tier; Karpathy + grill-me (the lightest skills) sit in Tier 1 alongside it — you get most of the value early.

---

## ⚡ Quick Start

**Fastest path** — one script does the file placement (pick one language):

```bash
# run inside your project (default target = current dir)
curl -sL https://raw.githubusercontent.com/hongdosan/hongdosan-spec-driven-orchestra/main/install.sh | bash -s -- --lang en
# Korean docs: --lang ko    |    other target: append a path
```

It copies the methodology docs (one language), the local hooks, and a CI gate
(R1/R2/R3; the package-internal R7 doc-sync is omitted as it is not portable). It does
**not** install spec-kit or run `specify init` — do Step 0 below first, then Step 3.
Prefer to do it by hand? Follow the numbered steps.

### Steps to Symphony

#### 0️⃣ Prerequisite: install spec-kit (the framework this leverages)

```bash
# spec-kit provides the SDD core via the `specify` CLI + /speckit.* commands.
# This installs the `specify` CLI on your PATH (a global tool, not per-project) — it
# creates no project files. The per-project step (`specify init`, which creates
# `.specify/` in your project root) runs later in Step 3, driven by Claude Code.
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

> **Entry barrier changed.** This package now *leverages* spec-kit rather than
> re-implementing it, so spec-kit is a real prerequisite — it is no longer "just copy
> some markdown." If you don't have `uv`, see [spec-kit's README](https://github.com/github/spec-kit).

#### 1️⃣ Clone & Copy

```bash
# Clone this repo somewhere OUTSIDE your project (you don't clone it into your project).
git clone https://github.com/hongdosan/hongdosan-spec-driven-orchestra.git

# Copy the 4 methodology docs into your project. Keep the clone around:
# the later integration step (Step 3) also pulls gate scripts from this repo's enforcement/.
SRC=hongdosan-spec-driven-orchestra/symphony
cp "$SRC"/AI-INTERVIEW.md        /path/to/your/project/
cp "$SRC"/AI-EXECUTION.md        /path/to/your/project/
cp "$SRC"/ORCHESTRA-GUIDE.md     /path/to/your/project/
cp "$SRC"/INTEGRATION-CHECKLIST.md /path/to/your/project/
cd /path/to/your/project/
```

#### 2️⃣ Git Safety Net (Recommended)

```bash
git checkout -b feat/spec-driven-orchestra
git add *.md
git commit -m "docs: add Spec-Driven Orchestra package"
```

#### 3️⃣ Launch Claude Code

```bash
claude
```

Then tell it:

```
Read AI-INTERVIEW.md and start the integration process.
Assess the context, run `specify init`, install the enforcement gates, then proceed with SDD.
```

That's it. Claude Code assesses your project, runs `specify init` (spec-kit) and installs the gates, then drives the `/speckit.*` flow.

---

## 🎯 Who Is This For?

**Any project, at any stage.** There are no modes — SDD assesses context and adapts. The same flow applies whether you're starting fresh or fixing a deployed service; only the strictness of the enforcement gates changes.

| Project Type | What SDD does | Gate level |
|---|---|---|
| 🌱 **Brand New** | Runs the flow; nothing to preserve, so gates pass easily | standard |
| 🌿 **Early / In-Progress** | Adds a Step 0 survey before changing existing code | standard |
| 🧱 **Legacy / Maintenance** | Survey + regression checks to preserve behavior | standard |
| 💼 **Production Services** | Same flow, but gates become **strict** — tests & regression mandatory, non-bypassable | **strict** |

> 💡 **No production block.** Earlier versions refused production projects. This one doesn't — instead, detecting production signals raises the enforcement level so the existing gates become non-bypassable. Universal application, with safety scaled to risk. Legacy is supported but **not** prioritized over other contexts.

---

## 🎼 The Symphony

### The 7-Step SDD Flow (Standard)

```
1. Specify    🎼  What & Why
   ↓
2. Clarify    🎹  Remove ambiguity (grill-me)
   ↓
3. Plan       🎼  How (tech selection)
   ↓
4. Tasks      🎼  Break down (30min-2h units)
   ↓
5. Verify     🎼  Design verification (SDD-owned)
   ↓
6. Implement  🎻  Karpathy's 4 Principles
   ↓
7. Handoff    🎺  Context preservation
```

### When Existing Code Is Present (added steps, not a mode)

```
0. Survey      🎼  Analyze existing code      ← only if existing code
1-5. [Standard]
5b. Regression 🎼  Preserve existing behavior ← only if existing code
6. Implement   🎻  Karpathy (+ migration if replacing behavior)
7. Handoff
```

### Work Classification

| Type | When | Steps |
|---|---|---|
| **Full SDD** | New feature, large refactor | All 7 (+00/05b if existing code) |
| **Mini SDD** | Small feature, bug fix | 1, 6, 7 only |
| **No SDD** | One-liner, typo | Just Karpathy principles |

---

## 🎭 How It Works

```
┌────────────────────────────────────────────────────┐
│                                                    │
│  You: "Read AI-INTERVIEW.md and start"             │
│                                                    │
│           ↓                                        │
│                                                    │
│  AI: Auto-scan (10-30 sec)                         │
│      Directory, code, Git, production signals      │
│                                                    │
│           ↓                                        │
│                                                    │
│  AI: Interview (5-10 min)                          │
│      5-7 questions with AI-recommended answers     │
│                                                    │
│           ↓                                        │
│                                                    │
│  AI: Assessment + Single Approval                  │
│      enforcement level (standard/strict) + survey  │
│                                                    │
│           ↓                                        │
│                                                    │
│  AI: Autonomous Execution (10-30 min)              │
│      one SDD flow, gates installed, fully automatic│
│                                                    │
│           ↓                                        │
│                                                    │
│  You: Verification (Day 0/7/30 checklists)         │
│                                                    │
└────────────────────────────────────────────────────┘
```

---

## 📦 Package Contents

```
hongdosan-spec-driven-orchestra/
├── README.md                    # This file (English)
├── README.ko.md                 # Korean version
├── LICENSE                      # MIT
│
└── symphony/                    # The methodology package (English default + Korean .ko.md)
    ├── README.md                # Package overview
    ├── AI-INTERVIEW.md          # 🎤 Interview entry point
    ├── AI-EXECUTION.md          # 🛠️ Single SDD execution flow
    ├── ORCHESTRA-GUIDE.md       # 🎼 5-instrument guide
    ├── INTEGRATION-CHECKLIST.md # ✅ Verification checklists
    └── *.ko.md                  # Korean counterpart of each file above
```

### File Purposes

| File | Read By | When |
|---|---|---|
| `README.md` | Humans | First contact |
| `symphony/AI-INTERVIEW.md` | AI | Starting integration |
| `symphony/AI-EXECUTION.md` | AI | After interview |
| `symphony/ORCHESTRA-GUIDE.md` | Humans + AI | During usage |
| `symphony/INTEGRATION-CHECKLIST.md` | Humans | Day 0/7/30 verification |

> **Bilingual**: every `symphony/*.md` is English by default and has a Korean counterpart `*.ko.md`. To work in Korean, copy the `.ko.md` files renaming them to `.md` (so Claude Code recognizes the entry filename). Korean users can also start from [README.ko.md](./README.ko.md).

---

## 🎵 What Gets Generated

### Common Assets

```
your-project/
├── CLAUDE.md                    # AI entry point (auto-loaded)
├── DECISION-LOG.md              # All decisions tracked
├── INTEGRATION-REPORT.md        # Integration result
├── INTERVIEW-RESULT.md          # Interview record
│
├── .claude/skills/              # 3 skills generated by this package
│   ├── grill-me/                # 🎹 Clarification
│   ├── sdd-conductor/           # 🎼 Conductor
│   └── handoff/          # 🎺 Handoff writer
│                                # External plugins (/plugin): 🎻 karpathy-guidelines, 🎸 Harness
│
├── .specify/                    # 🎼 spec-kit (created by `specify init`)
│   ├── memory/constitution.md   # R1–R7 rules (gates read this) + project principles
│   └── templates/               # spec-kit's spec/plan/tasks/checklist templates
│
└── specs/<NNN-slug>/            # feature work, per git branch (via /speckit.*)
    ├── spec.md  plan.md  tasks.md          # spec-kit outputs
    └── survey.md  regression.md            # this package's additions
        handoff.md  implementation-notes.md

.claude/hooks/                   # ⛔ Enforcement (installed from enforcement/)
├── pre-implement.sh             # blocks code without spec+plan (R1,R2)
└── post-task.sh                 # warns on missing handoff (R5)
.git/hooks/pre-commit            # blocks commit without passing tests (R3,R4,R6)
.github/workflows/sdd-gate.yml   # non-bypassable merge gate (R1,R3,R6,R7)
```

### Context Additions (not modes)

The same flow adapts to what it finds — no `MODE_*` branching:

- **Existing code present** → a `survey.md` precedes Specify; `regression.md` is required before commit (R4).
- **Production signals detected** → `ENFORCEMENT_LEVEL=strict`; tests & regression become non-bypassable (R6).
- **Greenfield** → same flow and gates, but nothing to preserve, so they pass easily.

Nothing here is a mode you pick — SDD reads the context and adjusts strictness automatically.

---

## 🌟 Key Features

### ⛔ Enforced, Not Advised
- Spec/plan missing → implement blocked (R1, R2)
- Tests not passing → commit blocked (R3)
- Existing behavior at risk → regression required (R4)
- Production context → gates non-bypassable (R6)
- Docs out of sync → merge blocked (R7)

> **Precondition for "non-bypassable".** Local hooks can be skipped (`git commit
> --no-verify`). The CI gate is the real backstop — but only if you enable
> **required-PR branch protection** on your default branch. Without that, enforcement
> is best-effort (local hooks + honesty), not guaranteed.

### 🔍 Interview-Based Adaptation
- 5-7 questions for context understanding
- Auto-scan assists AI's recommendation
- Mode determined automatically

### 🛡️ Safety First
- **Production → strict gates, not blocked** (non-bypassable tests)
- Existing assets backed up to `archive/`
- Global settings (`~/.claude/`) untouched
- Easy Git rollback

### 📝 Traceability
- Auto-generated `DECISION-LOG.md`
- Decision Log section in every document
- Interview results preserved

### 🎼 Harmonious Integration
- SDD as conductor
- Clear role for each instrument
- Tool conflicts prevented

---

## 📚 Built On

This package integrates 5 instruments — all repo-backed open-source pieces (across 4 repositories). Their maturity varies — shown qualitatively below so you can judge each for yourself (check the live star counts on each repo, as they change over time):

| Methodology | Source | License | Maturity |
|---|---|---|---|
| **Spec Kit** (SDD) | [github/spec-kit](https://github.com/github/spec-kit) | MIT | Established (GitHub-official) |
| **Karpathy Guidelines** | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | MIT | Established |
| **grill-me Skill** | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | Established |
| **Handoff Skill** | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | Established |
| **Harness** | [revfactory/harness](https://github.com/revfactory/harness) | Apache-2.0 | Widely adopted, actively maintained |

> [!NOTE]
> All five instruments are actively adopted open-source projects (grill-me and Handoff both come from `mattpocock/skills`, so the five span four repositories). **Harness** is the newest of them and depends on Claude Code's *experimental* Agent Teams feature (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`). Its reported "+60% quality" figure comes from **the author's own paper (Hwang, 2026)** and has not been independently reproduced — credible, but worth verifying for your own use case. Star counts change over time; check each repository for current numbers. The **Karpathy** principles are `multica-ai`'s formulation *inspired by* Karpathy's public observations on LLM coding pitfalls — Karpathy himself did not enumerate these four; the wording and naming are the repo author's.

---

## 🎸 Why a 5th Instrument?

Four of the instruments help **a single agent work better** (spec & verify, clarify, quality, handoff). Harness is different in kind: it helps **split one big task across a team of agents**. That difference is exactly why it is the *optional* 5th, gated behind Tier 3 and a single condition:

> Bring in Harness only when a task is genuinely too large for one agent — e.g. work that splits into clear specialties (frontend / backend / QA), or a large research-and-build effort.

Honesty about it: Harness is **not generated by this package** (it's an external plugin, `revfactory/harness`), it is the **newest** of the six and relies on an **experimental** Claude Code feature (`AGENT_TEAMS=1`). For most projects you will never need it, and the orchestra works fine as a "quintet + optional guest". It's included because agent-team design is a real, actively-adopted approach that maps cleanly onto SDD's task-breakdown step — but it earns its place only when the work demands it.

---

## ⚖️ Honest Limitations

A fair README states where it might *not* help:

- **Unproven in combination.** Each tool is individually credible, but the claim that combining all 5 produces compounding benefit is a hypothesis, not a measured result. No usage data is published yet.
- **Two skill installs are path-pinned to `main`.** `grill-me` and `handoff` are fetched via `curl` from a fixed path on `mattpocock/skills`' `main` branch (that repo documents no plugin). If the upstream renames or moves the file, the install breaks until the path is updated. (spec-kit uses its own CLI; `karpathy-guidelines` and `harness` install via `/plugin` — none of these are affected.) Hardening the two `curl` installs — pin to a commit SHA — is **deferred for now**; treat a failed skill install as "upstream path changed."
- **Overhead is real.** The full flow can slow down small or trivial work. This is why [Tiered Adoption](#-tiered-adoption) exists — using everything everywhere would violate the Karpathy "Simplicity First" principle the package itself preaches.
- **Agent compliance isn't guaranteed.** Claude Code may skip steps, fill templates without substance, or drift from `CONSTITUTION.md` over long sessions. The skills nudge it, but an LLM's probabilistic nature means 100% adherence is impossible.
- **Tool frictions exist.** The pieces can pull against each other — e.g. grill-me's relentless questioning vs a "move fast" priority. When they conflict, prefer the lower tier and the user's explicit intent.
- **spec-kit's behavior is assumed, not tested here.** This package invokes `specify init` and `/speckit.*` and relies on them producing `spec.md`/`plan.md`/`tasks.md`; it ships no test that the upstream flow actually works, and pins skill installs to upstream `main` (see the deferred fragility note). Track upstream versions yourself.
- **Production raises overhead, not a free pass.** Production projects are not blocked, but the gates become **strict** (non-bypassable tests + regression), which adds friction. The package reduces *process* risk; it cannot reduce the inherent risk of changing a live service.

If any of these outweigh the benefit for you, use only Tier 1, or skip the package entirely. That's a valid outcome.

---

## ❓ FAQ

<details>
<summary><b>Q: Is this just for Claude Code?</b></summary>

Currently optimized for Claude Code (uses `CLAUDE.md`, `.claude/skills/`). 
Adaptations for Cursor, Cline, Aider are planned. Contributions welcome!
</details>

<details>
<summary><b>Q: How is this different from just using Spec Kit?</b></summary>

Spec Kit *is* SDD — the framework itself. Spec-Driven Orchestra makes SDD the conductor and adds 4 skills it can call (Karpathy, grill-me, Handoff, Harness) plus enforcement gates that make the flow non-optional.
</details>

<details>
<summary><b>Q: Do I have to use Full SDD every time?</b></summary>

No. Scale to your work:
- One-line fix → No SDD (Karpathy only)
- Small feature → Mini SDD (spec → implement → handoff only)
- Large feature → Full SDD (all 7 steps)
</details>

<details>
<summary><b>Q: What if I'm a beginner?</b></summary>

Start small:
1. Read this README
2. Try on a side project first
3. Use Mini SDD a few times
4. Then attempt Full SDD
</details>

<details>
<summary><b>Q: Can I use this for production projects?</b></summary>

**Yes — it is not blocked.** When the interview detects production signals, it sets `ENFORCEMENT_LEVEL=strict`: tests and regression become mandatory and non-bypassable (R6). Same flow, stricter gates.

Recommended (still your call):
- Start on a feature branch, one feature at a time
- Let the strict gates prove their value before widening
</details>

<details>
<summary><b>Q: How do I roll back if I don't like it?</b></summary>

Multiple ways:

```bash
# Git rollback
git reset --hard HEAD~1

# Or restore from archive (if applicable)
cp -r archive/legacy/* ./
rm -rf .claude/skills/
```

Detailed rollback guide in `INTEGRATION-CHECKLIST.md`.
</details>

<details>
<summary><b>Q: What's the learning curve?</b></summary>

- **First week**: Some overhead, mostly using Mini SDD
- **First month**: Full SDD 2-3 times, getting comfortable
- **After that**: Natural flow, the 5-instrument metaphor becomes intuitive
</details>

<details>
<summary><b>Q: Can teams use this?</b></summary>

Absolutely. Recommended order:
1. Apply to your own project first
2. Use for 1 month to validate
3. Demo to team
4. Adopt with 1-2 colleagues
5. Scale gradually

Since `CLAUDE.md` auto-loads, team members applying Claude Code automatically get the workflow.
</details>

---

## 🛣️ Roadmap

### Recently Shipped (v2)
- ✅ Context-based dynamic assessment (no modes)
- ✅ Enforcement gates (R1–R7)
- ✅ Universal application (new/legacy/production)
- ✅ 4 skills under SDD
- ✅ Archive backup strategy
- ✅ Bilingual documentation (English + Korean)

### In Progress
- 🚧 Case study collection
- 🚧 Cursor adaptation guide
- 🚧 Cline adaptation guide

### Planned
- 📋 Additional language docs (Chinese, Japanese)
- 📋 Video tutorial
- 📋 More enforcement gate templates (per-language test runners)
- 📋 Quantitative effectiveness metrics
- 📋 Team adoption playbook

### Future
- 🌟 Web-based interview tool
- 🌟 Methodology benchmark dashboard
- 🌟 Community case studies

---

## 🤝 Contribute

Contributions of all kinds are welcome!

### High-Impact Contributions
1. **Case studies** — Apply Spec-Driven Orchestra to your project and share results
2. **Curated resources** — Submit PR with related tools/methods
3. **Adaptations** — Cursor/Cline/Aider guides
4. **Translations** — Help non-English speakers
5. **Tutorials** — Help newcomers

### How to Contribute

1. **Open an Issue** to discuss
2. **Fork** this repository
3. **Create a feature branch** (`git checkout -b feat/your-feature`)
4. **Commit** your changes
5. **Push** to your branch
6. **Open a Pull Request**

### Guidelines
- Be kind and constructive
- Test before submitting
- Document your changes
- Follow existing style

---

## 📜 License

MIT License - see [LICENSE](./LICENSE) file.

**TL;DR**: Use it freely. Modify it. Share it. Just keep the copyright notice.

---

## 🙏 Acknowledgments

This project stands on the shoulders of giants:

- **Andrej Karpathy** ([@karpathy](https://x.com/karpathy)) for the observations on LLM coding pitfalls that inspired the principles
- **multica-ai** ([@jiayuan_jy](https://x.com/jiayuan_jy)) for the [4-principle formulation](https://github.com/multica-ai/andrej-karpathy-skills) derived from those observations
- **GitHub Spec Kit** team
- **Matt Pocock** ([@mpocock1](https://x.com/mpocock1)) for grill-me
- **Anthropic** ([@AnthropicAI](https://x.com/AnthropicAI)) for Claude Code
- **The entire AI coding community**

Special thanks to early adopters who provide feedback.

---

## 🌟 Star History

<p align="center">
  <a href="https://star-history.com/#hongdosan/hongdosan-spec-driven-orchestra">
    <img src="https://api.star-history.com/svg?repos=hongdosan/hongdosan-spec-driven-orchestra&type=Date" alt="Star History Chart" />
  </a>
</p>

---

## 📬 Connect

- 💬 [Discussions](https://github.com/hongdosan/hongdosan-spec-driven-orchestra/discussions) — Q&A, ideas
- 🐛 [Issues](https://github.com/hongdosan/hongdosan-spec-driven-orchestra/issues) — Bugs, requests
- 👤 Creator: [@hongdosan](https://github.com/hongdosan)

---

## 🎯 If This Helps You

⭐ **Star this repo** if it helped you in any way!
🍴 **Fork it** to customize for your team
📢 **Share it** with fellow developers
💡 **Contribute** to make it better

Together, we're orchestrating the future of AI-powered coding.

---

<p align="center">
  <i>Created with 🎼 by <a href="https://github.com/hongdosan">@hongdosan</a></i>
</p>

<p align="center">
  <sub>If you find this useful, please ⭐ star it!</sub>
</p>
