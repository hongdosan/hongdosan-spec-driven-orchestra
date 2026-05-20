# 🎼 AI 코딩론 통합 패키지

> **신규/초기/리팩토링 프로젝트를 위한 AI 인터뷰 기반 자율 통합 패키지**

---

## 📦 패키지 구성 (5개 파일)

| # | 파일 | 용도 |
|---|---|---|
| 1 | **README.md** | 이 파일 (사용 안내) |
| 2 | **AI-INTERVIEW.md** | 인터뷰 진행 (시작점) ⭐ |
| 3 | **AI-EXECUTION.md** | 실행 지시 (인터뷰 후) |
| 4 | **ORCHESTRA-GUIDE.md** | 5중주 가이드 |
| 5 | **INTEGRATION-CHECKLIST.md** | 검증 체크리스트 |

---

## 🎯 이 패키지가 적용 가능한 프로젝트

### ✅ 적용 가능

| 유형 | 설명 | 적용 모드 |
|---|---|---|
| **신규 프로젝트** | 이제 막 시작, 코드 0% | MODE_GREENFIELD |
| **초기 진행** | 1-2주 작업, 10-30% | MODE_EARLY |
| **리팩토링 TF** | 기존 코드 싹 갈아엎기 | MODE_REBUILD |

### ❌ 적용 불가

| 유형 | 이유 |
|---|---|
| **운영 중 서비스** | 사용자/데이터 영향 위험, 별도 패키지 필요 |
| **레거시 유지보수** | 점진적 개선이 적합, 본 패키지는 부적합 |

→ 인터뷰 단계에서 운영 프로젝트 감지 시 **자동 차단**됩니다.

---

## 🚀 사용 방법 (3단계)

### Step 1: 파일 배치

```bash
# 5개 파일을 프로젝트 루트에 복사
cp ~/Downloads/README.md ./
cp ~/Downloads/AI-INTERVIEW.md ./
cp ~/Downloads/AI-EXECUTION.md ./
cp ~/Downloads/ORCHESTRA-GUIDE.md ./
cp ~/Downloads/INTEGRATION-CHECKLIST.md ./
```

### Step 2: Git 안전망 (선택, 권장)

```bash
git checkout -b feat/ai-integration
git add *.md
git commit -m "docs: AI 통합 패키지 v2 추가 (실행 전)"
```

### Step 3: Claude Code에 던지기

```bash
claude
```

다음 메시지 전달:

```
AI-INTERVIEW.md를 읽고 인터뷰부터 시작해주세요.
인터뷰 완료 후 결정된 모드로 자율 진행 부탁드립니다.
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
│  Step 3: 인터뷰 진행 (5-10분)                     │
│  AI: 5-7개 질문 (각 추천 답변 포함)               │
│  사용자: 답변                                    │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 4: 모드 결정 + 계획 수립                    │
│  AI: MODE_GREENFIELD/EARLY/REBUILD 중 결정       │
│  AI: 1회 승인 요청                               │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 5: 자율 진행 (10-30분)                      │
│  AI: AI-EXECUTION.md의 해당 모드 진행            │
│                                                  │
│              ↓                                   │
│                                                  │
│  Step 6: 검증                                    │
│  사용자: INTEGRATION-CHECKLIST.md로 확인          │
│                                                  │
└──────────────────────────────────────────────────┘
```

---

## 🎼 통합 후 무엇이 생기는가

### 공통 자산 (모든 모드)

```
프로젝트 루트/
├── CLAUDE.md                    # AI 진입점
├── DECISION-LOG.md              # 결정 기록
├── INTEGRATION-REPORT.md        # 통합 리포트
├── INTERVIEW-RESULT.md          # 인터뷰 결과
│
├── .claude/skills/              # 5개 skill
│   ├── grill-me/                # 🎹 명확화
│   ├── sdd-conductor/           # 🎼 지휘자
│   ├── karpathy-enforcer/       # 🎻 4원칙 강제
│   ├── harness-builder/         # 🥁 검증 설계
│   └── handoff-writer/          # 🎺 인계 작성
│
└── sdd/                         # SDD 중심
    ├── CONSTITUTION.md          # 프로젝트 헌법 (모드별 다름)
    ├── ORCHESTRA.md             # 5중주 가이드
    ├── README.md                # SDD 안내
    ├── templates/               # 단계별 템플릿
    └── features/                # 기능별 작업물
```

