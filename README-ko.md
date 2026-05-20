# 🎼 Spec-Driven Orchestra

> **SDD가 지휘하는 5중주 AI 코딩 워크플로우 통합 패키지**
> 
> 신규/초기/리팩토링 프로젝트에 AI 코딩론 5가지를 조화롭게 적용합니다.

<p align="center">
  🌐 <b>언어</b>: <a href="./README.md">English</a> | <b>한국어</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Method-SDD%20Orchestra-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Instruments-5-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Made%20for-Claude%20Code-purple?style=for-the-badge" />
</p>

<p align="center">
  <a href="https://github.com/hongdosan/hongdosan-spec-driven-orchestra/stargazers">
    <img src="https://img.shields.io/github/stars/hongdosan/hongdosan-spec-driven-orchestra?style=social" />
  </a>
  <a href="https://github.com/hongdosan/hongdosan-spec-driven-orchestra/network/members">
    <img src="https://img.shields.io/github/forks/hongdosan/hongdosan-spec-driven-orchestra?style=social" />
  </a>
</p>

<p align="center">
  <a href="#-빠른-시작">빠른 시작</a> •
  <a href="#-오케스트라-구성">오케스트라</a> •
  <a href="#-어떤-프로젝트에-적용-가능한가요">적용 범위</a> •
  <a href="#-faq">FAQ</a> •
  <a href="#-기여">기여</a>
</p>

---

## ✨ 무엇을 하는 도구인가요?

5가지 AI 코딩 방법론을 **하나의 조화로운 워크플로우**로 통합합니다:

| 악기 | 도구 | 역할 |
|---|---|---|
| 🎼 **지휘자** | **SDD** (Spec-Driven Development) | 전체 7단계 흐름 통제 |
| 🎻 1st Violin | **Karpathy 4원칙** | 코드 품질 강제 |
| 🎹 Piano | **grill-me** | 모호함 제거, 명확화 |
| 🥁 Percussion | **Harness Engineering** | 검증 기준 설계 |
| 🎺 Brass | **Handoff** | 작업 인계 |

→ **던지면 끝**: Claude Code에 패키지를 던지면 AI가 인터뷰로 상황을 파악하고 자율 통합합니다.

---

## 🚀 빠른 시작 (3단계)

### 1️⃣ 클론 후 프로젝트에 복사
```bash
# 레포 클론
git clone https://github.com/hongdosan/hongdosan-spec-driven-orchestra.git

# 메서드 파일을 본인 프로젝트에 복사
cp hongdosan-spec-driven-orchestra/symphony/*.md /path/to/your/project/
cd /path/to/your/project/
```

### 2️⃣ Git 안전망 (권장)
```bash
git checkout -b feat/spec-driven-orchestra
git add *.md
git commit -m "docs: Spec-Driven Orchestra 패키지 추가"
```

### 3️⃣ Claude Code에 던지기
```bash
claude
```

다음 메시지 전달:

```
AI-INTERVIEW.md를 읽고 인터뷰부터 시작해주세요.
인터뷰 완료 후 결정된 모드로 자율 진행 부탁드립니다.
```

→ AI가 5-10분 인터뷰 후 적합한 모드로 자율 통합합니다.

---

## 🎯 어떤 프로젝트에 적용 가능한가요?

### ✅ 적용 가능

| 유형 | 설명 | 모드 |
|---|---|---|
| 🌱 **신규 프로젝트** | 이제 막 시작, 코드 0% | `MODE_GREENFIELD` |
| 🌿 **초기 진행** | 1-2주 작업, 10-30% | `MODE_EARLY` |
| 🔨 **리팩토링 TF** | 기존 코드 싹 갈아엎기 | `MODE_REBUILD` |

### ❌ 적용 불가

| 유형 | 이유 |
|---|---|
| 🚫 **운영 중 서비스** | 사용자/데이터 영향 위험 → 자동 차단 |

> 💡 **운영 프로젝트 자동 차단**: 인터뷰 단계에서 운영 시그널(Dockerfile.prod, 배포 설정 등) 감지 시 적용을 거부하여 운영 환경을 보호합니다.

---

## 🎭 동작 흐름

```
┌────────────────────────────────────────────────┐
│                                                │
│  사용자: "AI-INTERVIEW.md 읽고 시작"            │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 자동 스캔 (10-30초)                        │
│      디렉터리, 코드, Git, 운영 시그널            │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 인터뷰 5-7개 질문 (5-10분)                 │
│      각 질문에 AI 추천 답변 포함                 │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 모드 결정 + 1회 승인 요청                   │
│      GREENFIELD / EARLY / REBUILD / BLOCK     │
│                                                │
│              ↓                                 │
│                                                │
│  AI: 자율 진행 (10-30분)                        │
│      모드별 맞춤 통합 자동 수행                  │
│                                                │
│              ↓                                 │
│                                                │
│  사용자: 검증 (Day 0/7/30)                      │
│                                                │
└────────────────────────────────────────────────┘
```

