# 🎼 Symphony — AI 코딩 방법론 패키지

> **신규/초기/리팩토링 프로젝트를 위한 AI 인터뷰 기반 통합 패키지**

<p align="center">
  🌐 <b>언어</b>: <a href="./README.md">English</a> | <b>한국어</b>
</p>

> [!NOTE]
> **실험적(Experimental).** SDD 프레임워크와 그것이 호출하는 4개 스킬을 통합하며 — 5개 악기 모두 오픈소스 저장소 기반(4개 저장소)입니다 — 그 *결합* 효과는 아직 측정되지 않았습니다. 한 번에 다 도입하지 말고 — Tier 1(Karpathy + grill-me)부터 시작해 필요할 때 올라가세요. 전체 단계 가이드와 솔직한 한계는 루트 [README](../README.ko.md)에 있습니다.

---

## 📦 패키지 구성

| # | 파일 | 용도 |
|---|---|---|
| 1 | **README.ko.md** | 이 파일 (사용 안내) |
| 2 | **AI-INTERVIEW.ko.md** | 시작점 — 컨텍스트 평가 + 게이트 설치 ⭐ |
| 3 | **AI-EXECUTION.ko.md** | 실행 지시 (평가 후) |
| 4 | **ORCHESTRA-GUIDE.ko.md** | SDD와 그 스킬 가이드 |
| 5 | **INTEGRATION-CHECKLIST.ko.md** | 검증 체크리스트 |
| 6 | **spec-kit-요약.ko.md** | spec-kit 한국어 다리 (비강제 요약, 영문 원본 우선) |

> 각 파일은 영문 기본판이 있습니다: 접미사 없는 `*.md` — 단 `spec-kit-요약.ko.md`는 한국어 전용이며, 그 영문 짝은 spec-kit 자체 README입니다.
> 강제 템플릿(hooks, CI 게이트, CONSTITUTION)은 레포의 `enforcement/` 폴더에, 핵심 사실은 `SPEC.yml`에 있습니다.

---

## 🎯 적용 가능한 프로젝트

**보편 — 어떤 프로젝트든, 어느 단계든.** 모드는 없습니다. SDD가 컨텍스트를 평가해 하나의 흐름을 돌리며, 강제 엄격도만 달라집니다.

| 유형 | SDD가 하는 일 | 게이트 레벨 |
|---|---|---|
| **신규** | 흐름 실행; 보존할 게 없음 | standard |
| **초기/진행 중** | 코드 변경 전 0단계 조사 추가 | standard |
| **레거시/유지보수** | 동작 보존 위해 조사 + 회귀 | standard |
| **운영** | 같은 흐름; 게이트가 우회 불가 | **strict** |

→ 운영은 **차단되지 않습니다** — 운영 시그널 감지 시 강제 레벨을 올립니다. 레거시는 지원하되 우선하지 않습니다.

---

## 🚀 사용 방법

### Step 0: spec-kit 설치 (전제조건 — 이 패키지가 활용)

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

### Step 1: 파일 배치

```bash
# 메서드 파일을 프로젝트 루트에 복사 (한글판 → 기본 .md 이름으로)
cp symphony/AI-INTERVIEW.ko.md ./AI-INTERVIEW.md
cp symphony/AI-EXECUTION.ko.md ./AI-EXECUTION.md
cp symphony/ORCHESTRA-GUIDE.ko.md ./ORCHESTRA-GUIDE.md
cp symphony/INTEGRATION-CHECKLIST.ko.md ./INTEGRATION-CHECKLIST.md
```

> 💡 한글판으로 작업하려면 위처럼 `.ko.md`를 복사하면서 `.md`로 이름을 바꾸세요. Claude Code가 기본 진입 파일명으로 인식합니다.

### Step 2: Git 안전망 (선택, 권장)

```bash
git checkout -b feat/ai-integration
git add *.md
git commit -m "docs: Spec-Driven Orchestra 패키지 추가 (실행 전)"
```

### Step 3: Claude Code에 던지기

```bash
claude
```

