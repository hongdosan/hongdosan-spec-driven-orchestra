# spec-kit 한국어 요약 (다리 문서)

> [!IMPORTANT]
> **이 문서는 사람 이해용 비강제 요약입니다 (규칙 R).**
> spec-kit은 영어 문서만 제공하므로, 한국어 사용자의 진입을 돕기 위한 1페이지 요약입니다.
> **정확하고 권위 있는 내용은 항상 영문 원본**과 `specify init`이 설치한 `/speckit.*` 명령
> 정의가 기준입니다. 이 요약과 원본이 어긋나면 **원본이 우선**합니다.
> 원본: <https://github.com/github/spec-kit>
>
> 이 문서는 영문 짝이 없습니다 — 그 역할은 spec-kit의 영문 README가 대신합니다.

---

## spec-kit이 무엇인가 (한 줄)

명세(spec)를 먼저 쓰고, 그 명세에서 계획·작업·구현을 끌어내는 **Spec-Driven Development(SDD)
프레임워크**입니다. GitHub 공식 프로젝트이며 `specify` CLI와 `/speckit.*` 슬래시 명령으로 동작합니다.

## 설치 (전제조건)

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify init --here --integration claude   # .specify/ + /speckit.* 명령 생성
```

## 핵심 명령 (실행 기준은 설치된 명령 정의)

| 명령 | 하는 일 (요약) | 산출물 |
|---|---|---|
| `/speckit.constitution` | 프로젝트 원칙 정의 | `.specify/memory/constitution.md` |
| `/speckit.specify` | 무엇을·왜 (수용/엣지/성공기준 포함) | `specs/<branch>/spec.md` |
| `/speckit.clarify` | 모호한 점을 질문해 spec에 직접 기록 | (spec.md 갱신) |
| `/speckit.plan` | 기술·아키텍처 계획 | `specs/<branch>/plan.md` |
| `/speckit.tasks` | 실행 가능한 작업 목록 | `specs/<branch>/tasks.md` |
| `/speckit.analyze` | 산출물 간 일관성 점검 (advisory) | (보고) |
| `/speckit.checklist` | 요구사항 품질 체크리스트 ("영어용 단위테스트") | (체크리스트) |
| `/speckit.implement` | tasks.md대로 구현 | (코드) |

> 위 "하는 일"은 *요약*입니다. 각 명령의 실제 동작·세부 규칙은 영문 원본/설치된 명령 정의가 기준입니다.

## 이 패키지(Spec-Driven Orchestra)와의 관계

이 패키지는 spec-kit을 **재설명·재구현하지 않고 활용**합니다(규칙 R). spec-kit이 코어 흐름을
담당하고, 이 패키지는 그 위에 spec-kit이 *제공하지 않는 것*만 더합니다:

- **차단 게이트**(R1~R7): 테스트 미통과 시 커밋·머지 차단 (spec-kit의 analyze/checklist는 advisory)
- **레거시 보강**: `survey.md` / `regression.md`
- **인계**: `handoff.md`
- **오케스트레이션 순서·Tier·한국어 온보딩**

자세한 흐름은 [ORCHESTRA-GUIDE.ko.md](./ORCHESTRA-GUIDE.ko.md), 실행은
[AI-EXECUTION.ko.md](./AI-EXECUTION.ko.md)를 보세요.
