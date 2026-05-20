# 🎼 Orchestra Guide - 5중주 가이드

> 5가지 AI 코딩 도구가 어떻게 협력하는지 안내합니다.
> 모든 모드 (GREENFIELD/EARLY/REBUILD)에서 공통으로 적용됩니다.

---

## 1. 오케스트라 구성

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

### 각 악기

| 악기 | 도구 | 역할 |
|---|---|---|
| 🎼 지휘자 | **SDD** | 전체 7단계 흐름 통제 |
| 🎻 1st Violin | **Karpathy 4원칙** | 코드 품질 강제 |
| 🎹 Piano | **grill-me** | 모호함 제거, 명확화 |
| 🥁 Percussion | **Harness** | 검증 기준 설계 |
| 🎺 Brass | **Handoff** | 작업 인계 |

---

## 2. 모드별 추가 악기

### MODE_REBUILD 전용

리팩토링 모드에서는 2개 악기 추가:

```
🎼 SDD (확장 9단계)
   │
   ├─ 기존 5중주 (모든 모드 공통)
   │
   └─ 추가 2개:
      🪕 Banjo (Code Archaeologist) - 기존 코드 분석
      🎷 Saxophone (Migration Strategist) - 점진 전환
```

---

## 3. 7단계 흐름 (모든 모드 공통)

```
사용자 요청
    ↓
[작업 분류]
    ├─ Full SDD → 1~7 모두
    ├─ Mini SDD → 1, 6, 7만
    └─ No SDD → 즉시 코딩 (Karpathy만)

[Full SDD 흐름]
1. Specify   🎼 (What & Why)
   ↓
2. Clarify   🎹 (grill-me)
   ↓
3. Plan      🎼 (How)
   ↓
4. Tasks     🎼 (분할)
   ↓
5. Harness   🥁 (검증 설계)
   ↓
6. Implement 🎻 (Karpathy 4원칙)
   ↓
7. Handoff   🎺 (인계)
```

### MODE_REBUILD 확장 (9단계)

```
0. Archaeology 🪕 (기존 코드 분석)
   ↓
1~5. [표준]
   ↓
5b. Regression 🥁+🪕 (기존 동작 보장)
   ↓
6. Implement 🎻+🎷 (Karpathy + Migration)
   ↓
7. Handoff 🎺
```

---

## 4. 악장별 연주 가이드

### 🎼 Movement 1: Specify

**주역**: SDD

#### 무엇을 하는가
- 01-spec.md 작성
- What & Why 명문화
- 범위 정의

#### 안티 패턴
- ❌ How를 미리 적기
- ❌ 범위 무한 확장
- ❌ Why 없이 What만

---

### 🎹 Movement 2: Clarify

**주역**: grill-me (Piano)

#### 무엇을 하는가
- 02-clarify.md 작성
- 모든 모호함 제거

#### 발동
```
"grill me - F[ID] 명확화"
```

#### 흐름
1. AI가 15-50개 질문 (추천 답변 포함)
2. 사용자 답변 (또는 "yes")
3. 결정 명확해질 때까지
4. AI 요약 → 02-clarify.md

#### 안티 패턴
- ❌ "아무거나"
- ❌ "나중에 결정"
- ❌ 추천 무조건 거부

---

### 🎼 Movement 3: Plan

**주역**: SDD

#### 무엇을 하는가
- 03-plan.md 작성
- 기술 선택
- 아키텍처

#### 다른 악기
- 🎻 Karpathy: 더 단순한 방법 검토
- 🎹 grill-me: 기술 모호 시 발동

---

### 🎼 Movement 4: Tasks

**주역**: SDD

#### 무엇을 하는가
- 04-tasks.md 작성
- 30분~2시간 단위 분할

#### 다른 악기
- 🎻 Karpathy: Goal-Driven → 각 Task 검증 기준

---

### 🥁 Movement 5: Harness

**주역**: Harness (Percussion)

#### 무엇을 하는가
- 05-harness.md 작성
- 5대 카테고리 모두 커버

#### 발동
```
"grill me - F[ID] 하네스 설계"
```

#### 5대 카테고리
1. Happy Path
2. Sad Path
3. Edge Cases
4. Adversarial
5. Performance

---

### 🥁🪕 Movement 5b: Regression (MODE_REBUILD 전용)

**주역**: Harness + Code Archaeologist

#### 무엇을 하는가
- 05b-regression.md 작성
- 기존 동작 보존 검증

#### 작업
1. 00-archaeology.md 의 "B1, B2, ..." 가져오기
2. 각 동작에 대한 검증 시나리오 작성
3. 점진 전환 단계 정의
4. 롤백 시나리오 명시

---

### 🎻 Movement 6: Implement

**주역**: Karpathy 4원칙 (1st Violin)

#### 무엇을 하는가
- 코드 작성
- 06-implementation-notes.md 갱신

#### 4원칙 적용

##### Think Before Coding
```
- 가정 명시
- 모호하면 grill-me
- 트레이드오프 제시
```

##### Simplicity First
```
- 50줄 가능한가?
- 추측성 기능?
- 단일 사용처 추상화?
```

##### Surgical Changes
```
- 영향 받는 파일만?
- 인접 코드 보호?
- 기존 스타일 유지?
```

##### Goal-Driven Execution
```
- Harness의 어떤 H 만족?
- 검증 가능한가?
```

