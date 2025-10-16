import 'package:someverse/features/auth/domain/entities/auth_token.dart';
import 'package:someverse/features/auth/domain/entities/user.dart';
import 'package:someverse/features/auth/domain/repositories/auth_repository.dart';

/// 카카오 소셜 로그인 UseCase
///
/// 카카오 OAuth를 통해 로그인하고 인증 토큰과 사용자 정보를 반환합니다.
class SignInWithKakao {
  final AuthRepository _authRepository;

  SignInWithKakao(this._authRepository);

  /// 카카오 로그인을 실행합니다.
  ///
  /// Returns:
  /// - 성공 시: (AuthToken, User) 튜플
  /// - 실패 시: Exception throw
  Future<(AuthToken, User)> call() async {
    final (token, user) = await _authRepository.signInWithKakao();
    await _authRepository.saveToken(token);
    return (token, user);
  }
}
