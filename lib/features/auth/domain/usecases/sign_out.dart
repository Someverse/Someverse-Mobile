import 'package:someverse/features/auth/domain/repositories/auth_repository.dart';

/// 로그아웃 UseCase
///
/// 현재 사용자를 로그아웃하고 저장된 인증 정보를 삭제합니다.
class SignOut {
  final AuthRepository _authRepository;

  SignOut(this._authRepository);

  /// 로그아웃을 실행합니다.
  Future<void> call() async {
    await _authRepository.signOut();
    await _authRepository.deleteToken();
  }
}