#### MODE_REBUILD 추가 (🎷 Migration Strategist)
- Strangler Fig 패턴
- Feature Flag
- Branch by Abstraction

---

### 🎺 Movement 7: Handoff

**주역**: Handoff (Brass)

#### 무엇을 하는가
- 07-handoff.md 작성
- 누락 검출
- 다음 작업자 컨텍스트

#### 발동
```
"grill me - F[ID] 핸드오프"
```

#### 안티 패턴
- ❌ "잘 됩니다"
- ❌ "별 문제 없음"
- ❌ 다음 액션 없이 종료

---

## 5. 듀엣과 협주

### SDD + grill-me

가장 흔한 협업:
```
Specify 중 모호 발견
   ↓
grill-me 자동 발동
   ↓
명확화 후 Spec 갱신
```

### Karpathy + Harness

품질 콤보:
```
Harness 설계 중
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

### 🪕 + 🎷 (MODE_REBUILD 전용)

리팩토링 콤보:
```
Archaeology가 기존 동작 발굴
   ↓
Migration Strategist가 전환 전략 수립
   ↓
점진적 안전 전환
```

---

## 6. 실전 시나리오 (모드별)

### 🌱 MODE_GREENFIELD: 첫 기능

```
사용자: "새 기능 [이름]"

AI: [sdd-conductor]
    F001-[이름]/ 생성
    
AI: 01-spec.md (What & Why)
AI: 02-clarify.md (grill-me)
AI: 03-plan.md (기술 선택)
AI: 04-tasks.md (분할)
AI: 05-harness.md (검증)
AI: 06-implement (Karpathy)
AI: 07-handoff.md
```

### 🌿 MODE_EARLY: 진행 중 기능

```
사용자: "X 기능 개선"

AI: 기존 코드 일부 확인
AI: F00N-X-improvement/ 생성
    
[표준 7단계, 단 03-plan에서 기존 코드 영향 고려]
```

### 🔨 MODE_REBUILD: 리팩토링 단위

```
사용자: "Auth 모듈 리팩토링"

AI: [code-archaeologist]
    00-archaeology.md
    - archive/legacy/auth/ 분석
    - 동작 매핑
    - 보존할 동작 (B1, B2, ...)

AI: 01-spec.md (새 Auth의 What)
AI: 02-clarify.md
AI: 03-plan.md (전환 전략)
AI: 04-tasks.md
AI: 05-harness.md (신규 기능 검증)
AI: 05b-regression.md (기존 동작 보장)

AI: [migration-strategist]
    06-implement
    - Strangler Fig 적용
    - Feature Flag 사용
    - 점진 전환
    - regression 통과 확인

AI: 07-handoff.md
```

---

## 7. 안티 오케스트라

### 솔로 연주
- ❌ SDD만 (다른 4가지 무시)
- ❌ Karpathy만 (SDD 흐름 무시)
- ❌ grill-me만 (구조 없이)

### 불협화음
- ❌ Spec 결정을 Implement에서 무시
- ❌ Harness 무시하고 PR
- ❌ Handoff 거짓 정보

### 박자 무시
- ❌ Clarify 없이 Plan
- ❌ Plan 없이 Implement
- ❌ Harness 없이 PR
- ❌ (MODE_REBUILD) Archaeology 없이 시작

### 지휘자 무시
- ❌ sdd/features/ 밖에서 작업
- ❌ 템플릿 무시
- ❌ Constitution 어기기

---

## 8. 학습 곡선

### 첫 1주
- Full SDD 자주 쓰지 말 것
- Mini SDD 1-2회로 익히기
- CLAUDE.md, ORCHESTRA-GUIDE.md 정독

### 첫 1개월
- Full SDD 2-3회
- DECISION-LOG.md 갱신 습관화

### 그 이후
- 자연스럽게 흐름
- 5중주 무의식적 조화

### MODE_REBUILD 추가 학습
- Strangler Fig 패턴 이해
- Feature Flag 활용
- Branch by Abstraction

---

## 9. 모드 전환

### 초기 → 중반

```
프로젝트가 성장하면:
MODE_EARLY 적용된 프로젝트가 자연스럽게 중반으로

대응:
- CONSTITUTION.md 진행 단계 갱신
- 별도 패키지 변경 불필요
```

### 신규 → 초기

```
부트스트랩 완료 후:
MODE_GREENFIELD → MODE_EARLY 자연 전환

대응:
- CONSTITUTION.md "신규" → "초기" 톤 조정
- F000-bootstrap 완료, F001부터 새 기능
```

### 리팩토링 완료

```
MODE_REBUILD 완료 후:
- archive/legacy/ 보존 (이력)
- CONSTITUTION.md → "초기" 또는 "중반"으로
- 00-archaeology.md, 05b-regression.md 템플릿은 유지 (참조용)
```

---

## 10. 마지막 한 마디

> 이 오케스트라의 목표는 **빠른 코드 작성이 아니라, 시간이 지나도 흔들리지 않는 코드와 컨텍스트의 보존**이다.
>
> SDD가 지휘봉을 잡고, 나머지 악기들이 각자의 자리에서 빛날 때, 진정한 AI 코딩의 오케스트라가 완성된다.
>
> 신규든, 초기든, 리팩토링이든 — 5중주의 본질은 변하지 않는다.

🎼
