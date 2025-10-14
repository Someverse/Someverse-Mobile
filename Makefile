.PHONY: clean build watch test help

# 도움말 표시
help:
	@echo "사용 가능한 명령어:"
	@echo "  make clean    - Flutter 프로젝트 클린 및 의존성 재설치"
	@echo "  make build    - build_runner로 코드 생성"
	@echo "  make watch    - 파일 변경 시 자동으로 코드 생성"
	@echo "  make test     - 테스트 실행"

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
