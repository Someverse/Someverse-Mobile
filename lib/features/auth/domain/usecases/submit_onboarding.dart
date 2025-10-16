import 'package:someverse/features/auth/domain/entities/user.dart';
import 'package:someverse/features/auth/domain/repositories/onboarding_repository.dart';

/// 온보딩 데이터를 제출하는 UseCase
///
/// 사용자가 입력한 온보딩 정보(닉네임, 성별, 생년월일, 지역, 사진, 취향)를
/// 서버에 제출하고 프로필을 완성합니다.
class SubmitOnboarding {
  final OnboardingRepository _onboardingRepository;

  SubmitOnboarding(this._onboardingRepository);

  /// 온보딩 데이터를 제출합니다.
  ///
  /// Parameters:
  /// - nickname: 닉네임 (한글 2-8자)
  /// - gender: 성별
  /// - birthDate: 생년월일
  /// - activeRegionIds: 활동 지역 ID 목록 (1-2개)
  /// - profileImageUrls: 프로필 이미지 URL 목록 (1-6장)
  /// - preferredMovieCategoryIds: 선호 카테고리 ID 목록 (최대 5개)
  /// - preferredMovieIds: 선호 영화 ID 목록 (최소 5개)
  ///
  /// Returns:
  /// - 업데이트된 사용자 정보
  ///
  /// Throws:
  /// - ValidationException: 입력값이 유효하지 않은 경우
  /// - NetworkException: 네트워크 오류
  Future<User> call({
    required String nickname,
    required Gender gender,
    required DateTime birthDate,
    required List<String> activeRegionIds,
    required List<String> profileImageUrls,
    required List<String> preferredMovieCategoryIds,
    required List<String> preferredMovieIds,
  }) async {
    // 입력값 검증
    _validateInputs(
      nickname: nickname,
      activeRegionIds: activeRegionIds,
      profileImageUrls: profileImageUrls,
      preferredMovieCategoryIds: preferredMovieCategoryIds,
      preferredMovieIds: preferredMovieIds,
    );

    return await _onboardingRepository.submitOnboardingData(
      nickname: nickname,
      gender: gender,
      birthDate: birthDate,
      activeRegionIds: activeRegionIds,
      profileImageUrls: profileImageUrls,
      preferredMovieCategoryIds: preferredMovieCategoryIds,
      preferredMovieIds: preferredMovieIds,
    );
  }

  void _validateInputs({
    required String nickname,
    required List<String> activeRegionIds,
    required List<String> profileImageUrls,
    required List<String> preferredMovieCategoryIds,
    required List<String> preferredMovieIds,
  }) {
    // 닉네임 검증: 한글 2-8자
    if (nickname.isEmpty || nickname.length < 2 || nickname.length > 8) {
      throw ArgumentError('닉네임은 2자 이상 8자 이하여야 합니다.');
    }

    final koreanRegex = RegExp(r'^[가-힣]+$');
    if (!koreanRegex.hasMatch(nickname)) {
      throw ArgumentError('닉네임은 한글만 사용할 수 있습니다.');
    }

    // 활동 지역 검증: 1-2개
    if (activeRegionIds.isEmpty || activeRegionIds.length > 2) {
      throw ArgumentError('활동 지역은 최소 1개, 최대 2개를 선택해야 합니다.');
    }

    // 프로필 사진 검증: 1-6장
    if (profileImageUrls.isEmpty || profileImageUrls.length > 6) {
      throw ArgumentError('프로필 사진은 최소 1장, 최대 6장을 선택해야 합니다.');
    }

    // 영화 카테고리 검증: 최대 5개
    if (preferredMovieCategoryIds.length > 5) {
      throw ArgumentError('영화 카테고리는 최대 5개까지 선택할 수 있습니다.');
    }

    // 영화 작품 검증: 최소 5개
    if (preferredMovieIds.length < 5) {
      throw ArgumentError('영화 작품은 최소 5개를 선택해야 합니다.');
    }
  }
}
