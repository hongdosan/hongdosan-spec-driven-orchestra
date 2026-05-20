# 🛠️ AI 실행 지시서 - 모드별 자율 진행

> **이 파일은 AI-INTERVIEW.md 완료 후 진행됩니다.**
> 결정된 모드에 해당하는 섹션을 참조하세요.

---

## 📌 진입점

인터뷰에서 결정된 모드:

- [MODE_GREENFIELD](#mode_greenfield-신규-프로젝트) → 신규 프로젝트
- [MODE_EARLY](#mode_early-초기-진행-프로젝트) → 초기 진행
- [MODE_REBUILD](#mode_rebuild-리팩토링-tf) → 리팩토링 TF
- [COMMON_ASSETS](#-공통-자산-모든-모드) → 모든 모드 공통 자산

---

## 🌐 공통 원칙 (모든 모드)

### 자율 진행
- 사용자 컨펌 없이 진행 (인터뷰에서 이미 승인받음)
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

## 📂 공통 자산 (모든 모드)

### 공통 디렉터리 구조

모든 모드에서 공통으로 생성:

```
프로젝트 루트/
├── CLAUDE.md                    # AI 진입점
├── DECISION-LOG.md              # 결정 기록
├── INTEGRATION-REPORT.md        # 통합 리포트
├── INTERVIEW-RESULT.md          # 인터뷰 결과 (이미 생성됨)
│
├── .claude/skills/              # 5개 skill
│   ├── grill-me/
│   ├── sdd-conductor/
│   ├── karpathy-enforcer/
│   ├── harness-builder/
│   └── handoff-writer/
│
└── sdd/                         # SDD 중심
    ├── CONSTITUTION.md
    ├── ORCHESTRA.md
    ├── README.md
    ├── templates/
    └── features/
```

### 공통 5개 Skill 생성

모든 모드에서 동일하게 생성:

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

### Phase 5: Harness 설계
\`\`\`
"grill me - F[ID] 하네스 설계"
\`\`\`

### Phase 7: Handoff 작성
\`\`\`
"grill me - F[ID] 핸드오프"
\`\`\`

### 모드별 추가 활용

#### MODE_REBUILD 전용
\`\`\`
"grill me - F[ID] archaeology" (Phase 0)
"grill me - F[ID] regression" (Phase 5b)
"grill me - F[ID] migration" (Phase 6)
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
2. 각 단계 진행 (Phase 2→grill-me, Phase 5→harness-builder, Phase 6→karpathy-enforcer, Phase 7→handoff-writer)
3. 순서 강제 (단계 건너뛰기 차단)
4. 결정 추적 (Decision Log + DECISION-LOG.md)

## 작업 분류
- **Full SDD**: 새 기능, 큰 리팩토링 → 7단계 모두
- **Mini SDD**: 작은 기능, 버그 → 01, 06, 07만
- **No SDD**: 1줄 수정, 오타 → Karpathy만
```

#### `.claude/skills/karpathy-enforcer/SKILL.md`

```markdown
---
name: karpathy-enforcer
description: |
  Karpathy 4원칙 강제. SDD Phase 6 자동 활성화.
  키워드: "구현", "코딩", "implement"
---

# Karpathy Enforcer

## 4원칙

### 1. Think Before Coding
- 가정 명시
- 모호하면 grill-me
- 트레이드오프 제시

### 2. Simplicity First
- 200줄 → 50줄 시도
- 추측성 기능 거부
- 단일 사용처 추상화 거부

### 3. Surgical Changes
- 변경 범위 = 요청 범위
- 인접 코드 보호
- 기존 스타일 유지

### 4. Goal-Driven Execution
- 검증 가능한 목표
- "작동하게" 같은 모호함 거부
- 테스트 우선

## 위반 감지 패턴
- "어차피 여기 있으니 [관련 없는 코드] 정리"
- "유연성을 위해 추상화"
- "혹시 모르니 에러 처리 추가"
- "이왕 하는 김에 [추가 기능]"
```

#### `.claude/skills/harness-builder/SKILL.md`

```markdown
---
name: harness-builder
description: |
  검증 기준 설계. SDD Phase 5 자동 활성화.
  키워드: "하네스", "검증", "테스트 설계"
---

# Harness Builder

## 5대 카테고리
1. **Happy Path** (정상)
2. **Sad Path** (실패)
3. **Edge Cases** (경계)
4. **Adversarial** (적대적)
5. **Performance** (성능)

## 작업 방식
1. grill-me 발동 (하네스 변형)
2. 카테고리당 최소 2개 시나리오
3. 우선순위: 필수/권장/선택
4. 05-harness.md 작성
5. Phase 6에서 매핑 검증
```

#### `.claude/skills/handoff-writer/SKILL.md`

```markdown
---
name: handoff-writer
description: |
  핸드오프 문서 작성. SDD Phase 7 자동 활성화.
  키워드: "핸드오프", "handoff", "인계"
---

# Handoff Writer

## 책임
1. 누락 검출 (grill-me 자동 발동)
2. 01~06 단계 핵심 추출
3. 다음 작업자 액션 명시

## 안티 패턴
- ❌ "잘 됩니다"
- ❌ "별 문제 없음"
- ❌ 다음 액션 없이 종료
```

---

## 🌱 MODE_GREENFIELD: 신규 프로젝트

### 컨텍스트
```
- 프로젝트: 코드 거의 없음 (< 10 파일)
- 의도: 처음부터 잘 잡고 시작
- archive: 불필요
- 첫 SDD: 프로젝트 부트스트랩
```

### Phase 진행

#### Phase 1: 공통 자산 생성

```bash
# 디렉터리 골격
mkdir -p .claude/skills/{grill-me,sdd-conductor,karpathy-enforcer,harness-builder,handoff-writer}
mkdir -p sdd/{templates,features}

# 5개 skill 생성 (위 공통 섹션 참조)
```

#### Phase 2: 신규 프로젝트용 CONSTITUTION.md 작성

```markdown
# 프로젝트 헌법 (Constitution)

> 이 프로젝트의 모든 결정과 코드는 이 헌법을 따른다.
> SDD Phase 1: Constitution 산출물.

## 1. 프로젝트 정체성

- **이름**: [Phase 0에서 파악한 이름]
- **유형**: 🌱 신규 프로젝트
- **시작일**: YYYY-MM-DD
- **현재 단계**: 부트스트랩
- **목적**: [인터뷰에서 파악]

## 2. 핵심 원칙

### 2.1 코딩 원칙 (Karpathy 4원칙)
[Karpathy 4원칙 본문 전체]

### 2.2 워크플로우 원칙 (SDD)
모든 의미 있는 작업은 7단계 따름:
1. Specify (What & Why)
2. Clarify (grill-me로 명확화)
3. Plan (How - 기술)
4. Tasks (분할)
5. Harness (검증 설계)
6. Implement (Karpathy 4원칙)
7. Handoff (인계)

### 2.3 신규 프로젝트 특화 원칙
- **부트스트랩 신중**: 첫 100시간이 프로젝트 운명 결정
- **과도한 추상화 금지**: YAGNI (You Aren't Gonna Need It)
- **빠른 실패**: 작동하는 최소 버전부터
- **결정 기록**: 모든 초기 결정을 DECISION-LOG에

## 3. 작업 분류
[Full/Mini/No SDD 기준]

## 4. AI 도우미 활용
[Claude Code, CLAUDE.md, Skills 안내]
```

#### Phase 3: 7개 표준 템플릿 생성

[표준 7개 템플릿 생성 - 부록 A 참조]

#### Phase 4: 첫 SDD 사이클 (F000-bootstrap)

```
sdd/features/F000-bootstrap/
├── 01-spec.md         # 프로젝트 부트스트랩 명세
├── 02-clarify.md      # 초기 결정 사항
├── 03-plan.md         # 기술 스택, 구조
├── 04-tasks.md        # 초기 작업 분할
├── 05-harness.md      # 부트스트랩 검증 기준
├── 06-implementation-notes.md
└── 07-handoff.md
```

각 파일은 "프로젝트 부트스트랩"이라는 컨텍스트로 작성.

#### Phase 5: CLAUDE.md 작성

```markdown
# CLAUDE.md - AI 코딩 가이드

> 신규 프로젝트로 시작합니다. 처음부터 잘 잡아갑시다.

## 한 줄 요약
SDD(Spec-Driven Development)가 지휘하는 5중주 AI 코딩.

## 신규 프로젝트 특화 가이드

### 작업 시작 시 첫 행동
| 작업 유형 | 첫 행동 |
|---|---|
| 새 기능 | sdd-conductor → 새 F[ID] |
| 부트스트랩 작업 | sdd/features/F000-bootstrap/ 참조 |
| 작은 결정 | DECISION-LOG.md에 기록 |

[표준 CLAUDE.md 내용]

## 신규 프로젝트 안티 패턴
- ❌ 첫날부터 거대 추상화
- ❌ "혹시 모르니" 패턴
- ❌ SDD 없이 코드부터
- ❌ 결정 기록 안 함
```

#### Phase 6: 검증 + 최종 리포트

[Phase 6 표준 수행]

---

## 🌿 MODE_EARLY: 초기 진행 프로젝트

### 컨텍스트
```
- 프로젝트: 1-2주 작업, 10-100 파일
- 의도: 방향 재정비
- archive: 기존 자산 있다면 백업
- 첫 SDD: 통합 검증
```

### Phase 진행

#### Phase 1: 기존 자산 검토 + archive

```bash
# 인터뷰에서 발견한 기존 자산:
# - handoff 디렉터리 (있다면)
# - harness 디렉터리 (있다면)
# - 기존 CLAUDE.md (있다면)
# - 기존 .claude/ (있다면)

# archive 디렉터리 생성
mkdir -p archive/

# 발견된 자산만 백업
[발견된 자산 → archive/legacy-XXX/]

# archive/README.md 작성
[매핑 정보]
```

#### Phase 2: 공통 자산 생성

[공통 5개 skill + sdd/ 골격]

#### Phase 3: 초기 진행용 CONSTITUTION.md

```markdown
# 프로젝트 헌법 (Constitution)

## 1. 프로젝트 정체성

- **이름**: [Phase 0에서 파악]
- **유형**: 🌿 초기 진행 프로젝트
- **현재 단계**: 10-30% 진행
- **재정비 일자**: YYYY-MM-DD

## 2. 핵심 원칙

### 2.1 Karpathy 4원칙
[표준]

### 2.2 SDD 7단계
[표준]

### 2.3 초기 진행 특화 원칙
- **기존 코드 존중**: 동작하는 것은 함부로 바꾸지 않음
- **방향 재정비**: 새 워크플로우로 점진적 전환
- **기존 자산 활용**: archive/ 의 자산 참고
- **새 작업부터 적용**: 기존 코드 강제 마이그레이션 X

## 3. 작업 분류
[표준]

## 4. 기존 자산
- archive/: 통합 전 자산 보관
- 신규 작업은 sdd/features/ 에서
```

#### Phase 4: 표준 7개 템플릿

[부록 A 참조]

#### Phase 5: 첫 SDD 사이클 (F000-integration)

통합 자체를 첫 SDD로 처리:
```
sdd/features/F000-integration/
├── 01-spec.md         # 통합의 What & Why
├── 02-clarify.md      # 인터뷰 결과
├── 03-plan.md         # MODE_EARLY 채택 근거
├── 04-tasks.md        # Phase 0~7 작업
├── 05-harness.md      # 통합 검증 기준
├── 06-implementation-notes.md
└── 07-handoff.md
```

#### Phase 6: CLAUDE.md (표준)

[표준 CLAUDE.md 작성]

#### Phase 7: 검증 + 리포트

---

## 🔨 MODE_REBUILD: 리팩토링 TF

### 컨텍스트
```
- 프로젝트: 기존 코드 갈아엎기 결정
- 의도: 처음부터 다시
- archive: 기존 전체 백업
- 추가 단계: archaeology, regression
- 첫 SDD: 리팩토링 마스터 플랜
```

### Phase 진행

#### Phase 1: 전체 archive

```bash
mkdir -p archive/legacy/{code,docs,config}

# 기존 코드 전체 백업 (참조용)
[모든 코드 파일 archive/legacy/code/로 복사]

# 기존 문서 전체 백업
[모든 .md 파일 archive/legacy/docs/로 복사]

# 설정 파일 백업
[package.json, Dockerfile 등 archive/legacy/config/]

# archive/README.md 작성 (매핑 + 롤백 방법)
```

#### Phase 2: 공통 자산 + 리팩토링 추가 skill

```bash
# 공통 5개 skill 생성

# 리팩토링 전용 추가
mkdir -p .claude/skills/code-archaeologist
mkdir -p .claude/skills/migration-strategist
```

##### `.claude/skills/code-archaeologist/SKILL.md` (신규)

```markdown
---
name: code-archaeologist
description: |
  기존 코드를 분석하여 동작/의도/의존성을 파악한다.
  MODE_REBUILD에서 Phase 0에 활성화.
  키워드: "archaeology", "기존 코드 분석", "역공학"
---

# Code Archaeologist

당신은 기존 코드의 고고학자다. 코드 속에 묻혀있는 의도를 발굴한다.

## 핵심 책임

### 1. 동작 매핑
- 기존 코드가 무엇을 하는가
- 입력 → 처리 → 출력
- 외부 의존성

### 2. 의도 추론
- 왜 이렇게 작성됐는가
- 어떤 문제를 해결하려 했나
- 어떤 결정이 있었나

### 3. 함정 식별
- 보이지 않는 사이드 이펙트
- 암묵적 가정
- 깨질 수 있는 부분

## 산출물

`sdd/features/F000-rebuild-plan/00-archaeology.md` 작성:

\`\`\`markdown
# Code Archaeology - 기존 코드 분석

## 1. 전체 구조
[모듈별 책임]

## 2. 핵심 동작
[중요 기능 N개]

## 3. 의존성 지도
[외부 + 내부 의존성]

## 4. 보존해야 할 동작 (Regression 대상)
[Phase 5b에서 검증할 항목]

## 5. 버릴 것
[리팩토링 시 제거 OK]

## 6. 함정과 위험
[조심해야 할 부분]

## 7. 의도 추론
[왜 이렇게 되었나]
\`\`\`
```

##### `.claude/skills/migration-strategist/SKILL.md` (신규)

```markdown
---
name: migration-strategist
description: |
  기존 → 신규 점진 전환 전략 수립.
  MODE_REBUILD에서 Phase 6 진입 시 활성화.
  키워드: "migration", "마이그레이션", "점진 전환"
---

# Migration Strategist

당신은 점진적 전환의 전략가다.

## 전략 패턴

### 1. Strangler Fig (스트랭글러 무화과)
- 기존 코드를 점진적으로 신규로 대체
- 한 번에 다 바꾸지 않음
- 외부 인터페이스 유지

### 2. Feature Flag
- 신규 코드를 플래그로 켜고 끔
- 문제 시 즉시 롤백
- 점진 출시

### 3. Branch by Abstraction
- 추상화 계층 도입
- 구현체를 갈아끼움
- 무중단 전환

## 산출물

리팩토링 진행 시 06-implementation-notes.md에 마이그레이션 전략 명시.
```

#### Phase 3: 리팩토링용 CONSTITUTION.md

```markdown
# 프로젝트 헌법 (Constitution)

## 1. 프로젝트 정체성

- **이름**: [Phase 0]
- **유형**: 🔨 리팩토링 TF
- **TF 일자**: YYYY-MM-DD ~ ?
- **기존 코드**: archive/legacy/ 보관
- **목적**: [인터뷰에서 파악]

## 2. 핵심 원칙

### 2.1 Karpathy 4원칙
[표준]

### 2.2 SDD 7단계 (확장)
신규 단계:
- **Phase 0 (Archaeology)**: 기존 코드 분석
- **Phase 5b (Regression)**: 기존 동작 보장

표준 7단계 + 위 2개 = 총 9단계

### 2.3 리팩토링 특화 원칙
- **기존 동작 보존**: archive/legacy/ 의 핵심 동작은 유지
- **점진 전환**: 한 번에 다 바꾸지 않음 (Strangler Fig)
- **검증 우선**: 신규 코드는 regression 통과 필수
- **롤백 가능**: archive/legacy/ 로 언제든 복귀

## 3. 작업 분류

### 3.1 Full SDD (리팩토링용)
9단계 모두 (Archaeology + Regression 포함)

### 3.2 Mini SDD
작은 부분 리팩토링: 00, 01, 06, 07

## 4. 기존 자산
- archive/legacy/: 기존 전체 보관
- 참조 가능, 수정 금지
```

#### Phase 4: 9개 템플릿 (표준 7개 + 추가 2개)

표준 7개 + 추가 2개:

##### `sdd/templates/00-archaeology.md` (신규)

```markdown
# Archaeology - F[ID]

> SDD Phase 0 (리팩토링 전용): Code Archaeology
> 기존 코드의 동작/의도/의존성 파악

## 메타데이터
- **ID**: F[ID]
- **분석 방법**: code-archaeologist skill + grill-me
- **분석일**: YYYY-MM-DD

## 1. 분석 대상
- 위치: archive/legacy/[경로]
- 범위: [어디까지]

## 2. 전체 구조

### 2.1 모듈 맵
| 모듈 | 책임 | 핵심 함수 |
|---|---|---|
| | | |

### 2.2 디렉터리 구조
\`\`\`
[기존 구조]
\`\`\`

## 3. 핵심 동작

### 3.1 기능 목록
| 기능 | 입력 | 출력 | 핵심 로직 |
|---|---|---|---|
| | | | |

### 3.2 외부 인터페이스
| 인터페이스 | 보존 여부 | 이유 |
|---|---|---|
| | 필수/선택/버림 | |

## 4. 의존성 지도

### 4.1 외부 의존성
[라이브러리, API 등]

### 4.2 내부 의존성
[모듈 간 호출 관계]

## 5. 보존해야 할 동작 (Regression 대상)
이것은 05b-regression.md의 입력이 됨:
- [ ] **B1**: [필수 보존 동작]
- [ ] **B2**: [필수 보존 동작]

## 6. 버릴 것
리팩토링 시 제거해도 OK:
- [버릴 것 1]: [이유]

## 7. 함정과 위험
숨겨진 복잡성:
- [함정 1]: [상세]
- [함정 2]: [상세]

## 8. 의도 추론
"왜 이렇게 만들어졌나" 분석:
- [추론 1]
- [추론 2]

## 9. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|
| | | |

## 10. 다음 단계
- [ ] 01-spec.md 작성 (새 명세)
```

##### `sdd/templates/05b-regression.md` (신규)

```markdown
# Regression Harness - F[ID]

> SDD Phase 5b (리팩토링 전용): Regression Harness
> 기존 동작이 새 구현에서도 동일하게 작동하는지 검증

## 메타데이터
- **ID**: F[ID]
- **00-archaeology.md 참조**: ✅

## 1. Regression 대상

00-archaeology.md 의 "보존해야 할 동작 (B1, B2, ...)" 을 가져와서:

### B1: [동작명]
- **기존 동작**: [archive/legacy/의 동작]
- **검증 방법**: [같은 입력에 같은 출력 확인]
- **자동화**: 자동/수동
- **통과 기준**: 100% 일치 또는 허용 범위

### B2: ...

## 2. 마이그레이션 시나리오

### 2.1 점진 전환 단계
1. [단계 1]: [무엇을 어디까지 전환]
2. [단계 2]: ...

### 2.2 각 단계별 검증
| 단계 | Regression 통과 기준 |
|---|---|
| 1 | B1, B2 |
| 2 | B1~B4 |

## 3. 롤백 시나리오

### 3.1 롤백 조건
- [ ] Regression 통과 안 함
- [ ] [다른 조건]

### 3.2 롤백 방법
\`\`\`bash
# archive/legacy/ 에서 복원
[구체적 명령]
\`\`\`

## 4. 신규 코드 추가 검증
리팩토링 후 추가된 신규 기능:
- 05-harness.md 의 표준 5대 시나리오 적용

## 5. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|
| | | |

## 6. 다음 단계
- [ ] 06-implementation-notes.md (구현 + migration-strategist)
```

#### Phase 5: 첫 SDD 사이클 (F000-rebuild-plan)

리팩토링 자체를 첫 SDD로 처리:
```
sdd/features/F000-rebuild-plan/
├── 00-archaeology.md  # 기존 코드 전체 분석
├── 01-spec.md         # 리팩토링 마스터 플랜
├── 02-clarify.md      # 인터뷰 + 추가 grill-me
├── 03-plan.md         # 전환 전략 (Strangler Fig 등)
├── 04-tasks.md        # 마이그레이션 작업 분할
├── 05-harness.md      # 신규 기능 검증
├── 05b-regression.md  # 기존 동작 보장
├── 06-implementation-notes.md
└── 07-handoff.md
```

#### Phase 6: CLAUDE.md (리팩토링 특화)

```markdown
# CLAUDE.md - AI 코딩 가이드

> 🔨 리팩토링 TF 모드

## 즉시 알아야 할 것

### 작업 흐름
1. **새 기능/큰 변경**: Full SDD (9단계)
2. **작은 리팩토링**: Mini SDD (00, 01, 06, 07)
3. **archive/legacy/ 참조**: 기존 동작 확인

### 절대 금지
- ❌ archive/legacy/ 수정 또는 삭제
- ❌ regression 통과 안 한 채 머지
- ❌ 점진 전환 없이 한 번에 다 바꾸기

[표준 CLAUDE.md 내용]

## 리팩토링 특화 명령

\`\`\`
"기존 코드 분석해줘" → code-archaeologist 활성화
"마이그레이션 전략" → migration-strategist 활성화
"regression 확인" → 05b-regression.md 검증
\`\`\`
```

#### Phase 7: 검증 + 리포트

---

## 📋 부록 A: 표준 7개 템플릿

모든 모드에서 공통으로 사용 (MODE_REBUILD만 00, 05b 추가)

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

## 4. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 5. 다음 단계
- [ ] 05-harness.md
```

### `sdd/templates/05-harness.md`

```markdown
# Harness - F[ID]

> SDD Phase 5: Harness Engineering

## 1. 발동
\`\`\`
"grill me - F[ID] 하네스 설계"
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
- [ ] 05-harness.md 매핑 가능?

### Simplicity First
- 03-plan.md 예상: X줄
- 실제: Y줄
- 차이: [분석]

### Surgical Changes
- 변경 계획: [목록]
- 변경 실제: [목록]

### Goal-Driven
- 05-harness.md 매핑: H[X] → 구현

## 2. Task 진행

### T1
- **상태**: Done
- **소요**: X분 / 실제 Y분
- **검증**: H[X] ✅

## 3. Harness 검증
| H | 통과 | 비고 |
|---|---|---|
| H1 | ✅ | |

## 4. 발견된 추가 작업
- [추가]: F[XXX]로 분리

## 5. Decision Log
| 시각 | 결정 | 근거 |
|---|---|---|

## 6. 다음 단계
- [ ] 모든 필수 Harness 통과
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

모든 모드에서 동일:

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

## YYYY-MM-DD - 통합 패키지 적용 (MODE_XXX)

### 결정 1: 모드 선택
- **결정**: MODE_XXX 채택
- **근거**: 인터뷰 결과 (INTERVIEW-RESULT.md)
- **대안**: 다른 모드들
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

## 모드
MODE_XXX (인터뷰 결과로 결정)

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

### 모드별 추가
[MODE_XXX 에 따라 다름]

## 처리된 기존 자산
| 구 위치 | 처리 | 새 위치 |
|---|---|---|

## 검증
Day 0 검증 진행: INTEGRATION-CHECKLIST.md 참조

## 다음 액션
1. CLAUDE.md 정독
2. ORCHESTRA-GUIDE.md 이해
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

> **이 파일은 모드별로 다른 진행 방식을 정의합니다. GREENFIELD는 부트스트랩 중심, EARLY는 표준 통합, REBUILD는 archaeology + regression 추가. 모든 모드는 5중주 SDD 오케스트라를 공유하지만, 첫 SDD 사이클과 특화 도구가 다릅니다.**

🛠️
