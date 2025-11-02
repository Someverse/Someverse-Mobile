import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:someverse/core/providers/dio_providers.dart';
import 'package:someverse/core/services/kakao_auth_service.dart';
import 'package:someverse/features/auth/data/datasources/auth_datasource.dart';
import 'package:someverse/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:someverse/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:someverse/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:someverse/features/auth/domain/entities/auth_token.dart';
import 'package:someverse/features/auth/domain/entities/user.dart';
import 'package:someverse/features/auth/domain/repositories/auth_repository.dart';
import 'package:someverse/features/auth/domain/usecases/get_current_user.dart';
import 'package:someverse/features/auth/domain/usecases/sign_in_with_apple.dart';
import 'package:someverse/features/auth/domain/usecases/sign_in_with_kakao.dart';
import 'package:someverse/features/auth/domain/usecases/sign_out.dart';

part 'auth_providers.g.dart';

// ============================================================================
// DataSource Providers
// ============================================================================

/// 환경 설정 읽기 (test, dev, prod)
String _getEnvironment() {
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  return env.toLowerCase();
}

/// Auth DataSource 제공 (환경에 따라 선택)
///
/// - test, dev: AuthLocalDataSource (로컬 저장소 기반)
/// - prod: AuthRemoteDataSource (원격 API 기반)
@riverpod
AuthDataSource authDataSource(Ref ref) {
  final env = _getEnvironment();
  
  // test, dev 환경에서는 로컬 데이터소스 사용
  if (env == 'test' || env == 'dev') {
    final secureStorage = ref.watch(secureStorageProvider);
    return AuthLocalDataSource(secureStorage);
  }
  
  // prod 환경에서는 원격 데이터소스 사용
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSource(dio);
}

/// Auth Remote DataSource 제공 (직접 접근이 필요한 경우)
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSource(dio);
}

/// Auth Local DataSource 제공 (직접 접근이 필요한 경우)
@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthLocalDataSource(secureStorage);
}

// ============================================================================
// Repository Providers
// ============================================================================

/// Auth Repository 제공
@riverpod
AuthRepository authRepository(Ref ref) {
  final authDataSource = ref.watch(authDataSourceProvider);

  return AuthRepositoryImpl(
    authDataSource: authDataSource,
  );
}

// ============================================================================
// UseCase Providers
// ============================================================================

/// 카카오 로그인 UseCase 제공
@riverpod
SignInWithKakao signInWithKakao(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithKakao(repository);
}

/// 애플 로그인 UseCase 제공
@riverpod
SignInWithApple signInWithApple(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithApple(repository);
}

/// 로그아웃 UseCase 제공
@riverpod
SignOut signOut(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignOut(repository);
}

/// 현재 사용자 조회 UseCase 제공
@riverpod
GetCurrentUser getCurrentUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUser(repository);
}

// ============================================================================
// State Providers
// ============================================================================

/// 현재 인증 토큰 상태
@riverpod
class CurrentAuthToken extends _$CurrentAuthToken {
  @override
  Future<AuthToken?> build() async {
    final repository = ref.watch(authRepositoryProvider);
    return await repository.getCurrentToken();
  }

  /// 토큰 갱신
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return await repository.getCurrentToken();
    });
  }
}

/// 현재 사용자 상태
@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  Future<User?> build() async {
    final getCurrentUserUseCase = ref.watch(getCurrentUserProvider);
    return await getCurrentUserUseCase();
  }

  /// 사용자 정보 갱신
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final getCurrentUserUseCase = ref.read(getCurrentUserProvider);
      return await getCurrentUserUseCase();
    });
  }
}

/// 인증 상태 (로그인 여부)
@riverpod
Future<bool> isAuthenticated(Ref ref) async {
  final repository = ref.watch(authRepositoryProvider);
  return await repository.isSignedIn();
}

// ============================================================================
// Services Providers
// ============================================================================

/// 카카오 인증 서비스 제공
@riverpod
KakaoAuthService kakaoAuthService(Ref ref) {
  return KakaoAuthService();
}

// ============================================================================
// Login State Notifiers (SDK 호출 처리)
// ============================================================================

/// 카카오 로그인 상태 관리
///
/// 카카오 SDK를 통해 인가 코드를 받아서 UseCase에 전달합니다.
@riverpod
class KakaoLogin extends _$KakaoLogin {
  @override
  FutureOr<void> build() => null;

  /// 카카오 로그인 실행
  Future<void> login() async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      // 카카오 인증 서비스를 통해 인가 코드 받기
      final kakaoAuthService = ref.read(kakaoAuthServiceProvider);
      final authorizationCode = await kakaoAuthService.getAuthorizationCode();

      // 인가 코드를 사용하여 로그인 처리
      final signInWithKakao = ref.read(signInWithKakaoProvider);
      await signInWithKakao(authorizationCode);
      
      // 로그인 성공 시 상태 업데이트
      ref.invalidate(currentUserProvider);
      ref.invalidate(currentAuthTokenProvider);
      ref.invalidate(isAuthenticatedProvider);
      
      return;
    });
  }
}

/// 애플 로그인 상태 관리
///
/// 애플 SDK를 통해 identity token과 인가 코드를 받아서 UseCase에 전달합니다.
@riverpod
class AppleLogin extends _$AppleLogin {
  @override
  FutureOr<void> build() => null;

  /// 애플 로그인 실행
  Future<void> login() async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      // TODO: 실제 애플 SDK 연동
      // 예시:
      // final result = await SignInWithApple.getAppleIDCredential();
      // final identityToken = result.identityToken;
      // final authorizationCode = result.authorizationCode;
      const identityToken = 'apple_identity_token_from_sdk';
      const authorizationCode = 'apple_authorization_code_from_sdk';

      final signInWithApple = ref.read(signInWithAppleProvider);
      await signInWithApple(
        identityToken,
        authorizationCode,
      );
      
      // 로그인 성공 시 상태 업데이트
      ref.invalidate(currentUserProvider);
      ref.invalidate(currentAuthTokenProvider);
      ref.invalidate(isAuthenticatedProvider);
      
      return;
    });
  }
}