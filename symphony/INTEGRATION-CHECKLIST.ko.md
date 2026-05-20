# 통합 검증 체크리스트

> 하나의 흐름, 하나의 체크리스트. 기존 코드 프로젝트는 조사/회귀 항목 몇 개를 더하고, 운영은 게이트 엄격도를 올립니다. 모드별 변형은 없습니다.
> Day 0 (직후), Day 7 (1주 후), Day 30 (1개월 후) 시점에 사용.

> [!NOTE]
> 본인의 **단계(Tier)**가 도입한 것만 점검하세요. Tier 1(Karpathy + grill-me)은 여기서 검증할 게 거의 없습니다. 아래 구조 항목들은 Tier 2 이상(SDD 흐름)과 Tier 3(Verification Design + 🎸 Harness)에 도달했을 때 적용됩니다. 🎸 Harness 항목은 선택적이며, 작업에 에이전트 팀이 필요했을 때만 해당합니다.

---

## 🎯 사용 방법

### Day 0
통합 직후 — 구조와 동작 검증.

### Day 7
1주 사용 후 — 효과 검증.

### Day 30
1개월 사용 후 — 유지/조정/롤백 결정.

---

## ✅ Day 0: 통합 직후 검증

### 항상 생성

#### 최상위 파일
- [ ] CLAUDE.md 존재
- [ ] DECISION-LOG.md 존재
- [ ] INTEGRATION-REPORT.md 존재
- [ ] INTERVIEW-RESULT.md 존재

#### sdd/ 디렉터리
- [ ] sdd/CONSTITUTION.md 존재 (규칙 R1–R7)
- [ ] sdd/ORCHESTRA.md 존재
- [ ] sdd/README.md 존재
- [ ] sdd/templates/ 존재
- [ ] sdd/features/ 존재

#### 강제 레이어 ("권고가 아니라 강제"의 핵심)
- [ ] `.claude/hooks/pre-implement.sh` 설치 & 실행권한 (R1, R2)
- [ ] `.git/hooks/pre-commit` 설치 & 실행권한 (R3, R4, R6)
- [ ] `.claude/hooks/post-task.sh` 설치 (R5)
- [ ] `.github/workflows/sdd-gate.yml` 존재 (R1, R3, R6, R7)
- [ ] `SPEC.yml` 레포 루트에 존재 (SSOT)
- [ ] `SDD_TEST_CMD` 설정됨 (게이트가 검증 방법을 앎)
- [ ] 운영 시그널이면: `ENFORCEMENT_LEVEL=strict` 설정됨

#### 게이트 스모크 테스트 (게이트가 실제로 막는가?)
- [ ] 테스트 실패 상태로 코드 커밋 시도 → **커밋 차단됨** (R3)
- [ ] spec/plan 없이 "구현" 시도 → **차단됨** (R1/R2)
- [ ] `bash enforcement/sync-check.sh .` → 통과 (R7)

#### .claude/skills/ 디렉터리 (이 패키지가 생성하는 5개)
- [ ] grill-me/SKILL.md
- [ ] grill-me/VARIANT.md
- [ ] sdd-conductor/SKILL.md
- [ ] karpathy-enforcer/SKILL.md
- [ ] harness-builder/SKILL.md
- [ ] handoff-writer/SKILL.md

#### 🎸 Harness (선택 — 작업에 에이전트 팀이 필요했을 때만)
> Harness는 외부 플러그인(revfactory/harness)이며, 이 패키지가 생성하지 않습니다.
- [ ] 필요할 때만 설치: `/plugin install harness@harness`
- [ ] 사용했다면, 무거운 작업을 위해 `.claude/agents/` 생성됨
- [ ] 에이전트 팀이 필요한 작업이 없었다면 해당 없음

#### 동작 검증
- [ ] 새 Claude Code 세션에서 CLAUDE.md 자동 로드
- [ ] Karpathy 4원칙 자동 적용
- [ ] "grill me - test" 발동
- [ ] sdd-conductor 활성화

#### 안전 검증
- [ ] ~/.claude/ (홈) 변경 없음
- [ ] 기존 코드 디렉터리 변경 없음
- [ ] Git 추적 가능

#### 표준 템플릿 (항상)
- [ ] sdd/templates/01-spec.md
- [ ] sdd/templates/02-clarify.md
- [ ] sdd/templates/03-plan.md
- [ ] sdd/templates/04-tasks.md
- [ ] sdd/templates/05-harness.md
- [ ] sdd/templates/06-implementation-notes.md
- [ ] sdd/templates/07-handoff.md

