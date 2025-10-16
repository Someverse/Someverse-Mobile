import 'package:someverse/features/auth/domain/entities/user.dart';
import 'package:someverse/features/auth/domain/repositories/auth_repository.dart';

/// 현재 로그인된 사용자 정보를 가져오는 UseCase
class GetCurrentUser {
  final AuthRepository _authRepository;

  GetCurrentUser(this._authRepository);

  /// 현재 사용자 정보를 가져옵니다.
  ///
  /// Returns:
  /// - 로그인되어 있으면 User, 아니면 null
  Future<User?> call() async {
    return await _authRepository.getCurrentUser();
  }
}
