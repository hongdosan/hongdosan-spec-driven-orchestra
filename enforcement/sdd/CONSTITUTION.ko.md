# 프로젝트 헌법 — SDD 강제 규칙

> [!IMPORTANT]
> **이 파일은 참고용 한국어 번역입니다.**
> 게이트(훅·CI)와 sync-check가 실제로 읽는 **정본은 영문 [`CONSTITUTION.md`](./CONSTITUTION.md)** 입니다.
> 두 문서가 어긋날 경우 **항상 영문이 우선**합니다. 규칙을 바꿀 때는 영문을 먼저 고치세요.
> (이 번역본은 강제력이 없으며, 한국어 사용자의 이해를 돕기 위한 것입니다.)
>
> **런타임 위치**: 이 R1~R7 규칙의 실제 거처는 spec-kit의 `.specify/memory/constitution.md`입니다.
> `/speckit.constitution`으로 만든 뒤 R1~R7을 거기에 병합합니다. 그러면 이 패키지의 훅·CI(차단)와
> spec-kit `/speckit.analyze`(constitution 위반을 CRITICAL로 취급)가 함께 강제합니다.

---

## 0. 강제는 어떻게 작동하는가

SDD는 권고가 아닙니다. 이 규칙들은 AI에게 정중히 부탁하는 게 아니라, 결정론적 게이트로 강제됩니다:

- **로컬 훅** (`.claude/hooks/`) — 세션 도중 행동을 차단합니다.
- **CI 게이트** (`.github/workflows/sdd-gate.yml`) — 머지를 차단합니다.
- **spec-kit `/speckit.analyze`** — constitution 위반을 CRITICAL로 표기(advisory).

AI든 사람이든 단계를 건너뛰려 하면 게이트가 실패하고 행동이 멈춥니다. 핵심은, 준수 여부가 "모델이 규칙을 기억하는지"에 의존하지 않는다는 점입니다.

---

## 1. 규칙 (RULE ID는 훅이 참조함)

### R1 — 스펙 없이 코드 없음
`specs/<branch>/spec.md`(spec-kit `/speckit.specify` 산출)가 없는 기능의 구현 파일은
생성·수정할 수 없습니다. 강제: `pre-implement` 훅(세션 중) **및** `pre-commit` + CI 게이트
(fail-closed: 브랜치 `spec.md` 없이 코드가 staged/변경되면 차단, override로 우회 불가).

### R2 — 계획 없이 코드 없음
구현 중인 기능은 `specs/<branch>/plan.md`(`/speckit.plan` 산출)가 있어야 합니다.
강제: `pre-implement` 훅 **및** `pre-commit` + CI 게이트(같은 fail-closed 검사).

### R3 — 검증 통과 없이 커밋 없음
구현 파일을 건드리는 커밋은 테스트/검증이 통과해야 합니다.
no-op 테스트 명령(`true`, `:`, `echo …`)은 거부됩니다. 강제: `pre-commit` 훅 + CI 게이트.
(no-op 검사는 best-effort denylist입니다 — 실수/게으른 no-op은 막지만, `bash -c true`처럼
감싸는 의도적 회피는 막지 못합니다.)

### R4 — 기존 동작 보존 (컨텍스트 의존)
기능이 기존 코드를 건드리면, 회귀 검사(`specs/<branch>/regression.md`, 이 패키지의
추가분)가 존재하고 커밋 전에 통과해야 합니다. 보존할 것이 없는 신규 코드에서는 이 규칙이
자동 충족됩니다. 강제: `pre-commit` 훅.
**범위 한계:** R4는 해당 기능에 `survey.md`가 있을 때만 발동합니다(인터뷰가 기존 코드
프로젝트에 Step-0 조사를 켭니다). 조사가 없으면 게이트가 기존 코드를 건드렸는지 알 수 없어
R4가 발동하지 않습니다 — 레거시/유지보수 작업에서는 조사를 켜 두세요.

### R5 — 조용한 인계 누락 없음
`specs/<branch>/handoff.md`(이 패키지의 추가분) 없이 기능을 끝내는 것은 허용되지만
경고합니다. 강제: `post-task` 훅 (경고, 차단 아님).

### R6 — 운영 엄격성
운영 시그널(배포 설정, `.env.production` 등)이 감지되면 R3와 R4가 필수이며
우회 불가입니다. 운영 컨텍스트에는 "테스트 건너뛰기" 경로가 없습니다.
강제: `ENFORCEMENT_LEVEL=strict`를 읽는 모든 게이트.

### R7 — 문서 동기화
모든 문서는 `SPEC.yml`(단일 출처)과 일치해야 합니다: 악기 수, 출처, 라이선스,
모드 부재, 이중언어 쌍, 영/한 헤딩 대응. 하드코딩된 스타 수는 금지입니다(변동하므로).
강제: `sync-check.sh` + CI 게이트. 참고: 이건 *구조적* 동기화만 검사하며,
언어 간 의미 동등성은 여전히 사람의 검토가 필요합니다.

---

## 2. 강제 레벨

```
ENFORCEMENT_LEVEL = standard   # 기본값
ENFORCEMENT_LEVEL = strict     # 운영 시그널 감지 시 자동 설정
```

- **standard**: R1–R5 적용; R3/R4는 명시적·기록된 우회로 1회 건너뛸 수 있음.
- **strict**: R1–R6 적용; R3/R4 우회 불가.

> 컨텍스트가 동작을 바꾸는 곳은 *여기 하나뿐*입니다 — 컨텍스트에 따라 강제 레벨
> (standard/strict)만 올리거나 내릴 뿐, 그 외에는 아무것도 바꾸지 않습니다.

---

## 3. 우회 (standard 레벨에서만)

우회는 명시적이고 기록되어야 합니다 — 절대 조용히 넘어가지 않습니다:

```
SDD_OVERRIDE="<사유>" git commit ...
```

모든 우회는 타임스탬프와 사유와 함께 `DECISION-LOG.md`에 기록됩니다.
`strict` 레벨에서는 우회가 불가능합니다.

---

## 4. 이 헌법이 하지 않는 것

- AI가 프로젝트를 "이해하게" 만들지 않습니다 — 비준수가 *실패하게* 만들 뿐입니다.
- 사람의 검토를 대체하지 않습니다 — 검토자가 어차피 챙겼어야 할 최소치를 보장할 뿐입니다.
- 테스트의 대체물이 아닙니다 — 테스트 *없이는* 진행을 거부할 뿐입니다.