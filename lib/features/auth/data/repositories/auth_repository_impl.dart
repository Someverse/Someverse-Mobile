import 'package:someverse/features/auth/data/datasources/auth_datasource.dart';
import 'package:someverse/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:someverse/features/auth/data/models/auth_token_model.dart';
import 'package:someverse/features/auth/domain/entities/auth_token.dart';
import 'package:someverse/features/auth/domain/entities/user.dart';
import 'package:someverse/features/auth/domain/repositories/auth_repository.dart';

/// AuthRepository 구현체
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  @override
  Future<(AuthToken, User)> signInWithKakao(String authorizationCode) async {
    // 인자를 그대로 AuthDataSource에 전달 (로컬/원격 모두 동일한 인터페이스)
    // - AuthLocalDataSource: 인가 코드 검증 후 mock 데이터 생성 및 저장
    // - AuthRemoteDataSource: 인가 코드를 서버에 전달하여 서버와 통신
    final (tokenModel, userModel) =
        await _authDataSource.signInWithKakao(authorizationCode);

    return (tokenModel.toEntity(), userModel.toEntity());
  }

  @override
  Future<(AuthToken, User)> signInWithApple(
    String identityToken,
    String authorizationCode,
  ) async {
    // 인자를 그대로 AuthDataSource에 전달 (로컬/원격 모두 동일한 인터페이스)
    // - AuthLocalDataSource: 토큰 검증 후 mock 데이터 생성 및 저장
    // - AuthRemoteDataSource: 서버와 통신
    final (tokenModel, userModel) = await _authDataSource.signInWithApple(
      identityToken,
      authorizationCode,
    );

    return (tokenModel.toEntity(), userModel.toEntity());
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  @override
  Future<AuthToken> refreshAccessToken(String refreshToken) async {
    final tokenModel = await _authDataSource.refreshAccessToken(refreshToken);
    return tokenModel.toEntity();
  }

  @override
  Future<AuthToken?> getCurrentToken() async {
    // AuthLocalDataSource인 경우에만 직접 조회 가능
    final localDataSource = _authDataSource;
    if (localDataSource is AuthLocalDataSource) {
      final tokenModel = await localDataSource.getToken();
      return tokenModel?.toEntity();
    }
    
    // AuthRemoteDataSource인 경우, getCurrentUser로 간접 확인
    try {
      final user = await getCurrentUser();
      // 사용자가 있으면 토큰도 있다고 간주 (실제로는 토큰 조회 불가)
      return user != null ? null : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveToken(AuthToken token) async {
    // AuthLocalDataSource인 경우에만 직접 저장 가능
    final localDataSource = _authDataSource;
    if (localDataSource is AuthLocalDataSource) {
      final tokenModel = AuthTokenModel.fromEntity(token);
      await localDataSource.saveToken(tokenModel);
    }
    // AuthRemoteDataSource인 경우는 저장 불가 (읽기 전용)
  }

  @override
  Future<void> deleteToken() async {
    // AuthLocalDataSource인 경우에만 직접 삭제 가능
    final localDataSource = _authDataSource;
    if (localDataSource is AuthLocalDataSource) {
      await localDataSource.deleteToken();
    }
    // AuthRemoteDataSource인 경우는 삭제 불가
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userModel = await _authDataSource.getCurrentUser();
      return userModel.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    final token = await getCurrentToken();
    return token != null && !token.isExpired;
  }
}
