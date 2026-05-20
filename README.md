# 🎼 Spec-Driven Orchestra

> **An integrated AI coding methodology that conducts 5 powerful workflows into a single harmonious symphony.**
> 
> Apply to new, early-stage, or refactoring projects with Claude Code's AI-driven autonomous integration.

<p align="center">
  🌐 <b>Language</b>: <b>English</b> | [한국어](https://github.com/hongdosan/hongdosan-spec-driven-orchestra/blob/main/README-ko.md)
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Method-SDD%20Orchestra-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Instruments-5-blue?style=for-the-badge" />
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

A unified AI coding methodology that orchestrates **5 powerful philosophies** into one workflow:

| Instrument | Methodology | Role |
|---|---|---|
| 🎼 **Conductor** | **SDD** (Spec-Driven Development) | Orchestrate the 7-step flow |
| 🎻 **1st Violin** | **Karpathy's 4 Principles** | Enforce code quality |
| 🎹 **Piano** | **grill-me Skill** | Remove ambiguity through dialogue |
| 🥁 **Percussion** | **Harness Engineering** | Design verification scenarios |
| 🎺 **Brass** | **Handoff Pattern** | Smooth transitions between work |

**The Promise**: Drop the package into your project, let Claude Code interview your context, and watch as your AI coding workflow gets autonomously orchestrated.

---

## ⚡ Quick Start

### Three Steps to Symphony

#### 1️⃣ Clone & Copy

```bash
# Clone this repo
git clone https://github.com/hongdosan/hongdosan-spec-driven-orchestra.git

# Copy methodology files to your project
cp hongdosan-spec-driven-orchestra/symphony/*.md /path/to/your/project/
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
After the interview, autonomously proceed with the determined mode.
```

That's it. Claude Code will interview your project for 5-10 minutes, then autonomously integrate the methodology over 10-30 minutes.

---

## 🎯 Who Is This For?

### ✅ Perfect For

| Project Type | Description | Mode |
|---|---|---|
| 🌱 **Brand New** | Just starting, 0% code | `MODE_GREENFIELD` |
| 🌿 **Early Stage** | 1-2 weeks in, 10-30% done | `MODE_EARLY` |
| 🔨 **Refactor TF** | Rewriting existing code from scratch | `MODE_REBUILD` |

### 🚫 Not For

| Project Type | Why |
|---|---|
| 💼 **Production Services** | Real user/data risk → Auto-rejected during interview |

> 💡 **Production Auto-Block**: The interview detects production signals (Dockerfile.prod, deployment configs, etc.) and refuses to apply, protecting your users.

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
5. Harness    🥁  Design verification
   ↓
6. Implement  🎻  Karpathy's 4 Principles
   ↓
7. Handoff    🎺  Context preservation
```

### The 9-Step Flow (Refactor Mode)

```
0. Archaeology 🪕  Analyze existing code     ← Added
1-5. [Standard]
5b. Regression 🥁🪕 Preserve existing behavior ← Added
6. Implement   🎻🎷 Karpathy + Migration
7. Handoff
```

### Work Classification

| Type | When | Steps |
|---|---|---|
| **Full SDD** | New feature, large refactor | All 7 (or 9 for rebuild) |
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
│  AI: Mode Decision + Single Approval               │
│      GREENFIELD / EARLY / REBUILD / BLOCK         │
│                                                    │
│           ↓                                        │
│                                                    │
│  AI: Autonomous Execution (10-30 min)              │
│      Mode-specific integration, fully automatic    │
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
└── symphony/                    # The methodology package
    ├── README.md                # Package overview
    ├── AI-INTERVIEW.md          # 🎤 Interview entry point
    ├── AI-EXECUTION.md          # 🛠️ Mode-specific execution
    ├── ORCHESTRA-GUIDE.md       # 🎼 5-instrument guide
    └── INTEGRATION-CHECKLIST.md # ✅ Verification checklists
```

### File Purposes

| File | Read By | When |
|---|---|---|
| `README.md` | Humans | First contact |
| `symphony/AI-INTERVIEW.md` | AI | Starting integration |
| `symphony/AI-EXECUTION.md` | AI | After interview |
| `symphony/ORCHESTRA-GUIDE.md` | Humans + AI | During usage |
| `symphony/INTEGRATION-CHECKLIST.md` | Humans | Day 0/7/30 verification |

---

## 🎵 What Gets Generated

### Common Assets (All Modes)

```
your-project/
├── CLAUDE.md                    # AI entry point (auto-loaded)
├── DECISION-LOG.md              # All decisions tracked
├── INTEGRATION-REPORT.md        # Integration result
├── INTERVIEW-RESULT.md          # Interview record
│
├── .claude/skills/              # 5 AI Skills
│   ├── grill-me/                # 🎹 Clarification
│   ├── sdd-conductor/           # 🎼 Conductor
│   ├── karpathy-enforcer/       # 🎻 Quality enforcer
│   ├── harness-builder/         # 🥁 Verification designer
│   └── handoff-writer/          # 🎺 Handoff writer
│
└── sdd/                         # 🎼 SDD-centric directory
    ├── CONSTITUTION.md          # Project constitution
    ├── ORCHESTRA.md             # Symphony guide
    ├── README.md                # SDD overview
    ├── templates/               # Step templates
    └── features/                # Feature work (F001, F002, ...)
```

### Mode-Specific Additions

#### 🌱 MODE_GREENFIELD
- `sdd/templates/` 7 files (01~07)
- First SDD: `F000-bootstrap`

#### 🌿 MODE_EARLY
- `sdd/templates/` 7 files
- `archive/` (legacy assets backup if any)
- First SDD: `F000-integration`

#### 🔨 MODE_REBUILD
- `sdd/templates/` 9 files (00, 01~07, 05b added)
- `archive/legacy/` (full backup of existing code)
- 2 additional skills (`code-archaeologist`, `migration-strategist`)
- First SDD: `F000-rebuild-plan`

---

## 🌟 Key Features

### 🤖 Autonomous AI Execution
- Single user approval after interview
- Unlimited time/tokens
- All decisions automatically logged

### 🔍 Interview-Based Adaptation
- 5-7 questions for context understanding
- Auto-scan assists AI's recommendation
- Mode determined automatically

### 🛡️ Safety First
- **Production projects auto-blocked**
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

This methodology synthesizes 5 brilliant works:

| Methodology | Source | License |
|---|---|---|
| **Spec Kit** (SDD) | [github/spec-kit](https://github.com/github/spec-kit) | MIT |
| **Karpathy Guidelines** | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | MIT |
| **grill-me Skill** | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT |
| **Harness Engineering** | Community methodology | - |
| **Handoff Pattern** | Community methodology | - |

---

## ❓ FAQ

<details>
<summary><b>Q: Is this just for Claude Code?</b></summary>

Currently optimized for Claude Code (uses `CLAUDE.md`, `.claude/skills/`). 
Adaptations for Cursor, Cline, Aider are planned. Contributions welcome!
</details>

<details>
<summary><b>Q: How is this different from just using Spec Kit?</b></summary>

Spec Kit is one of the 5 instruments here. Spec-Driven Orchestra integrates Spec Kit (as conductor) with 4 other methodologies for a complete workflow.
</details>

<details>
<summary><b>Q: Do I have to use Full SDD every time?</b></summary>

No. Scale to your work:
- One-line fix → No SDD (Karpathy only)
- Small feature → Mini SDD (01, 06, 07 only)
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

**No, this is blocked intentionally.** Production projects have user/data risks that require different considerations. The interview detects production signals and refuses.

Alternatives:
- Create a feature branch and experiment there
- Try in a fork
- Wait for a production-friendly version
</details>

<details>
<summary><b>Q: How do I roll back if I don't like it?</b></summary>

Multiple ways:

```bash
# Git rollback
git reset --hard HEAD~1

# Or restore from archive (if applicable)
cp -r archive/legacy/* ./
rm -rf sdd/ .claude/skills/
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
- ✅ AI-interview-based mode determination
- ✅ 3 modes (GREENFIELD/EARLY/REBUILD)
- ✅ Production project auto-blocking
- ✅ 5 + 2 specialized skills
- ✅ Archive backup strategy
- ✅ Bilingual documentation (English + Korean)

### In Progress
- 🚧 Case study collection
- 🚧 Cursor adaptation guide
- 🚧 Cline adaptation guide

### Planned
- 📋 Additional language docs (Chinese, Japanese)
- 📋 Video tutorial
- 📋 More modes (e.g., `MODE_MICROSERVICE`)
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

- **Andrej Karpathy** ([@karpathy](https://x.com/karpathy)) for the 4 principles
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