다음 메시지 전달:

```
AI-INTERVIEW.md를 읽고 인터뷰부터 시작해주세요.
컨텍스트를 평가하고 `specify init`을 실행하고 강제 게이트를 설치한 뒤, SDD로 진행해주세요.
```

---

## 🎭 동작 흐름

```
┌──────────────────────────────────────────────────┐
│                                                  │
│  Step 1: Claude Code 시작                        │
│  사용자: "AI-INTERVIEW.md 읽고 시작해줘"          │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 2: 자동 스캔 (10-30초)                      │
│  AI: 디렉터리/파일/Git 상태 분석                 │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 3: 컨텍스트 평가 (5-10분)                   │
│  AI: 5-7개 질문 (각 추천 답변 포함)               │
│  사용자: 답변                                    │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 4: 게이트 설치 + 계획 수립                  │
│  AI: 강제 레벨 결정 (standard/strict)            │
│  AI: hooks + CI 게이트 설치                       │
│  AI: 1회 승인 요청                               │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 5: 자율 진행 (10-30분)                      │
│  AI: 게이트 아래에서 단일 SDD 흐름 실행          │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 6: 검증                                    │
│  사용자: INTEGRATION-CHECKLIST 로 확인           │
│                                                  │
└──────────────────────────────────────────────────┘
```

---

## 🎼 통합 후 무엇이 생기는가

### 항상 생성

```
프로젝트 루트/
├── CLAUDE.md                    # AI 진입점
├── DECISION-LOG.md              # 결정 기록
├── INTEGRATION-REPORT.md        # 통합 리포트
├── INTERVIEW-RESULT.md          # 인터뷰 결과
│
├── .claude/skills/              # 이 패키지가 생성하는 4개 skill
│   ├── grill-me/                # 🎹 명확화
│   ├── sdd-conductor/           # 🎼 지휘자
│   ├── karpathy-guidelines/       # 🎻 4원칙 강제
│   └── handoff/          # 🎺 인계 작성
│                                # 🎸 Harness(에이전트 팀)는 외부 플러그인,
│                                #    필요 시 별도 설치
│
├── .specify/                    # spec-kit (`specify init`)
│   ├── memory/constitution.md   # R1~R7 규칙 (게이트가 읽음) + 원칙
│   └── templates/               # spec-kit의 spec/plan/tasks/checklist 템플릿
│
└── specs/<NNN-slug>/            # 기능별 작업물, git 브랜치 단위 (/speckit.*)
    ├── spec.md  plan.md  tasks.md          # spec-kit 산출
    └── survey.md  regression.md            # 이 패키지의 추가분
        handoff.md  implementation-notes.md
```

### 컨텍스트 추가 (모드 아님)

같은 흐름; SDD가 발견한 것에 따라 단계를 더합니다 — 고를 `MODE_*` 없음:

```
기존 코드 있음
  └─ survey.md      추가: 바꾸기 전에 이해
  └─ regression.md 추가: 기존 동작 보존 (R4)

운영 시그널 감지
  └─ ENFORCEMENT_LEVEL=strict — 테스트/회귀 우회 불가 (R6)

신규
  └─ 같은 흐름·게이트; 보존할 게 없어 쉽게 통과
```

추가로 강제 레이어(`enforcement/`에서 설치):
```
.claude/hooks/pre-implement.sh   # R1,R2 — spec+plan 없이 코드 불가
.claude/hooks/post-task.sh       # R5 — handoff 누락 경고
.git/hooks/pre-commit            # R3,R4,R6 — 테스트 미통과 커밋 불가
.github/workflows/sdd-gate.yml   # R1,R3,R6,R7 — 우회 불가 머지 게이트
```

---

## 🎵 SDD와 그 스킬 한눈에

