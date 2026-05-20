# 통합 검증 체크리스트

> 모드별로 다른 검증 항목.
> Day 0 (직후), Day 7 (1주 후), Day 30 (1개월 후) 시점에 사용.

---

## 🎯 사용 방법

### Day 0
통합 직후, 구조와 작동을 검증.

### Day 7
1주일 사용 후, 실효성 검증.

### Day 30
1개월 사용 후, 유지/조정/롤백 결정.

---

## ✅ Day 0: 통합 직후 검증

### 공통 자산 (모든 모드)

#### 최상위 파일
- [ ] CLAUDE.md 존재
- [ ] DECISION-LOG.md 존재
- [ ] INTEGRATION-REPORT.md 존재
- [ ] INTERVIEW-RESULT.md 존재

#### sdd/ 디렉터리
- [ ] sdd/CONSTITUTION.md 존재
- [ ] sdd/ORCHESTRA.md 존재
- [ ] sdd/README.md 존재
- [ ] sdd/templates/ 존재
- [ ] sdd/features/ 존재

#### .claude/skills/ 디렉터리 (5개)
- [ ] grill-me/SKILL.md
- [ ] grill-me/VARIANT.md
- [ ] sdd-conductor/SKILL.md
- [ ] karpathy-enforcer/SKILL.md
- [ ] harness-builder/SKILL.md
- [ ] handoff-writer/SKILL.md

#### 작동 검증
- [ ] 새 Claude Code 세션에서 CLAUDE.md 자동 로드
- [ ] Karpathy 4원칙 자동 적용 확인
- [ ] "grill me - 테스트" 발동 확인
- [ ] sdd-conductor 활성화 확인

#### 안전 검증
- [ ] ~/.claude/ (홈) 변경 없음
- [ ] 기존 코드 디렉터리 변경 없음
- [ ] Git 추적 가능

---

### 🌱 MODE_GREENFIELD 추가 검증

#### 표준 템플릿 (7개)
- [ ] sdd/templates/01-spec.md
- [ ] sdd/templates/02-clarify.md
- [ ] sdd/templates/03-plan.md
- [ ] sdd/templates/04-tasks.md
- [ ] sdd/templates/05-harness.md
- [ ] sdd/templates/06-implementation-notes.md
- [ ] sdd/templates/07-handoff.md

#### 첫 SDD 사이클
- [ ] sdd/features/F000-bootstrap/ 존재
- [ ] 7개 파일 모두 작성됨
- [ ] 부트스트랩 컨텍스트로 채워짐

#### CONSTITUTION.md 검증
- [ ] "신규 프로젝트" 톤
- [ ] 부트스트랩 단계 명시
- [ ] 신규 특화 원칙 포함

---

### 🌿 MODE_EARLY 추가 검증

#### 표준 템플릿 (7개)
- [ ] sdd/templates/01-spec.md ~ 07-handoff.md 모두

#### archive/ (기존 자산 있었다면)
- [ ] archive/README.md 존재
- [ ] archive/[legacy-X]/ 존재
- [ ] 기존 자산 안전하게 백업됨

#### 첫 SDD 사이클
- [ ] sdd/features/F000-integration/ 존재
- [ ] 7개 파일 모두 작성됨
- [ ] 통합 과정 자체를 SDD로 표현

#### CONSTITUTION.md 검증
- [ ] "초기 진행" 톤
- [ ] 기존 자산 활용 안내
- [ ] 점진적 전환 원칙

---

### 🔨 MODE_REBUILD 추가 검증

#### 확장 템플릿 (9개)
- [ ] sdd/templates/00-archaeology.md ⭐ 추가
- [ ] sdd/templates/01-spec.md ~ 05-harness.md
- [ ] sdd/templates/05b-regression.md ⭐ 추가
- [ ] sdd/templates/06-implementation-notes.md
- [ ] sdd/templates/07-handoff.md

#### 추가 Skill (2개)
- [ ] .claude/skills/code-archaeologist/SKILL.md ⭐ 추가
- [ ] .claude/skills/migration-strategist/SKILL.md ⭐ 추가

#### archive/legacy/ (필수)
- [ ] archive/legacy/code/ 전체 백업
- [ ] archive/legacy/docs/ 전체 백업
- [ ] archive/legacy/config/ 전체 백업
- [ ] archive/README.md (매핑 + 롤백)

