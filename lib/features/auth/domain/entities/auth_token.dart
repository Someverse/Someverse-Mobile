import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token.freezed.dart';

/// OAuth 인증 토큰을 나타내는 도메인 엔티티
///
/// 로그인 후 받은 access token과 refresh token을 관리합니다.
@freezed
class AuthToken with _$AuthToken {
  const AuthToken._();

  const factory AuthToken({
    /// Access Token (API 요청 시 사용)
    required String accessToken,

    /// Refresh Token (Access Token 갱신 시 사용)
    required String refreshToken,

    /// Token 타입 (보통 'Bearer')
    @Default('Bearer') String tokenType,

    /// Access Token 만료 시간 (초 단위)
    int? expiresIn,

    /// Token 발급 시간
    DateTime? issuedAt,
  }) = _AuthToken;

  /// Access Token이 만료되었는지 확인합니다.
  bool get isExpired {
    if (expiresIn == null || issuedAt == null) {
      return false;
    }
    final expiryTime = issuedAt!.add(Duration(seconds: expiresIn!));
    return DateTime.now().isAfter(expiryTime);
  }

  /// Access Token이 곧 만료될 예정인지 확인합니다 (5분 이내).
  bool get willExpireSoon {
    if (expiresIn == null || issuedAt == null) {
      return false;
    }
    final expiryTime = issuedAt!.add(Duration(seconds: expiresIn!));
    final fiveMinutesFromNow = DateTime.now().add(const Duration(minutes: 5));
    return fiveMinutesFromNow.isAfter(expiryTime);
  }

  /// Authorization 헤더 값을 반환합니다.
  String get authorizationHeader => '$tokenType $accessToken';
}

