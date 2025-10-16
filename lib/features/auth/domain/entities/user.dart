import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// 사용자를 나타내는 도메인 엔티티
///
/// 이 클래스는 비즈니스 로직에서 사용되는 사용자 정보를 담고 있으며,
/// 데이터 레이어의 모델과는 독립적입니다.
@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    /// 사용자 고유 식별자
    required String id,

    /// 닉네임 (한글 2-8자)
    required String nickname,

    /// 성별
    required Gender gender,

    /// 생년월일
    required DateTime birthDate,

    /// 활동 지역 목록 (최소 1개, 최대 2개)
    required List<String> activeRegions,

    /// 프로필 사진 URL 목록 (최소 1장, 최대 6장)
    required List<String> profileImageUrls,

    /// 선호하는 영화 카테고리 ID 목록 (최대 5개)
    required List<String> preferredMovieCategories,

    /// 선호하는 영화 작품 ID 목록 (최소 5개)
    required List<String> preferredMovies,

    /// 이메일 (소셜 로그인에서 제공)
    String? email,

    /// 전화번호 (선택적)
    String? phoneNumber,

    /// 소셜 로그인 제공자 (kakao, apple 등)
    SocialProvider? socialProvider,

    /// 계정 생성 날짜
    DateTime? createdAt,

    /// 마지막 업데이트 날짜
    DateTime? updatedAt,
  }) = _User;

  /// 온보딩이 완료되었는지 확인합니다.
  bool get isOnboardingComplete {
    return nickname.isNotEmpty &&
        activeRegions.isNotEmpty &&
        profileImageUrls.isNotEmpty &&
        preferredMovieCategories.isNotEmpty &&
        preferredMovies.length >= 5;
  }
}

/// 사용자의 성별을 나타내는 열거형
enum Gender {
  /// 남성
  male,

  /// 여성
  female;

  /// 한글 표시명을 반환합니다.
  String get displayName {
    switch (this) {
      case Gender.male:
        return '남성';
      case Gender.female:
        return '여성';
    }
  }

  /// 문자열에서 Gender로 변환합니다.
  static Gender fromString(String value) {
    switch (value.toLowerCase()) {
      case 'male':
      case '남성':
        return Gender.male;
      case 'female':
      case '여성':
        return Gender.female;
      default:
        throw ArgumentError('Invalid gender value: $value');
    }
  }
}

/// 소셜 로그인 제공자를 나타내는 열거형
enum SocialProvider {
  /// 카카오 로그인
  kakao,

  /// 애플 로그인
  apple,

  /// 네이버 로그인
  naver;

  /// 표시명을 반환합니다.
  String get displayName {
    switch (this) {
      case SocialProvider.kakao:
        return '카카오';
      case SocialProvider.apple:
        return 'Apple';
      case SocialProvider.naver:
        return 'Naver';
    }
  }

  /// 문자열에서 SocialProvider로 변환합니다.
  static SocialProvider fromString(String value) {
    switch (value.toLowerCase()) {
      case 'kakao':
        return SocialProvider.kakao;
      case 'apple':
        return SocialProvider.apple;
      case 'naver':
        return SocialProvider.naver;
      default:
        throw ArgumentError('Invalid social provider value: $value');
    }
  }
}