---

## 📦 패키지 구성

```
hongdosan-spec-driven-orchestra/
├── README.md                    # 영문 메인
├── README.ko.md                 # 이 파일 (한국어)
├── LICENSE                      # MIT
│
└── symphony/                    # 메서드 본체
    ├── README.md                # 패키지 안내
    ├── AI-INTERVIEW.md          # 🎤 인터뷰 진행 (시작점)
    ├── AI-EXECUTION.md          # 🛠️ 모드별 실행 지시
    ├── ORCHESTRA-GUIDE.md       # 🎼 5중주 가이드
    └── INTEGRATION-CHECKLIST.md # ✅ 검증 체크리스트
```

### 각 파일의 역할

| 파일 | 누가 읽나 | 언제 |
|---|---|---|
| `README.md` | 사람 | 처음 |
| `symphony/AI-INTERVIEW.md` | AI | 통합 시작 시 |
| `symphony/AI-EXECUTION.md` | AI | 인터뷰 후 |
| `symphony/ORCHESTRA-GUIDE.md` | 사람 + AI | 사용 중 |
| `symphony/INTEGRATION-CHECKLIST.md` | 사람 | Day 0/7/30 검증 |

---

## 🎼 오케스트라 구성

### 7단계 SDD 흐름 (표준)

```
1. Specify    🎼  무엇을 & 왜
   ↓
2. Clarify    🎹  모호함 제거 (grill-me)
   ↓
3. Plan       🎼  어떻게 (기술 선택)
   ↓
4. Tasks      🎼  분할 (30분-2시간 단위)
   ↓
5. Harness    🥁  검증 기준 설계
   ↓
6. Implement  🎻  Karpathy 4원칙
   ↓
7. Handoff    🎺  컨텍스트 보존
```

### 9단계 흐름 (리팩토링 모드)

```
0. Archaeology 🪕  기존 코드 분석     ← 추가
1-5. [표준]
5b. Regression 🥁🪕 기존 동작 보장   ← 추가
6. Implement   🎻🎷 Karpathy + 마이그레이션
7. Handoff
```

### 작업 분류

| 분류 | 대상 | 단계 |
|---|---|---|
| **Full SDD** | 새 기능, 큰 리팩토링 | 1~7 모두 (또는 0~7+5b) |
| **Mini SDD** | 작은 기능, 버그 | 1, 6, 7만 |
| **No SDD** | 1줄 수정, 오타 | Karpathy 4원칙만 |

---

## 🎵 통합 후 생기는 것

### 공통 자산 (모든 모드)

```
프로젝트 루트/
├── CLAUDE.md                    # AI 진입점 (자동 로드)
├── DECISION-LOG.md              # 모든 결정 추적
├── INTEGRATION-REPORT.md        # 통합 결과 리포트
├── INTERVIEW-RESULT.md          # 인터뷰 기록
│
├── .claude/skills/              # 5개 AI Skill
│   ├── grill-me/                # 🎹 명확화
│   ├── sdd-conductor/           # 🎼 지휘자
│   ├── karpathy-enforcer/       # 🎻 4원칙 강제
│   ├── harness-builder/         # 🥁 검증 설계
│   └── handoff-writer/          # 🎺 인계 작성
│
└── sdd/                         # 🎼 SDD 중심 디렉터리
    ├── CONSTITUTION.md          # 프로젝트 헌법
    ├── ORCHESTRA.md             # 5중주 가이드 사본
    ├── README.md                # SDD 안내
    ├── templates/               # 단계별 템플릿
    └── features/                # 기능별 작업물 (F001, F002, ...)
```

### 모드별 추가

#### 🌱 MODE_GREENFIELD
- `sdd/templates/` 7개 (01~07)
- 첫 SDD: `F000-bootstrap`

#### 🌿 MODE_EARLY
- `sdd/templates/` 7개
- `archive/` (기존 자산 백업, 있다면)
- 첫 SDD: `F000-integration`

#### 🔨 MODE_REBUILD
- `sdd/templates/` 9개 (00, 01~07, 05b 추가)
- `archive/legacy/` (기존 전체 백업)
- 추가 Skill 2개 (`code-archaeologist`, `migration-strategist`)
- 첫 SDD: `F000-rebuild-plan`

---

## 🌟 핵심 특징

### 🤖 AI 자율 진행
- 인터뷰 후 1회 승인만 (이후 자율)
- 토큰/시간 무제한
- 모든 결정 자동 기록