```
            🎼 SDD — 프레임워크 (지휘자)
        Spec → Clarify → Plan → Tasks → Verify → Implement → Handoff
            + 강제 게이트 (hooks / CI)
                          │
        ┌─────────────┬───┴───┬─────────────┐
        │             │       │             │
   🎻 Violin      🎹 Piano  🎺 Brass     🎸 Guitar
   Karpathy 4원칙  grill-me  Handoff      Harness
   (품질)         (명확화)  (인계)       (에이전트 팀)
        └────────── 지휘자가 호출하는 스킬 ──────────┘
```

---

## ⚠️ 주의 사항

### 1. 운영 → strict 게이트 (차단 아님)

이 패키지는 운영 프로젝트에도 적용되며, 강제를 strict로 올립니다:
- 자동 감지 (배포 설정, `.env.production` 등)
- 테스트와 회귀가 필수·우회 불가가 됨 (R6)

### 2. 안전성

- 기존 자산 → `archive/` 백업 (삭제 X)
- 글로벌 설정 → 절대 건드리지 않음
- Git 추적 가능 → 언제든 롤백

### 3. 평가 시 솔직히 답변

- AI가 읽은 컨텍스트가 틀리면 → 직접 수정
- 모르는 질문은 → "잘 모름" 선택 (AI가 합리적 기본값)
- 답변 후 강제 레벨 조정 가능

---

## 📚 원본 자료

이 패키지가 통합하는 5개 악기 — 모두 오픈소스 프로젝트 (성숙도는 정성 표기 — 정확한 스타 수는 변동하므로 각 저장소에서 확인):

| 도구 | 역할 | 출처 | 성숙도 |
|---|---|---|---|
| **Spec Kit** (SDD) | 프레임워크 — 명세 기반 흐름 | https://github.com/github/spec-kit | 확립됨 |
| **Karpathy Guidelines** | 코드 품질 (4원칙) | https://github.com/multica-ai/andrej-karpathy-skills | 확립됨 |
| **grill-me Skill** | 명확화 | https://github.com/mattpocock/skills | 확립됨 |
| **Handoff Skill** | 작업 인계 | https://github.com/mattpocock/skills | 확립됨 |
| **Harness** | 에이전트 팀·스킬 설계자 | https://github.com/revfactory/harness | 널리 채택됨, 가장 신생 |

> 🎸 **Harness**는 선택적 5번째 악기입니다: 외부 플러그인(여기서 생성 안 함)이며, Claude Code의 실험적 Agent Teams 기능에 의존합니다. 작업에 정말 에이전트 팀이 필요할 때만 쓰세요.

---

## ❓ FAQ

### Q: 신규/레거시/운영 중 무엇으로 적용되는지 모르겠어요.
A: 그냥 시작하세요. 모드를 고를 필요가 없습니다. SDD가 컨텍스트를 파악해 같은 흐름을 돌리되 게이트 엄격도만 자동 조절합니다.

### Q: 평가가 부담스러워요.
A: 5-7개 질문이며, 각 질문에 AI 추천 답변이 있어 "yes"만 눌러도 됩니다.

### Q: 운영 프로젝트인데 적용하고 싶어요.
A: 적용 가능합니다. 운영 시그널 감지 시 강제 레벨이 strict로 올라가 테스트·회귀가 필수·우회 불가가 됩니다.

### Q: 통합 도중 멈추고 싶으면?
A: Git으로 즉시 롤백:
```bash
git reset --hard HEAD~1
```

---

## 🆘 막혔을 때

1. **시작 전**: AI-INTERVIEW.ko.md 다시 읽기
2. **실행 중**: AI-EXECUTION.ko.md 확인
3. **SDD와 스킬 이해**: ORCHESTRA-GUIDE.ko.md 참조
4. **검증**: INTEGRATION-CHECKLIST.ko.md 체크

---

## 🎯 한 줄 요약

> **파일을 프로젝트에 복사하고 Claude Code에 "AI-INTERVIEW.md 읽고 시작"이라고 던지세요. SDD가 컨텍스트를 파악해 하나의 흐름을 돌리고, 강제 게이트가 단계 건너뛰기를 막습니다. 신규·레거시·운영 어디서든 적용되며, 게이트 엄격도만 달라집니다.**

🎼