#### 첫 SDD 사이클
- [ ] sdd/features/F000-rebuild-plan/ 존재
- [ ] **9개 파일 모두 작성됨** (00 + 01~07 + 05b)
- [ ] 00-archaeology.md 의미 있는 분석
- [ ] 05b-regression.md 보존 동작 명시

#### CONSTITUTION.md 검증
- [ ] "리팩토링 TF" 톤
- [ ] 9단계 SDD 명시
- [ ] 기존 동작 보존 원칙
- [ ] 점진 전환 원칙 (Strangler Fig 등)

---

## ✅ Day 7: 1주일 후

### 실사용 점검 (모든 모드 공통)

#### 사용 횟수
- 실제 SDD 사이클: __ 회 (목표: 1회 이상)
- grill-me 발동: __ 회
- Mini SDD 사용: __ 회
- No SDD (간단): __ 회

#### 어디서 막혔나
- [ ] Phase 1 (Specify) 작성 부담
- [ ] Phase 2 (Clarify) grill-me 질문 많음
- [ ] Phase 3 (Plan) 기술 선택 어려움
- [ ] Phase 4 (Tasks) 분할 단위 모호
- [ ] Phase 5 (Harness) 시나리오 발굴 부족
- [ ] Phase 6 (Implement) Karpathy 적응
- [ ] Phase 7 (Handoff) 누락 검출 부담

#### 효과 측정
- [ ] AI 응답 일관성 향상
- [ ] 코드 변경 명확성 향상
- [ ] 결정 추적 가능성 향상
- [ ] 다음 작업으로 매끄러움

---

### 🌱 MODE_GREENFIELD 1주 후

#### 부트스트랩 진행도
- [ ] F000-bootstrap 완료
- [ ] F001 시작 가능 상태
- [ ] CONSTITUTION.md 갱신 필요 사항 있나?

#### 신규 프로젝트 함정 점검
- [ ] 첫 주에 너무 많은 기능 추가 시도?
- [ ] 거대 추상화 도입 유혹?
- [ ] SDD 절차 부담 → 무시 충동?

---

### 🌿 MODE_EARLY 1주 후

#### 기존 자산 활용도
- [ ] archive/ 의 자산을 참고했나?
- [ ] 기존 코드와 신규 SDD 코드 충돌?
- [ ] 점진적 전환 진행 중?

#### 새 워크플로우 적응도
- [ ] 기존 방식과 SDD 워크플로우 혼동?
- [ ] 팀원 (있다면) 합의 OK?

---

### 🔨 MODE_REBUILD 1주 후

#### 리팩토링 진행도
- [ ] F000-rebuild-plan 완료?
- [ ] 첫 모듈 archaeology 완료?
- [ ] 점진 전환 시작?

#### Regression 통과율
- [ ] 보존 대상 동작 (B1, B2, ...) 통과율: __%
- [ ] 통과 실패 항목: __개

#### 위험 신호
- [ ] archive/legacy/ 수정 욕구 (절대 금지)
- [ ] 한 번에 다 바꾸려는 충동
- [ ] Feature Flag 안 쓰고 직접 교체
- [ ] regression 통과 안 했는데 머지

---

### 조정 제안 (모든 모드)

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
- 진행한 Full SDD: __ 회
- 진행한 Mini SDD: __ 회
- DECISION-LOG.md 항목: __ 개

#### 4원칙 준수율
최근 PR/커밋 검토:
- Think Before Coding 위배: __ 건
- Simplicity First 위배: __ 건
- Surgical Changes 위배: __ 건
- Goal-Driven Execution 위배: __ 건

---

### 정성 점검 (공통)

#### 통합 전후 비교

| 항목 | 통합 전 | 통합 후 | 변화 |
|---|---|---|---|
| 코드 명확성 | | | |
| 결정 추적성 | | | |
| 핸드오프 품질 | | | |
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

### 🌱 MODE_GREENFIELD 1개월 후

#### 부트스트랩 → 초기 진행 전환
- [ ] 코드 파일 수: 통합 전 __ → 현재 __
- [ ] Git 커밋 수: 통합 전 __ → 현재 __
- [ ] CONSTITUTION.md를 "초기" 톤으로 갱신 시점?
- [ ] MODE_GREENFIELD → MODE_EARLY 자연 전환?

#### 신규 프로젝트 성공 지표
- [ ] 첫 100시간이 잘 흘러갔는가?
- [ ] 거대 추상화 함정 피했는가?
- [ ] 결정 기록이 도움되는가?

---

### 🌿 MODE_EARLY 1개월 후