### 모드별 추가 자산

#### MODE_GREENFIELD (신규)
```
sdd/templates/             # 7개 (01~07)
sdd/features/F000-bootstrap/  # 첫 SDD = 프로젝트 부트스트랩
```

#### MODE_EARLY (초기 진행)
```
sdd/templates/             # 7개 (01~07)
sdd/features/F000-integration/ # 첫 SDD = 통합 시연
archive/                    # 기존 자산 (있다면) 백업
```

#### MODE_REBUILD (리팩토링)
```
sdd/templates/             # 9개 (00, 01~07, 05b)
  └─ 00-archaeology.md     # 추가: 기존 코드 분석
  └─ 05b-regression.md     # 추가: 기존 동작 보장
sdd/features/F000-rebuild-plan/ # 첫 SDD = 리팩토링 계획
archive/legacy/             # 기존 전체 백업
```

---

## 🎵 5중주 한눈에

```
                    🎼 지휘자
                       SDD
                  (전체 흐름 통제)
                       │
        ┌──────────────┼──────────────┐
        │              │              │
    🎻 1st         🥁 percussion    🎹 piano
    Violin         (리듬 강제)       (감정/표현)
                       │
   Karpathy 4원칙   Harness        grill-me
                       │
                    🎺 Brass
                       │
                    Handoff
                  (악장 간 연결)
```

---

## ⚠️ 주의 사항

### 1. 운영 프로젝트 차단

이 패키지는 **운영 중인 프로젝트에 적용 시 명시적으로 거부**합니다:
- 인터뷰 단계에서 감지
- 거부 메시지 + 다른 접근 안내

### 2. 안전성

- 기존 자산 → `archive/` 백업 (삭제 X)
- 글로벌 설정 → 절대 건드리지 않음
- Git 추적 가능 → 언제든 롤백

### 3. 인터뷰 시 솔직히 답변

- AI가 추측한 모드가 틀리면 → 직접 수정
- 모르는 질문은 → "잘 모름" 선택 (AI가 합리적 기본값)
- 답변 후 모드 변경 가능

---

## 📚 원본 자료

이 패키지가 통합하는 5가지 AI 코딩론:

| 도구 | 출처 |
|---|---|
| **Spec Kit** (SDD) | https://github.com/github/spec-kit |
| **Karpathy Guidelines** | https://github.com/multica-ai/andrej-karpathy-skills |
| **grill-me Skill** | https://github.com/mattpocock/skills |
| **Harness Engineering** | 검증 기준 설계 방법론 |
| **Handoff** | 작업 인계 방법론 |

---

## ❓ FAQ

### Q: 어떤 모드가 적합한지 모르겠어요.
A: 그냥 인터뷰를 시작하세요. AI가 디렉터리 스캔하면서 추측해줍니다.

### Q: 인터뷰가 부담스러워요.
A: 5-7개 질문이며, 각 질문에 AI 추천 답변이 있어 "yes"만 눌러도 됩니다.

### Q: 중간에 모드를 바꾸고 싶으면?
A: 인터뷰 완료 후 모드 결정 시 변경 가능. 실행 시작 후엔 롤백 필요.

### Q: 운영 프로젝트인데 적용하고 싶어요.
A: 본 패키지는 적합하지 않습니다. 추후 운영 프로젝트용 별도 패키지를 고려하세요.

### Q: 통합 도중 멈추고 싶으면?
A: Git으로 즉시 롤백:
```bash
git reset --hard HEAD~1
```

---

## 🆘 막혔을 때

1. **모드 결정 전**: AI-INTERVIEW.md 다시 읽기
2. **실행 중**: AI-EXECUTION.md 확인
3. **5중주 이해**: ORCHESTRA-GUIDE.md 참조
4. **검증**: INTEGRATION-CHECKLIST.md 체크

---

## 🎯 한 줄 요약

> **5개 파일을 프로젝트에 복사하고 Claude Code에 "AI-INTERVIEW.md 읽고 시작"이라고 던지세요. AI가 인터뷰로 상황을 파악하고, 적합한 모드로 자율 통합합니다. 운영 프로젝트는 자동 차단됩니다.**

🎼