#### CONSTITUTION.md 검증
- [ ] 프로젝트 정체성과 현재 단계 반영
- [ ] Karpathy 4원칙과 SDD 7단계 포함
- [ ] 강제 레벨 명시 (standard/strict)

### 컨텍스트 추가 — 기존 코드가 있을 때만 검증

> 신규 프로젝트에서는 이 블록 전체를 건너뜁니다 (0단계 조사 꺼짐).

#### 기존 코드 템플릿 & 스킬
- [ ] sdd/templates/00-survey.md 추가됨
- [ ] sdd/templates/05b-regression.md 추가됨
- [ ] .claude/skills/code-archaeologist/SKILL.md 추가됨
- [ ] .claude/skills/migration-strategist/SKILL.md 추가됨

#### archive/ (기존 자산 백업)
- [ ] archive/README.md 존재 (매핑 + 롤백)
- [ ] 기존 코드/문서/설정 안전하게 백업
- [ ] 원본은 참조만, 제자리 수정 없음

#### 조사가 포함된 첫 SDD 사이클
- [ ] sdd/features/F001-*/00-survey.md 에 의미 있는 분석
- [ ] 05b-regression.md 에 보존할 동작 명시 (B1, B2, ...)

#### strict 레벨 (운영 시그널 감지 시)
- [ ] ENFORCEMENT_LEVEL=strict 확인
- [ ] `SDD_OVERRIDE` 우회 경로 없음
- [ ] pre-commit이 테스트 AND 회귀 통과 없이 거부

---

## ✅ Day 7: 1주 후

### 실사용 점검 (모든 프로젝트)

#### 사용 횟수
- 실제 SDD 사이클: __ (목표: 1+)
- grill-me 발동: __
- Mini SDD 사용: __
- SDD 미적용 (단순): __

#### 어디서 막혔나
- [ ] Phase 1 (Specify) 작성 부담
- [ ] Phase 2 (Clarify) grill-me 질문 과다
- [ ] Phase 3 (Plan) 기술 선택 어려움
- [ ] Phase 4 (Tasks) 분할 단위 모호
- [ ] Phase 5 (Harness) 시나리오 발굴 부족
- [ ] Phase 6 (Implement) Karpathy 적응
- [ ] Phase 7 (Handoff) 누락 검출 부담

#### 효과 측정
- [ ] AI 응답 일관성 향상
- [ ] 코드 변경 명확성 향상
- [ ] 결정 추적성 향상
- [ ] 다음 작업으로 매끄러운 전환

---

### 흐름 진척 (모든 프로젝트)

#### SDD 사이클
- [ ] F001 완료 또는 진행 중?
- [ ] CONSTITUTION.md 갱신할 것?
- [ ] 게이트가 예상대로 작동하나 (우회되지 않고)?

#### 공통 함정 점검
- [ ] 한 번에 너무 많은 기능 추가 시도?
- [ ] 거대 추상화 도입 유혹? (Karpathy: Simplicity First)
- [ ] 프로세스 부담 → 게이트 우회 욕구? (그렇다면 우회 말고 단계를 내리기)

### 기존 코드 점검 (기존 코드가 있을 때만)

#### 기존 자산 활용
- [ ] archive/ 자산을 참조했나?
- [ ] 기존 코드와 새 SDD 코드 충돌?
- [ ] 점진 전환(Strangler Fig / Feature Flag) 진행 중?

#### 회귀 통과율
- [ ] 보존할 동작 (B1, B2, ...) 통과율: __%
- [ ] 실패 항목: __

#### 위험 신호
- [ ] archive/legacy/ 수정 욕구 (금지)
- [ ] 한 번에 전부 바꾸려는 욕구
- [ ] Feature Flag 없이 직접 교체
- [ ] 회귀 미통과 머지 (게이트가 막아야 함)

---

### 조정 제안

```
[이슈 1]
- 현재 상태:
- 개선 아이디어:
- 적용 시점:

[이슈 2]
- ...
```

---

## ✅ Day 30: 1개월 후

### 정량 점검 (공통)

#### 활용도
- Full SDD 수행: __
- Mini SDD 수행: __
- DECISION-LOG.md 항목: __

#### 4원칙 준수
최근 PR/커밋 검토:
- Think Before Coding 위반: __
- Simplicity First 위반: __
- Surgical Changes 위반: __
- Goal-Driven Execution 위반: __

---

### 정성 점검 (공통)

#### Before/After 비교

| 항목 | 이전 | 이후 | 변화 |
|---|---|---|---|
| 코드 명확성 | | | |
| 결정 추적성 | | | |
| 인계 품질 | | | |
| 작업 속도 | | | |
| 학습 곡선 | | | |

#### 가장 도움된 것
1. ___
2. ___
3. ___