### 🔍 인터뷰 기반 적응
- 5-7개 질문으로 상황 파악
- 자동 스캔으로 추측 보조
- 모드 자동 결정

### 🛡️ 안전장치
- **운영 프로젝트 자동 차단**
- 기존 자산 archive 백업
- 글로벌 설정 보호
- 언제든 Git 롤백

### 📝 추적 가능성
- DECISION-LOG.md 자동 기록
- 각 문서마다 Decision Log 섹션
- 인터뷰 결과 보존

### 🎼 조화로운 통합
- SDD를 지휘자로
- 5가지 도구의 역할 명확
- 도구 간 충돌 방지

---

## 📚 통합되는 원본 자료

이 패키지가 정신을 흡수한 5가지:

| 도구 | 출처 | 라이선스 |
|---|---|---|
| **Spec Kit** (SDD) | [github/spec-kit](https://github.com/github/spec-kit) | MIT |
| **Karpathy Guidelines** | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | MIT |
| **grill-me Skill** | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT |
| **Harness Engineering** | 커뮤니티 방법론 | - |
| **Handoff Pattern** | 커뮤니티 방법론 | - |

---

## ❓ FAQ

<details>
<summary><b>Q: 어떤 모드가 적합한지 모르겠어요</b></summary>

그냥 인터뷰를 시작하세요. AI가 디렉터리 스캔하면서 추측해주고, 본인이 답변하면서 정확한 모드를 결정합니다.
</details>

<details>
<summary><b>Q: 인터뷰가 부담스러워요</b></summary>

5-7개 질문이며, 각 질문에 **AI 추천 답변이 함께 제공**됩니다. "yes"만 눌러도 진행 가능합니다.
</details>

<details>
<summary><b>Q: 운영 프로젝트인데 적용하고 싶어요</b></summary>

본 패키지는 **적합하지 않습니다**. 운영 프로젝트는 사용자/데이터 영향 위험이 있어, 인터뷰 단계에서 자동 차단됩니다.

대안:
- 운영 영향 없는 feature branch에서 실험
- 새 기능 1개부터 점진 도입
- 팀 합의 후 확대
</details>

<details>
<summary><b>Q: 통합 도중 멈추고 싶으면?</b></summary>

Git으로 즉시 롤백:
```bash
git reset --hard HEAD~1
```

또는 `archive/`에서 복원 (있다면):
```bash
cp -r archive/legacy/* ./
```

자세한 롤백 가이드는 `symphony/INTEGRATION-CHECKLIST.md` 참조.
</details>

<details>
<summary><b>Q: 매번 SDD 7단계를 모두 거쳐야 하나요?</b></summary>

아니오. 작업 크기에 비례:
- 1줄 수정 → No SDD (Karpathy만)
- 작은 기능 → Mini SDD (01, 06, 07만)
- 큰 기능 → Full SDD (7단계 모두)
</details>

<details>
<summary><b>Q: Claude Code 외 다른 AI 도구에서도 쓸 수 있나요?</b></summary>

현재는 Claude Code에 최적화되어 있습니다. 다음을 활용하기 때문:
- `CLAUDE.md` 자동 로드
- `.claude/skills/` Skill 시스템

다른 AI 도구(Cursor, Cline 등) 지원은 추후 고려.
</details>

<details>
<summary><b>Q: 팀에 도입하고 싶어요</b></summary>

권장 순서:
1. 본인 프로젝트에 1회 적용
2. 1주~1개월 사용 후 효과 검증
3. 팀에 시연
4. 동료 1-2명과 함께 도입
5. 점진 확대

`CLAUDE.md`가 자동 로드되므로 팀원 각자 Claude Code 사용 시 자동 적용됩니다.
</details>

<details>
<summary><b>Q: 학습 곡선이 어떻게 되나요?</b></summary>

- **첫 주**: 약간의 부담, 주로 Mini SDD
- **첫 달**: Full SDD 2-3회, 익숙해짐
- **그 후**: 자연스러운 흐름, 5중주 메타포가 직관적
</details>

---

## 📊 적용 후 변화 (예상)

### 정성적 변화
- ✅ AI 응답의 일관성 향상
- ✅ 코드 변경의 명확성 향상
- ✅ 결정 추적 가능성 향상
- ✅ 핸드오프 품질 향상
- ✅ 학습 효과 (워크플로우 자체가 학습)

### 정량적 측정
- DECISION-LOG.md 항목 수
- SDD 사이클 수
- grill-me 발동 횟수
- Karpathy 4원칙 위배 사례

→ `symphony/INTEGRATION-CHECKLIST.md`에서 Day 0/7/30 시점에 측정

---

## 🆘 문제 해결

### 인터뷰 단계에서 막혔어요
→ `symphony/AI-INTERVIEW.md`의 "인터뷰 시 자주 발생하는 상황 가이드" 참조

### 실행 중 오류
→ `symphony/AI-EXECUTION.md`의 해당 모드 섹션 재확인

### 5중주 이해가 안 가요
→ `symphony/ORCHESTRA-GUIDE.md` 정독

### 적용 후 검증 방법
→ `symphony/INTEGRATION-CHECKLIST.md` Day 0 체크리스트

---

## 🛣️ 로드맵

### 최근 출시 (v2)
- ✅ AI 인터뷰 기반 모드 결정
- ✅ 3가지 모드 (GREENFIELD/EARLY/REBUILD)
- ✅ 운영 프로젝트 자동 차단
- ✅ 5 + 2 특화 Skill
- ✅ archive 백업 전략
- ✅ 이중 언어 문서 (영문 + 한국어)

### 진행 중
- 🚧 사례 모음
- 🚧 Cursor 적용 가이드
- 🚧 Cline 적용 가이드

### 계획
- 📋 추가 언어 문서 (중문, 일문)
- 📋 비디오 튜토리얼
- 📋 추가 모드 (예: `MODE_MICROSERVICE`)
- 📋 정량 측정 도구
- 📋 팀 도입 플레이북

### 장기
- 🌟 웹 기반 인터뷰 도구
- 🌟 자동화된 효과 측정 대시보드
- 🌟 커뮤니티 사례 모음

---

## 🤝 기여

피드백, 이슈, PR 환영합니다.

### 가장 환영하는 기여
1. **사례 공유** — Spec-Driven Orchestra 적용 후 결과 공유 ⭐
2. **자료 큐레이션** — 관련 도구/방법론 PR
3. **다른 도구 적용** — Cursor/Cline/Aider 가이드
4. **번역** — 다국어 지원
5. **튜토리얼** — 신규 사용자 위한 콘텐츠

### 기여 방법
1. **Issue로 의견 공유**
2. **Fork** 후 작업
3. **feature 브랜치 생성** (`git checkout -b feat/amazing-addition`)
4. **변경사항 커밋** (`git commit -m 'feat: amazing addition'`)
5. **푸시** (`git push origin feat/amazing-addition`)
6. **Pull Request 오픈**

### 가이드라인
- 친절하고 건설적으로
- 제출 전 테스트
- 변경사항 문서화
- 기존 스타일 따르기

---

## 📜 라이선스

MIT License - [LICENSE](./LICENSE) 파일 참조.

**TL;DR**: 자유롭게 사용, 수정, 배포 가능. 출처 명시만 유지.

---

## 🙏 감사

이 프로젝트는 다음의 거인들 어깨 위에 서있습니다:

- **Andrej Karpathy** ([@karpathy](https://x.com/karpathy)) - 4원칙
- **GitHub Spec Kit** 팀
- **Matt Pocock** ([@mpocock1](https://x.com/mpocock1)) - grill-me
- **Anthropic** ([@AnthropicAI](https://x.com/AnthropicAI)) - Claude Code
- **전체 AI 코딩 커뮤니티**

조기 도입자분들의 피드백에 특별히 감사드립니다.

---

## 🌟 Star History

<p align="center">
  <a href="https://star-history.com/#hongdosan/hongdosan-spec-driven-orchestra">
    <img src="https://api.star-history.com/svg?repos=hongdosan/hongdosan-spec-driven-orchestra&type=Date" alt="Star History Chart" />
  </a>
</p>

---

## 📬 연락

- 💬 [Discussions](https://github.com/hongdosan/hongdosan-spec-driven-orchestra/discussions) — Q&A, 아이디어
- 🐛 [Issues](https://github.com/hongdosan/hongdosan-spec-driven-orchestra/issues) — 버그, 요청
- 👤 제작자: [@hongdosan](https://github.com/hongdosan)

---

## 🎯 도움이 되셨다면

⭐ **레포에 별을 눌러주세요** - 도움 되셨다면!
🍴 **Fork** - 팀에 맞게 커스터마이징
📢 **공유** - 동료 개발자에게
💡 **기여** - 함께 발전시켜요

함께 AI 코딩의 미래를 오케스트레이션해봅시다.

---

## 🎯 한 줄 요약

> **3개 파일을 프로젝트에 복사하고 Claude Code에 "AI-INTERVIEW.md 읽고 시작"이라고 던지세요. AI가 인터뷰로 상황을 파악하고, 적합한 모드(신규/초기/리팩토링)로 자율 통합합니다. 운영 프로젝트는 자동 차단됩니다.**

---

<p align="center">
  <i>Created with 🎼 by <a href="https://github.com/hongdosan">@hongdosan</a></i>
</p>

<p align="center">
  <sub>유용하셨다면 ⭐ 별을 눌러주세요!</sub>
</p>
