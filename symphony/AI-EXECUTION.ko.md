# 🛠️ AI 실행 지시서 - 단일 SDD 흐름

> **이 파일은 AI-INTERVIEW.ko.md 완료 후 진행됩니다.** 모든 프로젝트에 하나의 흐름이 적용되며, 컨텍스트(기존 코드, 운영 시그널)는 단계를 더하고 강제 엄격도를 올릴 뿐입니다.

> [!NOTE]
> 평가에서 정한 **단계(Tier)**를 존중하세요. Tier 1 = SDD + Karpathy + grill-me; Tier 2 = + Handoff; Tier 3 = + 🎸 Harness. 단계가 요구하는 것만 생성하고 — Tier 1 프로젝트에 전부 강요하지 마세요. 🎸 Harness는 외부 플러그인이며, 작업에 에이전트 팀이 필요할 때만 도입합니다.

---

## 📌 진입점

평가에서 정한 두 설정이 실행을 좌우합니다:

- **강제 레벨**: `standard` 또는 `strict` (strict = 운영; 게이트 우회 불가)
- **0단계 조사**: 켬 (기존 코드) 또는 끔 (신규)

흐름 자체는 모든 경우에 동일합니다. 아래 섹션:
- [공통 원칙](#-공통-원칙) → 항상 적용
- [공통 자산](#-공통-자산) → 항상 생성
- [기존 코드 스킬](#-기존-코드-스킬-조사--마이그레이션) → 기존 코드가 있을 때만 사용
- 부록 → 표준 템플릿

---

## 🌐 공통 원칙

### 자율 진행
- 사용자 컨펌 없이 진행 (평가에서 이미 승인받음)
- 시간/토큰 무제한
- 모든 결정 DECISION-LOG.md 기록

### 안전
- 글로벌 설정 (`~/.claude/`) 절대 금지
- archive/ 의 내용 삭제 금지
- Git 추적 가능

### 보고
- Phase 종료 시 간단 보고
- 다음 Phase 자동 진행
- 완료 시 종합 리포트

---

## 📂 공통 자산

### 공통 디렉터리 구조

항상 생성:

```
프로젝트 루트/
├── CLAUDE.md                    # AI 진입점
├── DECISION-LOG.md              # 결정 기록
├── INTEGRATION-REPORT.md        # 통합 리포트
├── INTERVIEW-RESULT.md          # 인터뷰 결과 (이미 생성됨)
│
├── .claude/skills/              # 이 패키지가 생성하는 4개 skill
│   ├── grill-me/
│   ├── sdd-conductor/
│   ├── karpathy-guidelines/
│   └── handoff/
│                                # 🎸 Harness(에이전트 팀)는 여기서 생성되지 않음
│                                #    — 외부 Claude Code 플러그인(revfactory/harness)
│                                #    으로, 작업에 에이전트 팀이 필요할 때만 별도 설치.
│
├── .specify/                    # spec-kit, `specify init`이 생성 (여기서 작성하지 않음)
│   ├── memory/constitution.md   #   프로젝트 원칙 + 우리 R1~R7 규칙
│   └── templates/               #   spec-kit의 spec/plan/tasks/checklist 템플릿
│
└── specs/<NNN-slug>/            # feature 브랜치별, /speckit.*가 생성
    ├── spec.md  plan.md  tasks.md          # spec-kit 산출
    └── survey.md  regression.md            # 이 패키지의 추가분 (레거시/인계)
        handoff.md  implementation-notes.md
```

### 공통 4개 Skill 생성

이 스킬들은 **원본 upstream 저장소에서 그대로 받아옵니다** — 이 패키지가 작성하지
않습니다(규칙 R). 각 출처는 아래 `curl` URL이며 [통합되는 원본 자료](../README.ko.md) 표에도
있습니다: `grill-me`·`handoff` ← `github.com/mattpocock/skills`, `karpathy-guidelines` ←
`github.com/multica-ai/andrej-karpathy-skills`. (`sdd-conductor`는 이 패키지 고유 오케스트레이션
스킬이라, 여기서 직접 작성하는 유일한 스킬입니다.)

#### `.claude/skills/grill-me/SKILL.md`

```bash
mkdir -p .claude/skills/grill-me
curl -L https://raw.githubusercontent.com/mattpocock/skills/main/skills/productivity/grill-me/SKILL.md \
  -o .claude/skills/grill-me/SKILL.md
```

#### `.claude/skills/grill-me/VARIANT.md`

```markdown
# grill-me 프로젝트 변형 가이드

> SDD 워크플로우와 통합된 grill-me 사용법

## 활용 시점 (SDD Phase별)

### Phase 2: Clarify (주역)
\`\`\`
"grill me - F[ID] 명확화"
\`\`\`

### Phase 5: 검증 설계
\`\`\`
"grill me - F[ID] 검증 설계"
\`\`\`

### Phase 7: Handoff 작성
\`\`\`
"grill me - F[ID] 핸드오프"
\`\`\`

### 추가 활용 (기존 코드가 있을 때)

#### 기존 코드 작업 전용
\`\`\`
"grill me - F[ID] survey" (Step 0)
"grill me - F[ID] regression" (Step 5b)
"grill me - F[ID] migration" (Implement)
\`\`\`

## 결과 활용

grill-me 세션 종료 시 AI가 요약 제공.
해당 단계 문서에 그대로 붙여넣기.
```

#### `.claude/skills/sdd-conductor/SKILL.md`

```markdown
---
name: sdd-conductor
description: |
  SDD 7단계 워크플로우 지휘.
  새 기능 시작, SDD 단계 진행 시 발동.
  키워드: "새 기능", "SDD 시작", "F[ID]", "다음 단계"
---

# SDD Conductor

## 책임
1. 새 SDD 사이클 시작 (F[ID] 디렉터리 생성, 템플릿 복사)
2. 각 단계 진행 (Phase 2→grill-me, Phase 5→SDD 검증, Phase 6→karpathy-guidelines, Phase 7→handoff)
3. 순서 강제 (단계 건너뛰기 차단)
4. 결정 추적 (Decision Log + DECISION-LOG.md)

## 작업 분류
- **Full SDD**: 새 기능, 큰 리팩토링 → 7단계 모두
- **Mini SDD**: 작은 기능, 버그 → 01, 06, 07만
- **No SDD**: 1줄 수정, 오타 → Karpathy만
```

#### `.claude/skills/karpathy-guidelines/SKILL.md`

원본 스킬을 출처에서 설치합니다 (여기서 다시 작성하지 않음):

```bash
mkdir -p .claude/skills/karpathy-guidelines
curl -L https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/skills/karpathy-guidelines/SKILL.md \
  -o .claude/skills/karpathy-guidelines/SKILL.md
```

#### `.claude/skills/handoff/SKILL.md`

원본 스킬을 출처에서 설치합니다 (여기서 다시 작성하지 않음):

```bash
mkdir -p .claude/skills/handoff
curl -L https://raw.githubusercontent.com/mattpocock/skills/main/skills/productivity/handoff/SKILL.md \
  -o .claude/skills/handoff/SKILL.md
```

---

---

## 🔁 실행 흐름 (단일·보편)

흐름은 하나입니다. 모드로 분기하지 않습니다. 평가에서 정한 두 설정이 흐름을 조정합니다:
**강제 레벨**(standard/strict)과 **0단계 조사**(켬/끔). 아래 모든 것은 신규·레거시·운영
프로젝트에서 동일하게 실행됩니다.

### Phase 1: spec-kit + 강제 레이어 설치 (항상)

먼저 우리가 활용할 프레임워크 — **spec-kit** — 을 설치하고, 그것이 `.specify/`와
`/speckit.*` 명령을 스캐폴딩하게 합니다. 이 부분은 우리가 재작성하지 않습니다(규칙 R).

```bash
# spec-kit (SDD 프레임워크). https://github.com/github/spec-kit
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify init --here --integration claude   # .specify/ + /speckit.* 명령 생성
```

그다음 **우리 delta** — spec-kit이 제공하지 않는 차단 게이트 — 를 설치합니다:

```bash
# 로컬 훅 (/speckit.*가 만드는 specs/<branch>/를 가리킴)
mkdir -p .claude/hooks
cp enforcement/hooks/pre-implement.sh .claude/hooks/
cp enforcement/hooks/post-task.sh    .claude/hooks/
cp enforcement/hooks/pre-commit.sh   .git/hooks/pre-commit
chmod +x .claude/hooks/*.sh .git/hooks/pre-commit

# CI 게이트 + sync-check (R7)
mkdir -p .github/workflows
cp enforcement/github-workflows/sdd-gate.yml .github/workflows/

# 게이트가 쓸 검증 명령 설정
export SDD_TEST_CMD="[npm test | pytest -q | go test ./... | cargo test]"

# strict(운영 시그널)이면: R3/R4를 우회 불가로 만드는 레벨 설정
# export ENFORCEMENT_LEVEL=strict
```

> 이 단계가 패키지를 "권고가 아니라 강제"로 만듭니다. spec-kit 자신의
> `/speckit.analyze`·`/speckit.checklist`는 AI 실행 점검이지 차단 게이트가 아닙니다 —
> 위 git/CI 게이트가 이 패키지의 delta입니다.

### Phase 2: 공통 자산 생성 (항상)

`specify init`(Phase 1)이 이미 `.specify/`와 feature별 `specs/`를 만들었습니다. 여기서는
SDD가 호출하는 스킬만 더합니다:

```bash
# SDD가 호출하는 4개 스킬 (출처에서 설치 — "공통 4개 Skill 생성" 참조)
mkdir -p .claude/skills/{grill-me,sdd-conductor,karpathy-guidelines,handoff}
# (🎸 Harness는 외부 플러그인 — 작업에 에이전트 팀이 필요할 때만 별도 설치)
```

### Phase 3: 템플릿

- **spec-kit이 제공**: 코어 템플릿(`spec.md`·`plan.md`·`tasks.md`·`checklist`·`constitution`)을
  `.specify/templates/`에 — 우리가 작성하지 않습니다(규칙 R).
- **이 패키지가 추가**(필요 시에만): `survey.md`·`regression.md`(기존 코드)와
  `handoff.md`·`implementation-notes.md` — 부록 A 참조. `specs/<branch>/`에 위치.

### Phase 4: Step 0 — 조사 (기존 코드가 있을 때만)

신규에서는 완전히 건너뜁니다. 기존 코드가 있으면 바꾸기 전에 이해합니다:

```bash
# 기존 자산 먼저 백업 (수정하지 않고 참조만)
mkdir -p archive/
[기존 코드/문서/설정 복사 → archive/legacy/...]
# archive/README.md 작성 (매핑 + 롤백 방법)
```

그다음 조사를 실행하고(기존 코드 스킬 참조), 보존할 동작(B1, B2, ...)을
`specs/<branch>/survey.md`에 기록합니다. 이것이 `regression.md`의 입력이 됩니다 (R4).

### Phase 5: 첫 SDD 사이클 (spec-kit 명령 실행)

feature = git 브랜치(spec-kit `NNN-slug` 관례). **spec-kit 자신의 명령**을 실행합니다 —
무엇을 하는지 재서술하지 않고 호출만 합니다(규칙 R):

```
/speckit.constitution   → .specify/memory/constitution.md   (프로젝트 원칙 + R1~R7)
/speckit.specify        → specs/<branch>/spec.md            (What & Why, 수용/엣지/성공기준)
/speckit.clarify        → 명확화를 spec.md에 직접 기록
/speckit.plan           → specs/<branch>/plan.md
/speckit.tasks          → specs/<branch>/tasks.md  (+ 선택: 🎸 Harness 에이전트 팀)
/speckit.analyze        → 교차 산출물 일관성 점검 (advisory)
/speckit.implement      → tasks.md대로 구현
```

이 패키지의 추가분은 필요할 때만 옆에 둡니다:

```
specs/<branch>/
├── survey.md               # 기존 코드 있을 때만 (B1, B2, ... 보존)
├── regression.md           # 기존 코드 있을 때만
├── handoff.md              # 다음 세션용 컨텍스트
└── implementation-notes.md
```

⛔ 우리 게이트가 전 과정에서 작동: `specs/<branch>/spec.md` + `plan.md` 없이 implement
불가 (R1/R2); 검증 통과 없이 커밋 불가 (R3), 기존 코드를 건드리면 회귀도 (R4). 검증 기준은
spec.md(수용/성공기준)와 tasks.md(테스트 태스크)에 있으며 별도 파일이 아닙니다.

### Phase 6: CLAUDE.md 작성

```markdown
# CLAUDE.md - AI 코딩 가이드

## 한 줄 요약
SDD(Spec-Driven Development)가 지휘하는 AI 코딩. SDD가 스킬을 호출하고,
강제 게이트가 흐름을 선택이 아닌 필수로 만든다.

## 작업 시작 시 첫 행동
| 작업 유형 | 첫 행동 |
|---|---|
| 새 기능 | sdd-conductor → 새 F[ID] |
| 기존 코드 변경 | 먼저 0단계 조사 실행 |
| 작은 결정 | DECISION-LOG.md 기록 |

## 안티 패턴
- ❌ spec/plan 전에 코딩 (게이트가 차단)
- ❌ 테스트 미통과 커밋 (게이트가 차단)
- ❌ 회귀 없이 기존 동작 건드리기 (게이트가 차단)
- ❌ 첫날부터 거대 추상화 (Karpathy: Simplicity First)
```

### Phase 7: 검증 + 최종 보고

INTEGRATION-CHECKLIST.md의 Day 0 점검을 실행하고, 생성한 것·설정한 강제 레벨·게이트
작동 여부를 보고합니다.

---

## 🧱 기존 코드 스킬 (조사 + 마이그레이션)

이 스킬들은 **기존 코드가 있을 때만** 사용됩니다 — 모드가 아니라, SDD가 0단계와 동작
교체 시 Implement에서 호출하는 스킬입니다. 신규 프로젝트에서는 나타나지 않습니다.

### 코드 조사 스킬 (Step 0)

`.claude/skills/code-archaeologist/SKILL.md`:

```markdown
---
name: code-archaeologist
description: |
  기존 코드를 분석해 동작/의도/의존성을 파악.
  기존 코드가 있을 때 Step 0에서 발동.
  키워드: "survey", "기존 코드 분석", "역공학"
---

# 코드 조사

기존 코드를 조사합니다. 묻혀 있는 의도를 발굴하세요.

## 핵심 책임
1. 동작 매핑 — 코드가 하는 일 (입력 → 처리 → 출력, 의존성)
2. 의도 추론 — 왜 이렇게 작성됐는지, 무엇을 해결했는지
3. 함정 식별 — 보이지 않는 부작용, 암묵적 가정, 깨질 위험

## 산출물
`sdd/features/F[ID]/00-survey.md` 작성 (아래 템플릿 참조).
```

### 마이그레이션 스킬 (Implement, 동작 교체 시)

`.claude/skills/migration-strategist/SKILL.md`:

```markdown
---
name: migration-strategist
description: |
  기존 동작 교체 시 점진적·안전한 전환을 계획.
  Implement에서 기존 코드를 변경할 때 발동.
  키워드: "migration", "점진 전환", "strangler fig"
---

# 마이그레이션 전략

점진적 전환을 계획합니다.

## 전략 패턴
1. Strangler Fig — 옛 코드를 새 코드로 점진 교체, 외부 인터페이스 유지
2. Feature Flag — 플래그로 새 코드 on/off, 즉시 롤백, 점진 출시
3. Branch by Abstraction — 추상화 계층 도입, 구현 교체

## 산출물
선택한 마이그레이션 전략을 `06-implementation-notes.md`에 명시.
```

### `sdd/templates/00-survey.md`

```markdown
# Survey - F[ID]

> SDD Step 0 (기존 코드 전용): 바꾸기 전에 이해.

## 메타데이터
- **ID**: F[ID]
- **방법**: code-archaeologist 스킬 + grill-me
- **일자**: YYYY-MM-DD

## 1. 분석 대상
- 위치: archive/legacy/[경로]
- 범위: [어디까지]

## 2. 전체 구조
| 모듈 | 책임 | 핵심 함수 |
|---|---|---|
| | | |

## 3. 핵심 동작
| 기능 | 입력 | 출력 | 핵심 로직 |
|---|---|---|---|
| | | | |

## 4. 의존성 맵
- 외부: [라이브러리, API]
- 내부: [모듈 간 호출]

## 5. 보존해야 할 동작 (회귀 대상)
05b-regression.md의 입력:
- [ ] **B1**: [보존할 동작]
- [ ] **B2**: [보존할 동작]

## 6. 버릴 것
- [버릴 것 1]: [이유]

## 7. 함정과 리스크
- [함정 1]: [상세]

## 8. 의도 추론
- [추론 1]

## 9. 결정 로그
| 시각 | 결정 | 근거 |
|---|---|---|

## 10. 다음 단계
- [ ] 01-spec.md 작성
```

### `sdd/templates/05b-regression.md`

```markdown
# Regression Tests - F[ID]

> SDD Step 5b (기존 코드 전용): 변경 후에도 기존 동작이 살아있는지 검증.
> 00-survey.md가 있으면 R4가 강제.

## 메타데이터
- **ID**: F[ID]
- **00-survey.md 참조**: ✅

## 1. 회귀 대상
00-survey.md의 "보존할 동작 (B1, B2, ...)"을 가져와서:

### B1: [동작 이름]
- **기존 동작**: [archive/legacy/의 동작]
- **검증**: [같은 입력 → 같은 출력]
- **자동화**: 자동/수동
- **통과 기준**: 100% 일치 또는 허용 범위

## 2. 마이그레이션 시나리오
1. [Step 1]: [무엇을 어디까지 전환]
2. [Step 2]: ...

| 단계 | 회귀 통과 기준 |
|---|---|
| 1 | B1, B2 |

## 3. 롤백 시나리오
- 조건: 회귀 실패 / [기타]
- 방법:
\`\`\`bash
# archive/legacy/ 에서 복원
[명령어]
\`\`\`

## 4. 새 코드 추가 검증
새 기능에는 05-verify.md의 표준 5대 카테고리 적용.

## 5. 결정 로그
| 시각 | 결정 | 근거 |
|---|---|---|

## 6. 다음 단계
- [ ] 06-implementation-notes.md (구현 + migration-strategist)
```
## 📋 부록 A: 표준 7개 템플릿

항상 사용 (00, 05b는 기존 코드가 있을 때만 추가)

### `sdd/templates/01-spec.md`

```markdown
# Spec - F[ID] [기능명]

> SDD Phase 1: Specify

## 메타데이터
- **ID**: F[ID]
- **이름**: [기능명]
- **작성일**: YYYY-MM-DD
- **상태**: Draft | InProgress | Done

## 1. What
[무엇을 만들/바꾸는지]

### 사용자 시나리오
[누가, 어떤 상황에서]

### 범위
**포함**: [범위 내]
**제외**: [범위 밖]

## 2. Why
### 문제
[현재 문제]

### 가치
[얻는 가치]

## 3. Constitution 준수
- [ ] [관련 조항]

## 4. 관련
- 이전: [F00X]
- 의존: [F00X]

## 5. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 6. 다음 단계
- [ ] 02-clarify.md
```

### `sdd/templates/02-clarify.md`

```markdown
# Clarify - F[ID]

> SDD Phase 2: Clarify (grill-me)

## 1. 발동
\`\`\`
"grill me - F[ID] 명확화"
\`\`\`

## 2. Q&A 기록

### Round 1
- **Q**: 
- **AI 추천**: 
- **A**: 

## 3. 결정 요약
- [결정 1]
- [결정 2]

## 4. 미결정
- [ ] [미결정 1] → [처리 방안]

## 5. Spec 갱신 사항
- [ ] [갱신]

## 6. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 7. 다음 단계
- [ ] 03-plan.md
```

### `sdd/templates/03-plan.md`

```markdown
# Plan - F[ID]

> SDD Phase 3: Plan

## 1. 기술 선택
| 기술 | 이유 | 대안 |
|---|---|---|

## 2. 아키텍처
[다이어그램]

## 3. 영향 받는 영역
| 파일 | 변경 유형 |
|---|---|

## 4. Karpathy 사전 점검
- Simplicity: 예상 X줄
- Surgical: [범위]

## 5. 위험 요소
- [리스크]: [대응]

## 6. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 7. 다음 단계
- [ ] 04-tasks.md
```

### `sdd/templates/04-tasks.md`

```markdown
# Tasks - F[ID]

> SDD Phase 4: Tasks

## 1. Task List

### T1: [작업명]
- **예상**: 30분
- **파일**: [목록]
- **검증**: [기준]
- **의존성**: [있다면]

### T2: ...

## 2. 의존성 다이어그램
\`\`\`
T1 → T2
\`\`\`

## 3. 병렬 그룹
- A: T1, T2
- B (A 후): T3

## 4. 에이전트 팀 (선택 — 🎸 Harness)
> 단일 에이전트로 벅찬 작업일 때만.
> [Harness](https://github.com/revfactory/harness)는 도메인별 에이전트 팀을
> 설계하고 그들의 스킬을 생성합니다. 트리거: "Build a harness for this project".
> 패턴: [ Pipeline | Fan-out/Fan-in | Expert Pool | Producer-Reviewer | Supervisor | Hierarchical Delegation ]
- 필요? [ 예 / 아니오 ]
- 예이면 → 팀 구성: [예: analyst + builder + qa]

## 5. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 6. 다음 단계
- [ ] 05-verify.md
```

### `sdd/templates/05-verify.md`

```markdown
# Verification - F[ID]

> SDD Phase 5: Verification

## 1. 발동
\`\`\`
"grill me - F[ID] 검증 설계"
\`\`\`

## 2. 검증 시나리오

### 2.1 Happy Path
- [ ] **H1**: [정상] → [기대]

### 2.2 Sad Path
- [ ] **H2**: [실패] → [기대 거부]

### 2.3 Edge Cases
- [ ] **H3**: [경계] → [동작]

### 2.4 Adversarial
- [ ] **H4**: [공격] → [방어]

### 2.5 Performance
- [ ] **H5**: [부하] → [성능]

## 3. 검증 방법
| H | 방법 | 자동/수동 |
|---|---|---|

## 4. 통과 기준
- 필수: H1, H2, H3
- 권장: H4
- 선택: H5

## 5. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 6. 다음 단계
- [ ] 구현 시작
```

### `sdd/templates/06-implementation-notes.md`

```markdown
# Implementation Notes - F[ID]

> SDD Phase 6: Implement (Karpathy 4원칙)

## 1. Karpathy 자기 점검

### Think Before Coding
- [ ] 가정 명시?
- [ ] 02-clarify.md 미결정 없음?
- [ ] 05-verify.md 매핑 가능?

### Simplicity First
- 03-plan.md 예상: X줄
- 실제: Y줄
- 차이: [분석]

### Surgical Changes
- 변경 계획: [목록]
- 변경 실제: [목록]

### Goal-Driven
- 05-verify.md 매핑: H[X] → 구현

## 2. Task 진행

### T1
- **상태**: Done
- **소요**: X분 / 실제 Y분
- **검증**: H[X] ✅

## 3. 검증
| H | 통과 | 비고 |
|---|---|---|
| H1 | ✅ | |

## 4. 발견된 추가 작업
- [추가]: F[XXX]로 분리

## 5. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 6. 다음 단계
- [ ] 모든 필수 검증 통과
- [ ] 07-handoff.md
```

### `sdd/templates/07-handoff.md`

```markdown
# Handoff - F[ID]

> SDD Phase 7: Handoff (grill-me)

## 1. 발동
\`\`\`
"grill me - F[ID] 핸드오프"
\`\`\`

## 2. 한 줄 요약
[1문장]

## 3. 완료 상태
### 완료
- ✅ [항목]

### 부분 완료
- 🟡 [항목]: [어디까지]

### 미완료
- ❌ [항목]: [이유]

## 4. 주요 결정
- [결정]: → 02-clarify.md

## 5. 알려진 이슈
- 🐛 [이슈]: [상태]

## 6. 다음 작업자 액션
### 즉시
- [ ] [할 일]

### 새 SDD로
- [ ] F[XXX]: [내용]

## 7. 참고
- 01-spec.md: 무엇/왜
- 02-clarify.md: 결정
- 03-plan.md: 기술
- 코드: [PR/커밋]

## 8. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 9. 사이클 종료
- [ ] 7단계 검토 완료
- [ ] PR/머지 완료
- [ ] DECISION-LOG.md 갱신
```

---

## 📋 부록 B: DECISION-LOG.md 템플릿

모든 프로젝트에서 동일:

```markdown
# Decision Log

> 모든 의미 있는 결정의 시간순 기록

## 형식
\`\`\`
## YYYY-MM-DD - [컨텍스트]
- **결정**: 
- **근거**: 
- **대안**: 
- **영향**: 
\`\`\`

---

## YYYY-MM-DD - 통합 패키지 적용

### 결정 1: 강제 레벨
- **결정**: 강제 레벨 = [standard/strict], 0단계 조사 = [켬/끔]
- **근거**: 인터뷰 결과 (INTERVIEW-RESULT.md)
- **대안**: 다른 엄격도
- **영향**: 전체 통합 방식

### 결정 2: ...
[Phase 진행 중 발생한 결정들]

---

## 향후 추가 기록

각 SDD 사이클 종료 시:
\`\`\`
## YYYY-MM-DD - F[ID] [기능명] 사이클 종료
- **시작**: 
- **종료**: 
- **유형**: Full/Mini SDD
- **주요 결정**: 
- **알려진 이슈**: 
- **다음 SDD**: 
- **상세**: sdd/features/F[ID]/
\`\`\`
```

---

## 📋 부록 C: INTEGRATION-REPORT.md 템플릿

```markdown
# 통합 완료 리포트

## 설정
강제 레벨: [standard/strict] · 0단계 조사: [켬/끔] (평가 기준)

## 일자
YYYY-MM-DD HH:MM

## 인터뷰 결과
참조: INTERVIEW-RESULT.md

## 생성된 자산

### 공통
- CLAUDE.md
- DECISION-LOG.md
- sdd/ 디렉터리 전체
- .claude/skills/ 5개

### 컨텍스트 추가
[00-survey.md, 05b-regression.md — 기존 코드 있을 때만]

## 처리된 기존 자산
| 구 위치 | 처리 | 새 위치 |
|---|---|---|

## 검증
Day 0 검증 진행: INTEGRATION-CHECKLIST.ko.md 참조

## 다음 액션
1. CLAUDE.md 정독
2. ORCHESTRA-GUIDE.ko.md 이해
3. sdd/features/F000-XXX/ 살펴보기
4. 첫 실전 SDD 사이클 시도

## 롤백 방법
\`\`\`bash
# Git
git reset --hard [통합 전 커밋]

# 또는 archive 활용 (있다면)
cp -r archive/legacy/* [원래 위치]/
rm -rf sdd/ .claude/skills/ CLAUDE.md
\`\`\`
```

---

## 🎯 한 줄 요약

> **이 파일은 모든 프로젝트에 하나의 SDD 흐름을 정의합니다. 컨텍스트(기존 코드, 운영 시그널)가 단계를 더하고 강제 엄격도를 올릴 뿐, 무엇을 하는지는 항상 같습니다.**

🛠️