#### 가장 부담된 것
1. ___
2. ___
3. ___

---

### 신규 프로젝트 성공 지표 (신규일 때)
- [ ] 첫 100시간이 잘 흘렀나?
- [ ] 거대 추상화 함정을 피했나?
- [ ] 결정 기록이 도움되나?

---

### 성장 점검 (모든 프로젝트)

#### 진척 변화
- [ ] 코드 파일: 이전 __ → 현재 __
- [ ] Git 커밋: 이전 __ → 현재 __
- [ ] 작업 전반의 SDD 적용률: __%

#### 게이트가 버텼나?
- [ ] 테스트 없이 빠져나간 커밋? (0에 가까워야)
- [ ] spec/plan 없는 구현? (0에 가까워야)
- [ ] sync-check 여전히 통과? (R7)

### 기존 코드 성장 (기존 코드가 있을 때만)

#### 마이그레이션 진척
- [ ] archive/ 자산 중 마이그레이션 완료: __%
- [ ] 회귀 통과율: __%
- [ ] 마이그레이션된 모듈: __ / 전체 __

#### 점진 전환 성공
- [ ] 사용한 Feature Flag: __
- [ ] 적용한 Strangler Fig: __ 회
- [ ] 무중단 전환 성공률: __%

---

### 결정 시점

#### A. 유지
- 통합이 잘 작동
- → 현재 구조 유지

#### B. 부분 조정
- 일부 부담
- → 조정 (예: 작은 작업은 단계 내리기):
  - [ ] ___

#### C. 강제 조정
- 컨텍스트 대비 게이트가 너무 엄격/느슨
- → 레벨 조정 (단, 운영은 strict 유지):
  - [ ] ___

#### D. 재설계
- 의도와 다름
- → 새 통합 계획

> 참고: "모드 전환"이라는 건 없습니다 — 흐름은 일정합니다. 프로젝트가 성장하거나 배포되면 조사와 strict 게이트가 자동으로 나타납니다 (ORCHESTRA-GUIDE "프로젝트가 진화하면" 참조).

---

### 학습 기록

```
[교훈 1]
[교훈 2]
[교훈 3]
```

다음 프로젝트에 적용할 것:
```
[아이디어 1]
[아이디어 2]
```

---

## 🔄 롤백 가이드

### 신호 (모든 프로젝트)
- [ ] 1주 내내 SDD 미사용
- [ ] 작업 속도 50%+ 하락
- [ ] 과도한 학습 부담
- [ ] 즐거움이 사라짐
- [ ] 게이트와 계속 싸움 (롤백 전에 단계 내리기 고려)

### 기존 코드 추가 신호 (해당 시)
- [ ] 회귀 통과율 50% 미만
- [ ] 점진 전환이 작동 안 함
- [ ] archive/legacy/ 동작과 큰 차이

---

### 단계적 롤백

#### Level 1: 부분 비활성화
```bash
# 가장 부담되는 것부터
# 예: 매번 Harness 작성이 부담
echo "Harness only for large features" >> sdd/CONSTITUTION.md
```

#### Level 2: 절반 롤백
```bash
# Karpathy + grill-me만 유지 (Tier 1)
rm -rf sdd/templates/
```

#### Level 3: 전체 롤백
```bash
# 1. archive에서 원본 복원 (기존 코드가 있었을 때만)
#    cp -r archive/legacy/code/*   [원래 코드 위치]/
#    cp -r archive/legacy/docs/*   [원래 문서 위치]/
#    cp -r archive/legacy/config/* ./
#    (신규는 archive가 없으니 이 단계 생략)

# 2. 통합 산출물 제거
rm -rf sdd/ .claude/skills/ .claude/hooks/
rm -f .git/hooks/pre-commit .github/workflows/sdd-gate.yml SPEC.yml
rm CLAUDE.md DECISION-LOG.md INTEGRATION-REPORT.md INTERVIEW-RESULT.md
```

#### Git 기반 롤백 (가장 안전)
```bash
git log --oneline | grep "AI integration" | head -1
git reset --hard [통합 직전 커밋]
```

---

### 롤백 기록

```
[안 맞았던 것 1]
- 이유:
- 대안 아이디어:

[안 맞았던 것 2]
- ...
```

이 기록으로 향후 패키지를 개선합니다.

---

## 🎯 한 줄 요약

> **Day 0에 구조와 게이트 작동 검증, Day 7에 사용 후기, Day 30에 유지/조정/롤백 결정. 기존 코드 프로젝트는 조사 & 회귀 점검을 더합니다. 부담이 효과보다 크면 단계를 내리거나 단계적으로 롤백하세요.**
