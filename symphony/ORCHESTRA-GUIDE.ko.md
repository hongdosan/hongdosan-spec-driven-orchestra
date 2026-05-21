# 🎼 Orchestra Guide — SDD와 그 스킬들

> **SDD가 프레임워크이자 지휘자입니다.** 나머지 도구들은 동등하지 않으며, 지휘자가 필요할 때 **호출하는 스킬**입니다.
> 어디서든 보편 적용: 신규·초기·레거시·유지보수·운영 프로젝트 (모드 없음 — SDD가 컨텍스트에 적응).
>
> **규칙 R (원본에 위임).** 이 패키지는 spec-kit/harness를 재설명하지 않고, 그들의 실제 명령(`/speckit.*`)을 호출하며 자신의 *delta* — 차단 게이트·오케스트레이션 순서·레거시 survey/regression·한국어 온보딩 — 만 더합니다. 한국어 보조 텍스트는 사람 이해용이며 비강제입니다. 실행의 기준은 설치된 spec-kit 명령 정의와 영문 원본입니다.

---

## 1. 위계 — 지휘자 하나, 여러 악기

여기 프레임워크는 정확히 하나, **SDD(Spec-Driven Development)**입니다. 나머지는 모두 SDD가 불러내는 스킬입니다. 5개 동등한 도구의 민주주의가 아니라, 지휘자가 악기를 지휘하는 구조입니다.

```
            🎼 SDD — 프레임워크 (지휘자)
        Spec → Clarify → Plan → Tasks → Verify → Implement → Handoff
            + 강제 레이어 (hooks / CI 게이트)
                          │
        ┌─────────────┬───┴───┬─────────────┐
        │             │       │             │
   🎻 Violin      🎹 Piano  🎺 Brass     🎸 Guitar
   Karpathy 4     grill-me  Handoff      Harness
   (품질)          (명확화)    (인계)        (에이전트 팀)
        └────────── 지휘자가 호출하는 스킬 ──────────┘
```

악기는 결코 주도하지 않습니다. SDD가 *언제* 스킬이 필요한지 결정해 호출하며, 스킬이 스스로 흐름을 끌고 가지 않습니다.

### 지휘자

