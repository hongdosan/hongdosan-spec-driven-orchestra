# 강제 레이어 — SDD를 타협 불가로 만들기

> [!IMPORTANT]
> **이 파일은 참고용 한국어 번역입니다.**
> 정본은 영문 [`README.md`](./README.md)이며, 어긋날 경우 **항상 영문이 우선**합니다.
> (이 번역본은 강제력이 없으며, 한국어 사용자의 이해를 돕기 위한 것입니다.)

> 이 폴더는 SDD를 *AI가 따를 수도 있는 권고*에서 *비준수를 차단하는 게이트*로 바꿉니다.
> 마크다운은 부탁하고, 이 게이트는 강제합니다.

## 무엇이 들어 있나

| 파일 | 강제하는 것 | 유형 |
|---|---|---|
| `sdd/CONSTITUTION.md` | 규칙 집합 (R1–R7) — 규칙의 단일 출처 | 참조 |
| `hooks/pre-implement.sh` | R1, R2 — 스펙·계획 없이 코드 없음 | 로컬 훅 (차단) |
| `hooks/pre-commit.sh` | R3, R4, R6 — 검증 통과 없이 커밋 없음 | 로컬 훅 (차단) |
| `hooks/post-task.sh` | R5 — 인계 누락 경고 | 로컬 훅 (경고) |
| `sync-check.sh` | R7 — 모든 문서가 SPEC.yml과 일치 | 스크립트 + CI (차단) |
| `github-workflows/sdd-gate.yml` | R1, R3, R6, R7 — 우회 불가 머지 게이트 | CI (머지 차단) |

> **SPEC.yml** (레포 루트)은 *사실*의 단일 출처입니다 (악기 수, 출처, 라이선스,
> 모드 부재). `sync-check.sh`가 모든 문서의 일치를 검증합니다. SPEC.yml에서 사실을
> 바꾸고, sync-check를 돌리고, 걸린 것을 고치세요.

## 왜 로컬 훅과 CI 둘 다인가

로컬 훅은 빠른 피드백을 주지만 건너뛸 수 있습니다 (`git commit --no-verify`).
CI 게이트는 보호된 브랜치에서 건너뛸 수 없습니다 — 공유 코드에서 강제를 진짜로
만드는 최후의 보루입니다. 둘 다 쓰세요: 속도는 훅, 보장은 CI.

## 설치

```bash
# 1. Constitution (게이트가 읽는 규칙)
mkdir -p sdd && cp enforcement/sdd/CONSTITUTION.md sdd/CONSTITUTION.md

# 2. 로컬 훅
mkdir -p .claude/hooks
cp enforcement/hooks/pre-implement.sh .claude/hooks/
cp enforcement/hooks/post-task.sh    .claude/hooks/
cp enforcement/hooks/pre-commit.sh   .git/hooks/pre-commit
chmod +x .claude/hooks/*.sh .git/hooks/pre-commit

# 3. CI 게이트
mkdir -p .github/workflows
cp enforcement/github-workflows/sdd-gate.yml .github/workflows/

# 4. 게이트에게 프로젝트 검증 방법 알려주기
export SDD_TEST_CMD="npm test"      # 또는: pytest -q | go test ./... | cargo test
# CI의 경우: 레포 변수 SDD_TEST_CMD 설정 (Settings → Actions → Variables)
```

`pre-implement.sh`와 `post-task.sh`를 Claude Code 훅에 연결하세요 (파일 쓰기는
PreToolUse, 작업 완료는 Stop). 정확한 설정 위치는 시간이 지나며 바뀔 수 있으니
Claude Code의 훅 문서를 참고하세요.

## 레벨

- **standard** (기본): R1–R5; R3/R4는 `SDD_OVERRIDE="사유"`로 1회 우회 가능 (기록됨).
- **strict** (운영 시그널 감지 시 자동): R1–R6; 우회 불가.

## 솔직한 한계

이 게이트들은 **프로세스 최소치**(스펙 존재, 테스트 통과, 동작 보존)를 강제합니다.
*사고의 질*은 강제할 수 없습니다 — 스펙이 존재해도 얕을 수 있습니다. 게이트는 쉬운
실패 양상(테스트 건너뛰기, 계획 없이 코딩)을 제거할 뿐, 사람의 판단이나 검토를
대체하지 않습니다.