#### 진행도 변화
- [ ] 코드 파일: 통합 전 __ → 현재 __
- [ ] 새 워크플로우 정착도: __%
- [ ] 기존 코드와 신규 코드 비율: __%

#### 마이그레이션 (필요했다면)
- [ ] archive/ 의 자산 중 마이그레이션 완료: __%
- [ ] 마이그레이션 필요 없음 판단: ___ 개

---

### 🔨 MODE_REBUILD 1개월 후

#### 리팩토링 완료도
- [ ] 전체 리팩토링: __% 완료
- [ ] Regression 통과율: __%
- [ ] 마이그레이션된 모듈: __개 / 총 __개

#### 점진 전환 성공
- [ ] Feature Flag 활용: __개
- [ ] Strangler Fig 패턴 적용: __번
- [ ] 무중단 전환 성공률: __%

#### 리팩토링 종료 후 모드 전환
- [ ] MODE_REBUILD → MODE_EARLY로 전환 시점?
- [ ] archive/legacy/ 유지 (참조용)
- [ ] 00-archaeology, 05b-regression 템플릿 유지

---

### 결정 시점 (모든 모드)

#### A. 유지
- 통합이 잘 작동
- → 현재 구조 유지

#### B. 부분 조정
- 일부 부담
- → 조정:
  - [ ] ___

#### C. 모드 전환
- 프로젝트 단계 변화
- → 전환:
  - MODE_GREENFIELD → MODE_EARLY: ___
  - MODE_REBUILD → MODE_EARLY: ___

#### D. 재설계
- 의도와 다름
- → 새 통합 계획

---

### 학습 기록

```
[배운 점 1]
[배운 점 2]
[배운 점 3]
```

다음 프로젝트에 적용할 것:
```
[적용 아이디어 1]
[적용 아이디어 2]
```

---

## 🔄 롤백 가이드

### 신호 (모든 모드 공통)
- [ ] 1주 동안 한 번도 SDD 안 함
- [ ] 작업 속도 50% 이상 감소
- [ ] 학습 부담 과중
- [ ] 즐거움 사라짐

### MODE_REBUILD 추가 신호
- [ ] Regression 통과율 50% 미만
- [ ] 점진 전환이 작동 안 함
- [ ] archive/legacy/ 의 동작과 큰 차이

---

### 단계적 롤백

#### Level 1: 부분 비활성화
```bash
# 가장 부담스러운 것부터
# 예: Harness 매번 작성 부담
echo "Harness는 큰 기능에만" >> sdd/CONSTITUTION.md
```

#### Level 2: 절반 롤백
```bash
# Karpathy + grill-me만 유지
rm -rf sdd/templates/
```

#### Level 3: 완전 롤백

##### MODE_GREENFIELD
```bash
# 만든 것만 제거
rm CLAUDE.md DECISION-LOG.md INTEGRATION-REPORT.md INTERVIEW-RESULT.md
rm -rf sdd/ .claude/skills/
# (archive가 없으므로 복원 불필요)
```

##### MODE_EARLY
```bash
# archive에서 복원 (있다면)
cp -r archive/legacy-*/* [원래 위치]/

# 통합 결과물 제거
rm -rf sdd/ .claude/skills/
rm CLAUDE.md DECISION-LOG.md INTEGRATION-REPORT.md INTERVIEW-RESULT.md
```

##### MODE_REBUILD
```bash
# archive/legacy 에서 코드 전체 복원
cp -r archive/legacy/code/* [원래 코드 위치]/
cp -r archive/legacy/docs/* [원래 문서 위치]/
cp -r archive/legacy/config/* ./

# 신규 자산 제거
rm -rf sdd/ .claude/skills/
rm CLAUDE.md DECISION-LOG.md INTEGRATION-REPORT.md INTERVIEW-RESULT.md
```

#### Git 활용 롤백 (가장 안전)
```bash
git log --oneline | grep "AI 통합" | head -1
git reset --hard [통합 직전 커밋]
```

---

### 롤백 기록

```
[안 맞았던 부분 1]
- 이유:
- 대안 아이디어:

[안 맞았던 부분 2]
- ...
```

이 기록은 향후 패키지 개선에 활용.

---

## 🎯 한 줄 요약

> **Day 0에 구조 검증, Day 7에 사용 후기, Day 30에 유지/조정/롤백 결정. 모드별로 추가 검증 항목 있음 (특히 MODE_REBUILD는 regression 등). 부담이 효과보다 크면 단계적 롤백.**
