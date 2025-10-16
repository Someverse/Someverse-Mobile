import 'package:someverse/features/auth/domain/repositories/onboarding_repository.dart';

/// 닉네임 중복 확인 UseCase
///
/// 입력한 닉네임이 사용 가능한지 서버에 확인합니다.
class CheckNicknameAvailability {
  final OnboardingRepository _onboardingRepository;

  CheckNicknameAvailability(this._onboardingRepository);

  /// 닉네임 사용 가능 여부를 확인합니다.
  ///
  /// Parameters:
  /// - nickname: 확인할 닉네임
  ///
  /// Returns:
  /// - 사용 가능하면 true, 중복이면 false
  ///
  /// Throws:
  /// - ArgumentError: 닉네임 형식이 올바르지 않은 경우
  Future<bool> call(String nickname) async {
    // 닉네임 형식 검증
    if (nickname.isEmpty || nickname.length < 2 || nickname.length > 8) {
      throw ArgumentError('닉네임은 2자 이상 8자 이하여야 합니다.');
    }

    final koreanRegex = RegExp(r'^[가-힣]+$');
    if (!koreanRegex.hasMatch(nickname)) {
      throw ArgumentError('닉네임은 한글만 사용할 수 있습니다.');
    }

    return await _onboardingRepository.checkNicknameAvailability(nickname);
  }
}
