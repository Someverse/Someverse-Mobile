.PHONY: clean build watch test help run-dev run-prod run-test

# 도움말 표시
help:
	@echo "사용 가능한 명령어:"
	@echo "  make clean      - Flutter 프로젝트 클린 및 의존성 재설치"
	@echo "  make build       - build_runner로 코드 생성"
	@echo "  make watch       - 파일 변경 시 자동으로 코드 생성"
	@echo "  make test        - 테스트 실행"
	@echo "  make run-dev     - 개발 환경으로 실행 (기본값)"
	@echo "  make run-prod    - 프로덕션 환경으로 실행"
	@echo "  make run-test    - 테스트 환경으로 실행"

# Flutter 프로젝트 클린 및 의존성 재설치
clean:
	fvm flutter clean
	fvm flutter pub get

# build_runner로 코드 생성
build:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

# 파일 변경 시 자동으로 코드 생성
watch:
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

# 테스트 실행
test:
	fvm flutter test

# 개발 환경으로 실행 (기본값)
# 사용 예: make run-dev KAKAO_NATIVE_KEY=xxx KAKAO_JS_KEY=xxx
run-dev:
	fvm flutter run \
		--dart-define=ENV=dev \
		--dart-define=KAKAO_NATIVE_APP_KEY=$${KAKAO_NATIVE_KEY} \
		--dart-define=KAKAO_JAVASCRIPT_APP_KEY=$${KAKAO_JS_KEY}

# 프로덕션 환경으로 실행
run-prod:
	fvm flutter run \
		--dart-define=ENV=prod \
		--dart-define=KAKAO_NATIVE_APP_KEY=$${KAKAO_NATIVE_KEY} \
		--dart-define=KAKAO_JAVASCRIPT_APP_KEY=$${KAKAO_JS_KEY}

# 테스트 환경으로 실행
run-test:
	fvm flutter run \
		--dart-define=ENV=test \
		--dart-define=KAKAO_NATIVE_APP_KEY=$${KAKAO_NATIVE_KEY} \
		--dart-define=KAKAO_JAVASCRIPT_APP_KEY=$${KAKAO_JS_KEY}
