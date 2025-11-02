import 'package:someverse/features/auth/domain/entities/auth_token.dart';
import 'package:someverse/features/auth/domain/entities/user.dart';
import 'package:someverse/features/auth/domain/repositories/auth_repository.dart';

/// 애플 소셜 로그인 UseCase
///
/// 애플 OAuth를 통해 로그인하고 인증 토큰과 사용자 정보를 반환합니다.
class SignInWithApple {
  final AuthRepository _authRepository;

  SignInWithApple(this._authRepository);

  /// 애플 로그인을 실행합니다.
  ///
  /// Parameters:
  /// - identityToken: 애플 SDK에서 받은 identity token
  /// - authorizationCode: 애플 SDK에서 받은 인가 코드
  ///
  /// Returns:
  /// - 성공 시: (AuthToken, User) 튜플
  /// - 실패 시: Exception throw
  Future<(AuthToken, User)> call(
    String identityToken,
    String authorizationCode,
  ) async {
    final (token, user) = await _authRepository.signInWithApple(
      identityToken,
      authorizationCode,
    );
    await _authRepository.saveToken(token);
    return (token, user);
  }
}
