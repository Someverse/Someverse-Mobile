# Someverse Development Guide

## 프로젝트 개요
프로젝트의 전반적인 개요, 기술 스택 및 주요 기능에 대한 내용은 [prd.mdc](.cursor/rules/prd.mdc)를 참조하세요.

## 프로젝트 구조

```bash
lib/
├── core/                   # 앱 전반에서 사용되는 유틸리티
│   ├── config/            # 앱 설정 (환경 변수, API 엔드포인트 등)
│   ├── constants/         # 상수 (색상, 텍스트 스타일, 문자열 등)
│   ├── di/                # 의존성 주입 설정 (get_it, injectable)
│   ├── router/            # 라우팅 설정 (go_router)
│   ├── themes/            # 테마 관련 파일
│   ├── utils/             # 공통 유틸리티 함수
│   └── widgets/           # 앱 전반에서 사용되는 공통 위젯
│
├── features/              # 기능별로 분리된 모듈
│   ├── auth/             # 인증 기능 (로그인/회원가입)
│   │   ├── data/
│   │   │   ├── datasources/    # API 호출, 로컬 저장소 접근
│   │   │   ├── models/         # JSON 직렬화 모델 (freezed)
│   │   │   └── repositories/   # Repository 구현체
│   │   ├── domain/
│   │   │   ├── entities/       # 비즈니스 엔티티
│   │   │   ├── repositories/   # Repository 인터페이스
│   │   │   └── usecases/       # 비즈니스 로직/유스케이스
│   │   └── presentation/
│   │       ├── pages/          # View
│   │       ├── providers/      # Riverpod Provider 정의
│   │       └── widgets/        # 해당 기능 전용 위젯
│   │
│   ├── home/             # 홈 화면
│   ├── onboarding/       # 온보딩 (취향 선택, 프로필 입력)
│   ├── my_page/          # 마이페이지
│   ├── feed/             # 피드
│   ├── chat/             # 채팅
│   └── matching/         # 매칭
│
└── main.dart            # 앱 진입점
```

### 아키텍처 원칙

#### Clean Architecture 레이어
1. **Presentation Layer** (`presentation/`)
   - UI 위젯 및 상태 관리
   - Riverpod 3.0을 사용한 Provider 패턴
   - Notifier/AsyncNotifier 기반 상태 관리 (코드 생성 활용)

2. **Domain Layer** (`domain/`)
   - 비즈니스 로직 및 엔티티
   - Repository 인터페이스 정의
   - 플랫폼/프레임워크 독립적

3. **Data Layer** (`data/`)
   - Repository 구현
   - 데이터 소스 (Remote API, Local Storage)
   - 모델 (JSON 직렬화)

#### 의존성 흐름
```
Presentation → Domain ← Data
```
- Presentation과 Data는 Domain에 의존
- Domain은 어떤 레이어에도 의존하지 않음

## 코딩 스타일 및 앱 아키텍처
Flutter/Dart 코딩 스타일, 베스트 프랙티스, 앱 아키텍처 패턴에 대한 내용은 [flutter-guide.mdc](.cursor/rules/flutter-guide.mdc)를 참조하세요.

주요 내용:
- Flutter 베스트 프랙티스
- 상태 관리 (Riverpod)
- 라우팅 (go_router)
- 테마 및 디자인 시스템
- UI/UX 가이드라인
- 성능 최적화

## Dart 문법 및 컨벤션
Dart 언어의 네이밍 컨벤션, 타입 시스템, 코드 스타일에 대한 내용은 [effective-dart.mdc](.cursor/rules/effective-dart.mdc)를 참조하세요.

주요 내용:
- 네이밍 컨벤션 (camelCase, PascalCase, snake_case)
- 타입 어노테이션 가이드
- null safety 활용
- 문서화 규칙
- 코드 구조화

## 테스트
Mocktail을 사용한 테스트 작성 가이드는 [mocktail.mdc](.cursor/rules/mocktail.mdc)를 참조하세요.

### 테스트 구조
```bash
test/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       └── providers/
│   └── ...
├── shared/
└── widget_test.dart
```

### 테스트 유형
1. **Unit Tests**: 비즈니스 로직, 유스케이스, Repository
2. **Widget Tests**: UI 컴포넌트
3. **Integration Tests**: End-to-end 사용자 플로우

## 개발 워크플로우

### 1. 새 기능 추가 시
```bash
lib/features/[feature_name]/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

### 2. 코드 생성
```bash
# Riverpod, Freezed, json_serializable 등의 코드 생성
# 개발 중에는 watch 모드 사용 권장
dart run build_runner watch --delete-conflicting-outputs

# 또는 일회성 빌드
dart run build_runner build --delete-conflicting-outputs
```

### 3. 코드 포맷팅
```bash
dart format lib/ test/
```

### 4. 테스트 실행
```bash
flutter test
```

## 주요 패키지

### 핵심 패키지
- `flutter_riverpod`: 상태 관리 및 의존성 주입 (Riverpod 3.0)
- `riverpod_annotation`: Riverpod 코드 생성용 어노테이션
- `riverpod_generator`: Riverpod 코드 생성기
- `go_router`: 선언적 라우팅
- `dio`: HTTP 클라이언트
- `freezed`: 불변 모델 생성
- `json_serializable`: JSON 직렬화

### 저장소
- `shared_preferences`: 간단한 key-value 저장
- `flutter_secure_storage`: 민감한 데이터 저장 (토큰 등)

### 개발 도구
- `mocktail`: 테스트용 Mock 생성
- `build_runner`: 코드 생성
- `flutter_lints`: Dart/Flutter 린팅

### API 응답 구조 및 상태 코드
- [api.mdc](.cursor/rules/api.mdc)

## 참고 문서

- [프로젝트 개요 및 기술 스택](.cursor/rules/prd.mdc)
- [Flutter/Dart 개발 가이드](.cursor/rules/flutter-guide.mdc)
- [Effective Dart 규칙](.cursor/rules/effective-dart.mdc)
- [Mocktail 테스트 가이드](.cursor/rules/mocktail.mdc)
- [API 응답 구조 및 상태 코드](.cursor/rules/api.mdc)