| | 프레임워크 | 역할 | 출처 |
|---|---|---|---|
| 🎼 | **SDD** | 유일한 프레임워크. 7단계 흐름과 강제 게이트를 소유. | [github/spec-kit](https://github.com/github/spec-kit) |

### 스킬 (SDD가 호출)

| 악기 | 스킬 | 호출 시점 | 출처 |
|---|---|---|---|
| 🎻 1st Violin | **karpathy-guidelines** | Implement — 4원칙 강제 | [multica-ai](https://github.com/multica-ai/andrej-karpathy-skills) |
| 🎹 Piano | **grill-me** | 모든 단계 — 필요 시 모호함 제거 | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎺 Brass | **handoff** | Handoff — 작업 인계 | [mattpocock/skills](https://github.com/mattpocock/skills) |
| 🎸 Guitar | **harness** | Tasks — 큰 작업을 위한 에이전트 팀 설계 (선택·외부) | [revfactory/harness](https://github.com/revfactory/harness) |

> **단계적으로 도입하세요.** SDD는 항상 돌아가고, 스킬은 필요에 따라 얹힙니다. **Tier 1**: SDD + 🎻 Karpathy + 🎹 grill-me. **Tier 2**: + 🎺 Handoff (검증은 SDD 자체 흐름의 일부). **Tier 3**: + 🎸 Harness (대형/팀 작업; 선택·실험적). 프레임워크는 일정하고, 호출하는 스킬 수만 달라집니다.

---

## 2. 컨텍스트 적응 (모드 없음)

SDD는 모드로 **분기하지 않습니다.** 하나의 흐름을 돌리되, 무엇을 발견하든 거기에 적응합니다:

```
🎼 SDD가 시작 시 컨텍스트 평가 (코드 규모, git 이력, 운영 시그널)
   │
   ├─ 기존 코드 있음   → Specify 앞에 가벼운 조사(survey)
   │                     (바꾸기 전에 이해)
   ├─ 운영 시그널      → 강제 게이트가 엄격해짐
   │                     (테스트/회귀가 선택이 아닌 필수)
   └─ 신규(Greenfield) → 동일한 게이트, 단 보존할 게 없어 쉽게 통과
```

컨텍스트는 SDD가 *무엇을 하는지*를 바꾸지 않습니다 — 오직 **강제 게이트의 엄격도**만 바꿉니다. 흐름은 단일하고 보편적입니다.

---

## 3. 7단계 흐름 (단일·보편)

흐름은 하나입니다. SDD가 작업 규모에 맞춰 조절하고(full / mini / none), 기존 코드가 있으면 컨텍스트 기반 단계를 더합니다 — 이것은 **모드가 아니라**, 지휘자가 본 것에 반응하는 것뿐입니다.

```
사용자 요청
    ↓
[SDD가 흐름 규모 조절]
    ├─ Full  → 1~7 전부
    ├─ Mini  → 1, 6, 7만
    └─ None  → 즉시 코딩 (여전히 강제 게이트 적용)

[Full SDD 흐름]
0. Survey*   🎼 (기존 코드 있으면: 바꾸기 전에 이해)
   ↓
1. Specify   🎼 (What & Why)
   ↓
2. Clarify   🎹 (grill-me — 필요 시 호출)
   ↓
3. Plan      🎼 (How)
   ↓
4. Tasks     🎼 (분할)
   ↓  └─ 선택: 🎸 Harness — 단일 에이전트로 벅찬 작업이면
   ↓           에이전트 팀을 설계해 작업을 분담
5. Verify    🎼 (SDD 소유; 기준은 spec.md / tasks.md에)
   ↓  └─ 기존 코드 있으면: 회귀(regression) 검사도 추가
   ↓     (기존 동작 보존 — B1, B2, ...)
6. Implement 🎻 (karpathy-guidelines + ⛔ 게이트: spec/plan 없이 코드 불가)
   ↓
7. Handoff   🎺 (handoff)
   ↓
⛔ 커밋/PR 게이트: 검증을 통과해야 하며, 아니면 게이트가 막음
```

> **\*0단계(Survey)**는 이해해야 할 기존 코드가 있을 때만 나타납니다. 신규 프로젝트는 조사할 게 없으니 SDD가 건너뜁니다. 별도의 "리빌드 모드"는 없습니다 — 컨텍스트가 부르면 같은 흐름에 조사와 회귀 검사가 포함될 뿐입니다.

> **출처 — 어디까지가 spec-kit이고 어디부터가 우리가 더한 것인가.** 이 7단계 흐름은 spec-kit 명령을 그대로 옮긴 것이 아니라 *우리의* 오케스트레이션입니다. spec-kit 명령에 직접 대응하는 단계: **Specify**(`/speckit.specify`), **Clarify**(`/speckit.clarify`), **Plan**(`/speckit.plan`), **Tasks**(`/speckit.tasks`), **Implement**(`/speckit.implement`). **Survey(0)·Verify(5)·Handoff(7)** 단계는 *우리가 추가한 것*으로 spec-kit 명령이 아닙니다. 반대로 spec-kit의 `/speckit.constitution`(원본의 첫 단계)과 `/speckit.analyze`는 여기서 흐름 단계가 아닙니다 — constitution 개념은 번호 단계가 아니라 spec-kit의 `.specify/memory/constitution.md`로 차용했습니다. "SDD가 7단계 흐름을 소유한다"는 말은 SDD가 *이 순서*를 지휘한다는 뜻이지, spec-kit이 이 7단계를 정의한다는 뜻이 아닙니다.

## 4. 강제 레이어 — 왜 이것이 단순한 권고가 아닌가

AI에게 "스펙 먼저 써줘"라고 말하는 마크다운은 *부탁*입니다. 긴 세션에서 그 부탁은 희미해지고, 단계는 건너뛰어집니다. 여기서 SDD는 **결정론적 게이트**가 뒷받침합니다 — 모델이 규칙을 기억하든 말든, 위반을 막습니다:

| 게이트 | 막는 것 | 규칙 |
|---|---|---|
| `pre-implement` hook | `specs/<branch>/spec.md` + `plan.md` 없이 코드 작성 | R1, R2 |
| `pre-commit` hook | 검증 미통과 상태로 구현 커밋 | R3, R4 |
| `sdd-gate.yml` (CI) | spec 없음 / 테스트 실패 PR 머지 — **우회 불가** | R1, R3, R6 |
| `post-task` hook | (경고) handoff 없이 종료 | R5 |

규칙은 한 곳 — spec-kit의 `.specify/memory/constitution.md`(R1~R7 본문은 이 패키지의 `sdd/CONSTITUTION.md`에서 옴) — 에 모여 있고, 게이트들이 이를 읽습니다. 컨텍스트는 게이트가 **얼마나 엄격한지**만 바꾸며(운영 → `strict`, 우회 불가), *무엇을* 검사하는지는 바꾸지 않습니다. 실제 스크립트와 설치법은 `enforcement/` 폴더를 참고하세요.

> 이것이 핵심입니다: 준수가 AI의 선택에 의존하지 않습니다. 스펙이 없으면 implement 단계가 실패합니다. 테스트가 통과 안 하면 커밋이 실패합니다. 오케스트라가 박자에 맞는 이유는 연주자가 박자를 지키겠다고 약속해서가 아니라, 메트로놈이 문에 연결돼 있기 때문입니다.

---

## 5. delta가 spec-kit 흐름에 더하는 것

spec → clarify → plan → tasks → implement 코어는 **spec-kit**의 것입니다 — `/speckit.*`를
호출하고 [spec-kit 문서](https://github.com/github/spec-kit)를 보세요. 규칙 R에 따라 이
가이드는 그 단계들을 재설명하지 않고, 이 패키지가 *더하는* 지점만 적습니다.

### 🎹 Clarify — grill-me는 더 깊게
`/speckit.clarify`는 최대 ~5개 표적 질문을 던지고 spec에 기록합니다. spec이 여전히 불충분하게
느껴지면, 이 패키지의 **grill-me** 스킬이 더 파고듭니다(`"grill me - <branch> 명확화"`).

### 🎸 Tasks — Harness를 언제 부르나
`/speckit.tasks` 후, 기능이 단일 에이전트로 벅차면 **Harness**(외부 플러그인)로 에이전트
팀을 설계합니다: `"Build a harness for this project"`. `.claude/agents/`와 그들의 스킬을
생성합니다(Pipeline / Fan-out / Expert Pool / Producer-Reviewer / Supervisor / Hierarchical
Delegation). 지휘는 여전히 SDD가 소유 — 일반 작업에는 쓰지 않습니다.

### 🎼 Verify — 기준은 spec에, 게이트가 테스트를 강제
검증은 별도 파일이 아닙니다: 수용/엣지/성공기준은 spec-kit `spec.md`에, 테스트 태스크는
`tasks.md`에 있습니다. spec-kit의 테스트는 *선택*입니다 — 이 패키지의 delta는 커밋 전 테스트
통과를 **필수로** 만드는 게이트(R3)입니다.

### 🥁 Regression — 기존 코드를 건드릴 때만
레거시 작업을 위한 이 패키지의 추가분. `specs/<branch>/survey.md`가 있으면 R4가
`regression.md`의 존재·통과를 커밋 전에 요구합니다: 보존할 동작(B1, B2, ...)을 가져오고,
동작마다 검증을 쓰고, 점진 전환(Strangler Fig / Feature Flag / Branch by Abstraction)과
롤백을 계획합니다.

### 🎻 Implement — Karpathy 가드레일
`/speckit.implement`가 `tasks.md`대로 구현합니다. 그동안 **karpathy-guidelines** 스킬이
4원칙(Think Before Coding · Simplicity First · Surgical Changes · Goal-Driven Execution)을
적용합니다. 게이트(R1/R2)가 `spec.md` + `plan.md` 없이 구현하는 것을 막습니다.

### 🎺 Handoff — 다음 세션용 컨텍스트
이 패키지의 추가분: **handoff** 스킬이 `specs/<branch>/handoff.md`를 작성해 다음 세션에
컨텍스트를 남깁니다. 없으면 R5가 경고(차단 아님)합니다.

---

## 6. 듀엣과 협주

### SDD + grill-me

가장 흔한 협업:
```
Specify 중 모호 발견
   ↓
grill-me 자동 발동
   ↓
명확화 후 Spec 갱신
```

### Karpathy + Verification

품질 콤보:
```
검증 설계 중
   ↓
"검증 가능한가?" (Karpathy)
   ↓
검증 불가하면 재설계
```

### grill-me + Handoff

종료 콤보:
```
Handoff 작성
   ↓
grill-me 발동
   ↓
누락 검출 → 채움
```

### Survey + Verification (기존 코드가 있을 때)

기존 코드 콤보:
```
0단계 Survey가 기존 동작 발굴 (B1, B2, ...)
   ↓
검증 단계가 각각을 회귀 시나리오로
   ↓
점진적 안전 전환 (Strangler Fig / Feature Flag)
```

---

## 7. 실전 시나리오 (하나의 흐름, 컨텍스트에 적응)

매번 같은 SDD 흐름입니다. 다른 건 컨텍스트가 더하는 것뿐 — 기존 코드가 있으면 조사, 운영이면 더 엄격한 게이트. 모드는 없습니다.

### 신규(Greenfield): 첫 기능

```
사용자: "새 기능 [이름]"

AI: 브랜치 001-[이름] 생성   (기존 코드 없음 → 조사 없음)
AI: /speckit.specify → /speckit.clarify (더 깊으면 grill-me) → /speckit.plan
AI: /speckit.tasks → /speckit.analyze → /speckit.implement
AI: handoff.md   (이 패키지의 추가분)
    ⛔ 게이트: implement 전 spec+plan; 커밋 전 테스트
```

### 기존 / 진행 중 코드

```
사용자: "X 기능 개선"

AI: survey.md (현재 동작 먼저 이해 — 이 패키지의 추가분)
AI: /speckit.specify → ... → /speckit.tasks → /speckit.analyze
AI: regression.md (B1, B2, ... 보존) → /speckit.implement
    (동작 교체면 Strangler Fig / Feature Flag)
    ⛔ R4 게이트: 커밋 전 회귀 통과 필수
AI: handoff.md
```

### 운영(Production) 컨텍스트

```
사용자: "결제 반올림 버그 수정"  (배포된 서비스에서)

AI: 운영 시그널 감지 → ENFORCEMENT_LEVEL=strict (R6)
AI: survey.md → /speckit.specify → ... → regression.md → /speckit.implement
    ⛔ strict 게이트: 테스트 + 회귀 필수, 우회 경로 없음
AI: handoff.md
```

> 보세요: 단계는 동일합니다. 운영이 다른 "모드"를 발동한 게 아니라 — 강제 레벨을 올려 기존 게이트를 우회 불가로 만든 것뿐입니다.

---

## 8. 안티 오케스트라

> 참고: 의도적으로 낮은 단계(Tier)에 머무는 것은 안티패턴이 **아닙니다** — 오히려 권장됩니다. 아래 안티패턴은 *작은 단계를 선택*하는 것이 아니라, *이미 쓰기로 한 도구를 무시*하는 것에 관한 것입니다.

### 악기가 충돌할 때
도구들은 서로 당길 수 있습니다. 예측 가능하게 해소하세요:
- 🎹 grill-me의 집요한 질문 vs "빠르게" 우선순위 → 사소한 작업은 Tier 1로 내려가세요. grill-me는 중요한 결정을 위한 것입니다.
- 🎼 검증 엄격함 vs 속도 → 검증 깊이를 형식이 아니라 위험도에 맞추세요.
- 🎸 Harness(다중 에이전트) vs 단순함 → 기본은 단일 에이전트. 작업이 정말 요구할 때만 분할하세요.
- **원칙**: 애매하면 최대 프로세스보다 낮은 단계와 사용자의 명시적 의도를 우선하세요.

### 솔로 연주 (이미 도입한 단계 안에서)
- ❌ SDD를 쓰기로 해놓고 그 흐름을 무시
- ❌ grill-me 결과를 받고도 결정을 버림
- ❌ 템플릿만 골라 쓰면서 Constitution 위반

### 불협화음
- ❌ Spec 결정을 Implement에서 무시
- ❌ 검증 무시하고 PR
- ❌ Handoff 거짓 정보

### 박자 무시
- ❌ Clarify 없이 Plan
- ❌ Plan 없이 Implement
- ❌ 검증 없이 PR
- ❌ 0단계 조사 없이 기존 코드 건드리기

### 지휘자 무시
- ❌ specs/<branch>/ 밖에서 작업
- ❌ 템플릿 무시
- ❌ Constitution 어기기

---

## 9. 학습 곡선

### 첫 1주
- Full SDD 자주 쓰지 말 것
- Mini SDD 1-2회로 익히기
- CLAUDE.md, ORCHESTRA-GUIDE.md 정독

### 첫 1개월
- Full SDD 2-3회
- DECISION-LOG.md 갱신 습관화

### 그 이후
- 자연스러운 흐름
- 게이트가 보이지 않게 됨 — 한 번도 맞서 싸우지 않으니 의식하지 않게 됨

### 기존 코드와 작업할 때
- Strangler Fig 패턴 이해
- Feature Flag 활용
- Branch by Abstraction

---

## 10. 프로젝트가 진화하면 (모드 전환 없음)

모드가 없으므로 "전환"할 것도 없습니다. 같은 SDD 흐름이 프로젝트의 전 생애를 따라가며, 두 가지만 자동으로 변합니다:

```
프로젝트 성장 / 기존 코드 생김
   → Specify 앞에 0단계 조사가 나타나기 시작
   → 회귀 검사(R4)가 적용되기 시작

프로젝트 배포됨 (운영 시그널)
   → ENFORCEMENT_LEVEL이 strict로 상승 (R6)
   → 테스트/회귀가 우회 불가가 됨
```

톤 변경도, 모드 이전도, CONSTITUTION 재작성도 없습니다. 프레임워크는 일정하고, 컨텍스트가 엄격도를 조절합니다. 이것이 모드를 버린 이유의 핵심입니다 — "우리 모드를 넘어섰다"는 순간이 결코 없습니다.

---

## 11. 마지막 한 마디

> 목표는 **빠른 코드가 아니라, 시간이 지나도 흔들리지 않는 코드와 컨텍스트** — 그리고 그것을 약속이 아니라 가장 저항이 적은 길로 만드는 게이트입니다.
>
> SDD가 지휘봉을 잡습니다. 스킬은 호출될 때만 연주합니다. 게이트가 모두를 박자에 맞춥니다. 이것은 도구들의 민주주의가 아니라 — 악기를 거느린 하나의 프레임워크입니다.
>
> 신규든, 레거시든, 운영이든 — 프레임워크는 변하지 않고, 얼마나 엄격히 선을 지키는지만 달라집니다.

🎼
