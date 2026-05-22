# 🎼 Spec-Driven Orchestra

> **SDD 프레임워크를 지휘자로 삼아 그것이 호출하는 4개 스킬을 하나의 Claude Code 워크플로우로 통합하려는 실험적 패키지. 5개 악기 모두 오픈소스 프로젝트(4개 저장소) 출처입니다.**
> 
> 신규/초기/리팩토링 프로젝트용. Claude Code가 프로젝트를 인터뷰한 뒤, 방법론을 반자율적으로 통합합니다.

> [!NOTE]
> **상태: 실험적(Experimental).** 이것은 검증된 베스트 프랙티스가 아니라, 5개 악기를 결합하려는 *제안*입니다. 모두 충분히 검증된 오픈소스 프로젝트이지만, 이들의 *결합* 효과는 아직 실사용 데이터로 측정되지 않았습니다. 작게 시작하고([단계적 도입](#-단계적-도입) 참조), 이 오케스트라를 보장이 아니라 검증할 가설로 다뤄 주세요.

<p align="center">
  🌐 <b>언어</b>: <a href="./README.md">English</a> | <b>한국어</b>
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
  <a href="#-빠른-시작">빠른 시작</a> •
  <a href="#-오케스트라-구성">오케스트라</a> •
  <a href="#-어떤-프로젝트에-적용-가능한가요">적용 범위</a> •
  <a href="#-faq">FAQ</a> •
  <a href="#-기여">기여</a>
</p>

---

## ✨ 무엇을 하는 도구인가요?

**프레임워크는 하나 — SDD — 이며, 나머지는 그것이 거느리는 스킬입니다.** 5개 동등한 도구가 아니라, 지휘자(SDD)가 필요할 때 스킬을 호출하는 구조이며, 흐름을 선택이 아닌 필수로 만드는 강제 게이트가 뒷받침합니다.

**🎼 프레임워크 (지휘자):**

| | 프레임워크 | 역할 | 출처 |
|---|---|---|---|
| 🎼 | **SDD** (Spec-Driven Development) | 유일한 프레임워크. 7단계 흐름과 강제 게이트를 소유. | [github/spec-kit](https://github.com/github/spec-kit) |

**SDD가 호출하는 스킬:**

| 악기 | 스킬 | 호출 시점 | 출처 |
|---|---|---|---|
| 🎻 1st Violin | **Karpathy 4원칙** | Implement — 코드 품질 강제 | [multica-ai](https://github.com/multica-ai/andrej-karpathy-skills) |
| 🎹 Piano | **grill-me** | 모든 단계 — 필요 시 모호함 제거 | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎺 Brass | **Handoff** | Handoff — 매끄러운 인계 | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎸 Guitar | **Harness** | Tasks — 큰 작업용 에이전트 팀 (선택·외부) | [revfactory/harness](https://github.com/revfactory/harness) |

→ **사용 방식**: 패키지를 프로젝트에 넣으면, SDD가 컨텍스트를 평가하고 흐름을 돌리며 필요할 때 스킬을 호출합니다 — 그동안 강제 게이트가 단계를 건너뛰는 모든 것을 막습니다. 어디서든 적용되며(신규·레거시·운영), 모드는 없습니다. 컨텍스트는 게이트의 엄격도만 바꿉니다. 실제 도움 정도는 프로젝트에 따라 다릅니다 — [솔직한 한계](#-솔직한-한계) 참조.

---

## 🪜 단계적 도입

**한 번에 다 도입하지 마세요.** SDD는 항상 돌아가지만, 모든 스킬에 7단계 흐름까지 한꺼번에 얹으면 부담이 크고, 작은 프로젝트에 전부 얹는 것은 이 패키지가 내세우는 "Simplicity First(단순함 우선)" 원칙과 정면으로 충돌합니다. 맞는 가장 낮은 단계부터 시작하고, 필요할 때만 올라가세요.

| 단계 | 악기 | 적합 상황 | 부담 |
|---|---|---|---|
| **Tier 1 — Core** | 🎼 SDD + 🎻 Karpathy 4원칙 + 🎹 grill-me | 모든 프로젝트, 혼자 작업, 첫날 | 낮음 (SDD는 full/mini/none으로 조절) |
| **Tier 2 — +Handoff** | + 🎺 Handoff | 세션 간 인계가 필요할 때 | 중간 |
| **Tier 3 — Full** | + 🎸 Harness | 대형 기능, 팀/TF 작업, 리팩토링 | 높음 |

AI 인터뷰가 단계를 추천합니다. 언제든 직접 바꿀 수 있습니다. SDD는 프레임워크라 모든 단계에 포함되며, 가장 가벼운 스킬(Karpathy, grill-me)이 그 옆 Tier 1에 있습니다 — 일찍 대부분의 가치를 얻습니다.

---

## 🚀 빠른 시작

### 0️⃣ 사전 준비: spec-kit 설치 (전제조건 — 아래 두 방법 모두 필요)

```bash
# spec-kit이 `specify` CLI + /speckit.* 명령으로 SDD 코어를 제공합니다.
# 이 명령은 `specify` CLI를 PATH에 전역 설치합니다(프로젝트별이 아닌 전역 도구) — 프로젝트
# 파일은 만들지 않습니다. 프로젝트별 단계(`specify init` — 프로젝트 루트에 `.specify/`를
# 생성)는 뒤의 3️⃣에서 Claude Code가 실행합니다.
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

> `uv`가 없으면 [spec-kit README](https://github.com/github/spec-kit)의 설치 안내를 참고하세요.

### 1️⃣ 패키지 가져오기 — 아래 둘 중 **하나만** 선택

**방법 A — 가장 빠름 (install.sh가 파일 배치를 대신)**

```bash
# 본인 프로젝트 안에서 실행 (기본 대상 = 현재 디렉터리). pre-commit 훅 설치를 위해
# 먼저 git 저장소여야 합니다(아니면 스크립트가 안내 후 건너뜀).
curl -sL https://raw.githubusercontent.com/hongdosan/hongdosan-spec-driven-orchestra/main/install.sh | bash -s -- --lang ko
# 영어 문서: --lang en    |    다른 대상: 경로를 뒤에 붙임
```

방법론 문서 4개(한 언어)에 더해 **로컬 hooks와 CI 게이트(R1/R2/R3 — 패키지 내부용 R7은
이식 불가라 제외)까지** 배치합니다. spec-kit 설치·`specify init`은 하지 않습니다(0️⃣·3️⃣ 참고).

**방법 B — 수동 (클론 후 복사)**

```bash
# 이 레포를 본인 프로젝트 바깥에 클론합니다 (프로젝트 안에 클론하지 않습니다).
git clone https://github.com/hongdosan/hongdosan-spec-driven-orchestra.git

# 메서드 문서 4개를 프로젝트로 복사 — 한글판은 기본 .md 이름으로 바꿔서
# (Claude Code가 진입 파일명으로 인식).
SRC=hongdosan-spec-driven-orchestra/symphony
cp "$SRC"/AI-INTERVIEW.ko.md        /path/to/your/project/AI-INTERVIEW.md
cp "$SRC"/AI-EXECUTION.ko.md        /path/to/your/project/AI-EXECUTION.md
cp "$SRC"/ORCHESTRA-GUIDE.ko.md     /path/to/your/project/ORCHESTRA-GUIDE.md
cp "$SRC"/INTEGRATION-CHECKLIST.ko.md /path/to/your/project/INTEGRATION-CHECKLIST.md
cd /path/to/your/project/
```

> 방법 B는 문서만 복사합니다. 게이트(hooks·CI)는 3️⃣에서 Claude Code가 이 레포의
> `enforcement/`에서 설치하므로 클론을 그대로 두세요.

### 2️⃣ Git 안전망 (권장)
```bash
git checkout -b feat/spec-driven-orchestra
git add *.md
git commit -m "docs: Spec-Driven Orchestra 패키지 추가"
```

### 3️⃣ Claude Code에 던지기
```bash
claude
```

다음 메시지 전달:

```
AI-INTERVIEW.md를 읽고 통합을 시작해주세요.
컨텍스트를 평가하고 `specify init`을 실행하고 강제 게이트를 설치한 뒤, SDD로 진행해주세요.
```

→ AI가 컨텍스트를 평가하고 `specify init`(spec-kit)과 게이트를 설치한 뒤, `/speckit.*` 흐름을 진행합니다.

---

## 🎯 어떤 프로젝트에 적용 가능한가요?

**어떤 프로젝트든, 어느 단계든.** 모드는 없습니다 — SDD가 컨텍스트를 평가해 적응합니다. 새로 시작하든 배포된 서비스를 고치든 같은 흐름이 적용되며, 강제 게이트의 엄격도만 달라집니다.

| 유형 | SDD가 하는 일 | 게이트 레벨 |
|---|---|---|
| 🌱 **신규** | 흐름 실행; 보존할 게 없어 게이트 쉽게 통과 | standard |
| 🌿 **초기/진행 중** | 기존 코드 변경 전 0단계 조사 추가 | standard |
| 🧱 **레거시/유지보수** | 동작 보존 위해 조사 + 회귀 검사 | standard |
| 💼 **운영 서비스** | 같은 흐름, 단 게이트가 **strict** — 테스트·회귀 필수, 우회 불가 | **strict** |

> 💡 **운영 차단 없음.** 운영 시그널을 감지하면 강제 레벨을 올려 기존 게이트를 우회 불가로 만듭니다. 보편 적용하되 안전은 위험도에 맞춰 조절. 레거시는 지원하지만 다른 컨텍스트보다 **우선하지 않습니다**.

---

## 🎭 동작 흐름

```
┌────────────────────────────────────────────────┐
│                                                │
│  사용자: "AI-INTERVIEW.md 읽고 시작"            │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 자동 스캔 (10-30초)                        │
│      디렉터리, 코드, Git, 운영 시그널            │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 인터뷰 5-7개 질문 (5-10분)                 │
│      각 질문에 AI 추천 답변 포함                 │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 평가 + 1회 승인 요청                       │
│      강제 레벨(standard/strict) + 조사 여부     │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 자율 진행 (10-30분)                        │
│      단일 SDD 흐름, 게이트 설치, 자동 수행      │
│                                                │
│              ↓                                 │
│                                                │
│  사용자: 검증 (Day 0/7/30)                      │
│                                                │
└────────────────────────────────────────────────┘
```

---

## 📦 패키지 구성

```
hongdosan-spec-driven-orchestra/
├── README.md                    # 영문 메인
├── README.ko.md                 # 이 파일 (한국어)
├── LICENSE                      # MIT
│
└── symphony/                    # 메서드 본체 (영문 기본 + 한글 .ko.md)
    ├── README.md                # 패키지 안내
    ├── AI-INTERVIEW.md          # 🎤 인터뷰 진행 (시작점)
    ├── AI-EXECUTION.md          # 🛠️ 단일 SDD 실행 흐름
    ├── ORCHESTRA-GUIDE.md       # 🎼 스킬 가이드
    ├── INTEGRATION-CHECKLIST.md # ✅ 검증 체크리스트
    └── *.ko.md                  # 위 각 파일의 한국어판
```

### 각 파일의 역할

| 파일 | 누가 읽나 | 언제 |
|---|---|---|
| `README.md` | 사람 | 처음 |
| `symphony/AI-INTERVIEW.md` | AI | 통합 시작 시 |
| `symphony/AI-EXECUTION.md` | AI | 인터뷰 후 |
| `symphony/ORCHESTRA-GUIDE.md` | 사람 + AI | 사용 중 |
| `symphony/INTEGRATION-CHECKLIST.md` | 사람 | Day 0/7/30 검증 |

> **이중 언어**: `symphony/*.md`는 영문이 기본이며, 각 파일마다 한국어판 `*.ko.md`가 있습니다. 한국어로 작업하려면 `.ko.md` 파일을 `.md` 이름으로 바꿔서 복사하세요 (Claude Code가 기본 진입 파일명으로 인식). 한국어 사용자는 [symphony/README.ko.md](./symphony/README.ko.md)부터 보셔도 됩니다.

---

## 🎼 오케스트라 구성

### 7단계 SDD 흐름 (표준)

```
1. Specify    🎼  무엇을 & 왜
   ↓
2. Clarify    🎹  모호함 제거 (grill-me)
   ↓
3. Plan       🎼  어떻게 (기술 선택)
   ↓
4. Tasks      🎼  분할 (30분-2시간 단위)
   ↓
5. Verify     🎼  검증 기준 설계 (SDD 소유)
   ↓
6. Implement  🎻  Karpathy 4원칙
   ↓
7. Handoff    🎺  컨텍스트 보존
```

### 기존 코드가 있을 때 (단계 추가, 모드 아님)

```
0. Survey      🎼  기존 코드 분석     ← 기존 코드 있을 때만
1-5. [표준]
5b. Regression 🎼  기존 동작 보존     ← 기존 코드 있을 때만
6. Implement   🎻  Karpathy (+ 동작 교체 시 마이그레이션)
7. Handoff
```

### 작업 분류

| 분류 | 대상 | 단계 |
|---|---|---|
| **Full SDD** | 새 기능, 큰 리팩토링 | 1~7 모두 (또는 0~7+5b) |
| **Mini SDD** | 작은 기능, 버그 | 1, 6, 7만 |
| **No SDD** | 1줄 수정, 오타 | Karpathy 4원칙만 |

---

## 🎵 통합 후 생기는 것

### 공통 자산

```
프로젝트 루트/
├── CLAUDE.md                    # AI 진입점 (자동 로드)
├── DECISION-LOG.md              # 모든 결정 추적
├── INTEGRATION-REPORT.md        # 통합 결과 리포트
├── INTERVIEW-RESULT.md          # 인터뷰 기록
│
├── .claude/skills/              # 이 패키지가 생성하는 3개 skill
│   ├── grill-me/                # 🎹 명확화
│   ├── sdd-conductor/           # 🎼 지휘자
│   └── handoff/                 # 🎺 인계 작성
│                                # 외부 플러그인(/plugin): 🎻 karpathy-guidelines, 🎸 Harness
│
├── .specify/                    # 🎼 spec-kit (`specify init`이 생성)
│   ├── memory/constitution.md   # R1~R7 규칙 (게이트가 읽음) + 프로젝트 원칙
│   └── templates/               # spec-kit의 spec/plan/tasks/checklist 템플릿
│
└── specs/<NNN-slug>/                       # 기능별 작업물, git 브랜치 단위 (/speckit.* 산출)
    ├── spec.md  plan.md  tasks.md          # spec-kit 산출
    └── survey.md  regression.md            # 이 패키지의 추가분
        handoff.md  implementation-notes.md

.claude/hooks/                   # ⛔ 강제 (enforcement/ 에서 설치)
├── pre-implement.sh             # spec+plan 없이 코드 차단 (R1,R2)
└── post-task.sh                 # handoff 누락 경고 (R5)
.git/hooks/pre-commit            # 테스트 미통과 커밋 차단 (R3,R4,R6)
.github/workflows/sdd-gate.yml   # 우회 불가 머지 게이트 (R1,R3,R6,R7)
```

### 컨텍스트 추가 (모드 아님)

같은 흐름이 발견한 것에 적응합니다 — `MODE_*` 분기 없음:

- **기존 코드 있음** → Specify 앞에 `survey.md`; 커밋 전 `regression.md` 필수 (R4)
- **운영 시그널 감지** → `ENFORCEMENT_LEVEL=strict`; 테스트·회귀 우회 불가 (R6)
- **신규** → 같은 흐름·게이트, 단 보존할 게 없어 쉽게 통과

여기 어느 것도 골라 쓰는 모드가 아닙니다 — SDD가 컨텍스트를 읽고 엄격도를 자동 조절합니다.

---

## 🌟 핵심 특징

### ⛔ 권고가 아니라 강제
- spec/plan 없음 → implement 차단 (R1, R2)
- 테스트 미통과 → 커밋 차단 (R3)
- 기존 동작 위험 → 회귀 필수 (R4)
- 운영 컨텍스트 → 게이트 우회 불가 (R6)
- 문서 비동기화 → 머지 차단 (R7)

> **"우회 불가"의 전제.** 로컬 훅은 `git commit --no-verify`로 건너뛸 수 있습니다.
> 진짜 backstop은 CI 게이트인데, 이는 기본 브랜치에 **required-PR 브랜치 보호**를 켰을
> 때만 우회 불가입니다. 그게 없으면 강제는 보장이 아니라 best-effort(로컬 훅 + 정직)입니다.

### 🤖 AI 자율 진행
- 컨텍스트 평가 후 1회 승인만 (이후 자율)
- 토큰/시간 무제한
- 모든 결정 자동 기록

### 🔍 컨텍스트 기반 적응
- 코드 규모·git 이력·운영 시그널 평가
- 모드 없이 게이트 엄격도만 조절
- 단계(Tier) 자동 추천

### 🛡️ 안전장치
- **운영은 차단이 아니라 strict 게이트로 보호**
- 기존 자산 archive 백업
- 글로벌 설정 보호
- 언제든 Git 롤백

### 📝 추적 가능성
- DECISION-LOG.md 자동 기록
- 각 문서마다 Decision Log 섹션
- 인터뷰 결과 보존

### 🎼 조화로운 통합
- SDD를 지휘자로
- 5가지 도구의 역할 명확
- 도구 간 충돌 방지

---

## 📚 통합되는 원본 자료

이 패키지는 5개 악기를 통합합니다 — 모두 오픈소스 저장소 기반(4개 저장소)입니다. 성숙도는 아래에 정성적으로 표기하니 직접 판단하시고, 정확한 스타 수는 변동하므로 각 저장소에서 확인하세요:

| 도구 | 출처 | 라이선스 | 성숙도 |
|---|---|---|---|
| **Spec Kit** (SDD) | [github/spec-kit](https://github.com/github/spec-kit) | MIT | 확립됨 (GitHub 공식) |
| **Karpathy Guidelines** | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | MIT | 확립됨 |
| **grill-me Skill** | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | 확립됨 |
| **Handoff Skill** | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | 확립됨 |
| **Harness** | [revfactory/harness](https://github.com/revfactory/harness) | Apache-2.0 | 널리 채택됨, 활발히 유지보수 |

> [!NOTE]
> 5개 악기 모두 활발히 채택되는 오픈소스입니다(grill-me와 Handoff는 둘 다 `mattpocock/skills`에서 와서, 5개는 4개 저장소에 걸쳐 있습니다). **Harness**는 그중 가장 신생이며 Claude Code의 *실험적* Agent Teams 기능(`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`)에 의존합니다. Harness가 내세우는 "품질 +60%" 수치는 **저자 본인의 논문(Hwang, 2026) 기준**이며 독립적으로 재현되지 않았습니다 — 신뢰할 만하지만, 본인 사례에서 직접 확인해볼 가치가 있습니다. 스타 수는 변동하므로 각 저장소에서 현재 수치를 확인하세요. **Karpathy** 4원칙은 카파시가 LLM 코딩 함정에 대해 공개적으로 남긴 관찰에서 *영감을 받아* `multica-ai`가 정리한 것으로, 카파시 본인이 이 네 가지를 열거한 것은 아닙니다 — 명칭과 문구는 저장소 저자의 것입니다.

---

## 🎸 5번째 악기에 대하여

4개는 **단일 에이전트가 더 잘 일하도록** 돕습니다(명세·검증·명확화·품질·인계). Harness는 종류가 다릅니다 — **하나의 큰 작업을 여러 에이전트 팀에 나누는** 도구입니다. 이 차이 때문에 Harness는 *선택적* 5번째이며, Tier 3과 단 하나의 조건 뒤에 둡니다:

> 작업이 단일 에이전트로는 정말 벅찰 때만 Harness를 부르세요 — 예: 뚜렷한 전문 분야(프론트엔드 / 백엔드 / QA)로 나뉘는 작업, 또는 대규모 조사·구축 작업.

솔직히 말하면: Harness는 **이 패키지가 생성하지 않으며**(외부 플러그인 `revfactory/harness`), 여섯 중 **가장 신생**이고, **실험적** Claude Code 기능(`AGENT_TEAMS=1`)에 의존합니다. 대부분의 프로젝트에서는 쓸 일이 없고, 오케스트라는 "5중주 + 선택적 객원"으로 잘 동작합니다. 그럼에도 포함한 이유는 — 에이전트 팀 설계가 SDD의 작업 분해 단계와 깔끔하게 맞물리는, 실제로 활발히 채택되는 접근이기 때문입니다. 단, 작업이 요구할 때만 제 자리를 얻습니다.

---

## ⚖️ 솔직한 한계

공정한 문서라면 도움이 *안 될 수도* 있는 지점을 밝혀야 합니다:

- **결합 효과는 미검증.** 각 도구는 개별적으로 신뢰할 만하지만, 5개를 결합하면 누적 효과가 난다는 주장은 측정된 결과가 아니라 가설입니다. 아직 공개된 실사용 데이터가 없습니다.
- **스킬 2개가 `main` 경로에 고정됨.** `grill-me`·`handoff`는 `mattpocock/skills`의 `main` 브랜치 고정 경로에서 `curl`로 받아옵니다(해당 repo는 플러그인을 문서화하지 않음). upstream이 그 파일을 옮기거나 이름을 바꾸면 경로를 갱신하기 전까지 설치가 깨집니다. (spec-kit은 자체 CLI; `karpathy-guidelines`·`harness`는 `/plugin`으로 설치 — 모두 영향 없음.) 이 `curl` 2개의 견고화 — 커밋 SHA 고정 — 는 **현재 보류** 상태이며, 스킬 설치 실패 시 "upstream 경로 변경"으로 보시면 됩니다.
- **spec-kit 동작은 가정일 뿐, 여기서 검증하지 않음.** 이 패키지는 `specify init`·`/speckit.*`를 호출하고 그것이 `spec.md`/`plan.md`/`tasks.md`를 만든다고 *전제*합니다. upstream 흐름이 실제로 동작하는지 확인하는 테스트가 없고, 스킬 설치는 upstream `main`에 고정됩니다(위 보류 항목 참조). upstream 버전은 직접 추적하세요.
- **부담은 실재.** 전체 흐름은 작거나 사소한 작업을 오히려 느리게 합니다. 그래서 [단계적 도입](#-단계적-도입)이 있습니다 — 모든 걸 어디에나 쓰는 건 이 패키지가 설파하는 "Simplicity First" 원칙에 위배됩니다.
- **에이전트 준수는 보장 안 됨.** Claude Code는 긴 세션에서 단계를 건너뛰거나, 형식만 채우거나, `CONSTITUTION.md`에서 이탈할 수 있습니다. 스킬이 유도하지만, LLM의 확률적 특성상 100% 준수는 불가능합니다.
- **도구 간 마찰 존재.** 구성요소들이 서로 당길 수 있습니다 — 예: grill-me의 집요한 질문 vs "빠르게" 우선순위. 충돌 시 더 낮은 단계와 사용자의 명시적 의도를 우선하세요.
- **강제의 한계.** 게이트는 프로세스 최소치(스펙 존재, 테스트 통과, 동작 보존)를 강제할 뿐, *사고의 質*은 강제하지 못합니다. 스펙이 존재해도 얕을 수 있습니다. 게이트는 쉬운 실패(테스트 건너뛰기, 계획 없이 코딩)를 막을 뿐, 사람의 판단과 리뷰를 대체하지 않습니다.

이 중 어느 것이든 이득보다 크다면, Tier 1만 쓰거나 패키지를 아예 건너뛰세요. 그것도 타당한 선택입니다.

---

## ❓ FAQ

<details>
<summary><b>Q: 신규/레거시/운영 중 무엇으로 적용되는지 모르겠어요</b></summary>

그냥 시작하세요. 모드를 고를 필요가 없습니다. SDD가 디렉터리를 스캔해 컨텍스트(코드 규모·git·운영 시그널)를 파악하고, 같은 흐름을 돌리되 게이트 엄격도만 자동 조절합니다.
</details>

<details>
<summary><b>Q: 인터뷰가 부담스러워요</b></summary>

5-7개 질문이며, 각 질문에 **AI 추천 답변이 함께 제공**됩니다. "yes"만 눌러도 진행 가능합니다.
</details>

<details>
<summary><b>Q: 운영 프로젝트인데 적용하고 싶어요</b></summary>

**적용 가능합니다 — 차단하지 않습니다.** 운영 시그널(배포 설정 등)이 감지되면 SDD가 강제 레벨을 `strict`로 올려, 테스트와 회귀 검사가 **필수·우회 불가**가 됩니다. 같은 흐름에 더 엄격한 게이트가 적용되는 것뿐입니다.

권장 사항:
- 운영 영향 없는 feature branch에서 시작
- 새 기능 1개부터 점진 도입
- 팀 합의 후 확대
</details>

<details>
<summary><b>Q: 통합 도중 멈추고 싶으면?</b></summary>

Git으로 즉시 롤백:
```bash
git reset --hard HEAD~1
```

또는 `archive/`에서 복원 (있다면):
```bash
cp -r archive/legacy/* ./
```

자세한 롤백 가이드는 `symphony/INTEGRATION-CHECKLIST.ko.md` 참조.
</details>

<details>
<summary><b>Q: 매번 SDD 7단계를 모두 거쳐야 하나요?</b></summary>

아니오. 작업 크기에 비례:
- 1줄 수정 → No SDD (Karpathy만)
- 작은 기능 → Mini SDD (spec → implement → handoff만)
- 큰 기능 → Full SDD (7단계 모두)
</details>

<details>
<summary><b>Q: Claude Code 외 다른 AI 도구에서도 쓸 수 있나요?</b></summary>

현재는 Claude Code에 최적화되어 있습니다. 다음을 활용하기 때문:
- `CLAUDE.md` 자동 로드
- `.claude/skills/` Skill 시스템

다른 AI 도구(Cursor, Cline 등) 지원은 추후 고려.
</details>

<details>
<summary><b>Q: 팀에 도입하고 싶어요</b></summary>

권장 순서:
1. 본인 프로젝트에 1회 적용
2. 1주~1개월 사용 후 효과 검증
3. 팀에 시연
4. 동료 1-2명과 함께 도입
5. 점진 확대

`CLAUDE.md`가 자동 로드되므로 팀원 각자 Claude Code 사용 시 자동 적용됩니다.
</details>

<details>
<summary><b>Q: 학습 곡선이 어떻게 되나요?</b></summary>

- **첫 주**: 약간의 부담, 주로 Mini SDD
- **첫 달**: Full SDD 2-3회, 익숙해짐
- **그 후**: 자연스러운 흐름, 게이트가 보이지 않게 됨
</details>

---

## 📊 적용 후 변화 (예상)

### 정성적 변화
- ✅ AI 응답의 일관성 향상
- ✅ 코드 변경의 명확성 향상
- ✅ 결정 추적 가능성 향상
- ✅ 핸드오프 품질 향상
- ✅ 학습 효과 (워크플로우 자체가 학습)

### 정량적 측정
- DECISION-LOG.md 항목 수
- SDD 사이클 수
- grill-me 발동 횟수
- Karpathy 4원칙 위배 사례

→ `symphony/INTEGRATION-CHECKLIST.ko.md`에서 Day 0/7/30 시점에 측정

---

## 🆘 문제 해결

### 인터뷰 단계에서 막혔어요
→ `symphony/AI-INTERVIEW.ko.md`의 "인터뷰 시 자주 발생하는 상황 가이드" 참조

### 실행 중 오류
→ `symphony/AI-EXECUTION.ko.md`의 해당 모드 섹션 재확인

### SDD와 스킬 구조가 이해가 안 가요
→ `symphony/ORCHESTRA-GUIDE.ko.md` 정독

### 적용 후 검증 방법
→ `symphony/INTEGRATION-CHECKLIST.ko.md` Day 0 체크리스트

---

## 🛣️ 로드맵

### 최근 출시 (v2)
- ✅ 강제 게이트 (R1–R7)
- ✅ 보편 적용 (신규/레거시/운영)
- ✅ 컨텍스트 기반 동적 평가 (모드 없음)
- ✅ SDD 아래 4개 스킬
- ✅ archive 백업 전략
- ✅ 이중 언어 문서 (영문 + 한국어)

### 진행 중
- 🚧 사례 모음
- 🚧 Cursor 적용 가이드
- 🚧 Cline 적용 가이드

### 계획
- 📋 추가 언어 문서 (중문, 일문)
- 📋 비디오 튜토리얼
- 📋 강제 게이트 템플릿 확충 (언어별 테스트 러너)
- 📋 정량 측정 도구
- 📋 팀 도입 플레이북

### 장기
- 🌟 웹 기반 인터뷰 도구
- 🌟 자동화된 효과 측정 대시보드
- 🌟 커뮤니티 사례 모음

---

## 🤝 기여

피드백, 이슈, PR 환영합니다.

### 가장 환영하는 기여
1. **사례 공유** — Spec-Driven Orchestra 적용 후 결과 공유 ⭐
2. **자료 큐레이션** — 관련 도구/방법론 PR
3. **다른 도구 적용** — Cursor/Cline/Aider 가이드
4. **번역** — 다국어 지원
5. **튜토리얼** — 신규 사용자 위한 콘텐츠

### 기여 방법
1. **Issue로 의견 공유**
2. **Fork** 후 작업
3. **feature 브랜치 생성** (`git checkout -b feat/amazing-addition`)
4. **변경사항 커밋** (`git commit -m 'feat: amazing addition'`)
5. **푸시** (`git push origin feat/amazing-addition`)
6. **Pull Request 오픈**

### 가이드라인
- 친절하고 건설적으로
- 제출 전 테스트
- 변경사항 문서화
- 기존 스타일 따르기

---

## 📜 라이선스

MIT License - [LICENSE](./LICENSE) 파일 참조.

**TL;DR**: 자유롭게 사용, 수정, 배포 가능. 출처 명시만 유지.

---

## 🙏 감사

이 프로젝트는 다음의 거인들 어깨 위에 서있습니다:

- **Andrej Karpathy** ([@karpathy](https://x.com/karpathy)) - 원칙의 바탕이 된 LLM 코딩 함정 관찰
- **multica-ai** ([@jiayuan_jy](https://x.com/jiayuan_jy)) - 그 관찰에서 도출한 [4원칙 정리](https://github.com/multica-ai/andrej-karpathy-skills)
- **GitHub Spec Kit** 팀
- **Matt Pocock** ([@mpocock1](https://x.com/mpocock1)) - grill-me
- **Anthropic** ([@AnthropicAI](https://x.com/AnthropicAI)) - Claude Code
- **전체 AI 코딩 커뮤니티**

조기 도입자분들의 피드백에 특별히 감사드립니다.

---

## 🌟 Star History

<p align="center">
  <a href="https://star-history.com/#hongdosan/hongdosan-spec-driven-orchestra">
    <img src="https://api.star-history.com/svg?repos=hongdosan/hongdosan-spec-driven-orchestra&type=Date" alt="Star History Chart" />
  </a>
</p>

---

## 📬 연락

- 💬 [Discussions](https://github.com/hongdosan/hongdosan-spec-driven-orchestra/discussions) — Q&A, 아이디어
- 🐛 [Issues](https://github.com/hongdosan/hongdosan-spec-driven-orchestra/issues) — 버그, 요청
- 👤 제작자: [@hongdosan](https://github.com/hongdosan)

---

## 🎯 도움이 되셨다면

⭐ **레포에 별을 눌러주세요** - 도움 되셨다면!
🍴 **Fork** - 팀에 맞게 커스터마이징
📢 **공유** - 동료 개발자에게
💡 **기여** - 함께 발전시켜요

함께 AI 코딩의 미래를 오케스트레이션해봅시다.

---

## 🎯 한 줄 요약

> **파일을 프로젝트에 복사하고 Claude Code에 "AI-INTERVIEW.md 읽고 시작"이라고 던지세요. SDD가 컨텍스트를 파악해 같은 흐름을 돌리고, 강제 게이트가 단계를 건너뛰는 것을 막습니다. 신규·레거시·운영 어디서든 적용되며, 모드 없이 게이트 엄격도만 달라집니다.**

---

<p align="center">
  <i>Created with 🎼 by <a href="https://github.com/hongdosan">@hongdosan</a></i>
</p>

<p align="center">
  <sub>유용하셨다면 ⭐ 별을 눌러주세요!</sub>
</p>
