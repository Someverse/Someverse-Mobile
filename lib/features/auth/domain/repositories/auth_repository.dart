import 'package:someverse/features/auth/domain/entities/auth_token.dart';
import 'package:someverse/features/auth/domain/entities/user.dart';

/// 인증 관련 비즈니스 로직을 처리하는 Repository 인터페이스
///
/// 소셜 로그인, 로그아웃, 토큰 관리 등의 기능을 제공합니다.
abstract class AuthRepository {
  /// 카카오 소셜 로그인을 수행합니다.
  ///
  /// Returns:
  /// - 성공 시: 인증 토큰과 사용자 정보를 포함한 튜플
  /// - 실패 시: Exception throw
  Future<(AuthToken token, User user)> signInWithKakao();

  /// 애플 소셜 로그인을 수행합니다.
  ///
  /// Returns:
  /// - 성공 시: 인증 토큰과 사용자 정보를 포함한 튜플
  /// - 실패 시: Exception throw
  Future<(AuthToken token, User user)> signInWithApple();

  /// 로그아웃을 수행합니다.
  Future<void> signOut();

  /// Access Token을 갱신합니다.
  ///
  /// Parameters:
  /// - refreshToken: 갱신에 사용할 Refresh Token
  ///
  /// Returns:
  /// - 새로운 AuthToken
  Future<AuthToken> refreshAccessToken(String refreshToken);

  /// 현재 저장된 인증 토큰을 가져옵니다.
  ///
  /// Returns:
  /// - 토큰이 있으면 AuthToken, 없으면 null
  Future<AuthToken?> getCurrentToken();

  /// 인증 토큰을 로컬에 저장합니다.
  Future<void> saveToken(AuthToken token);

  /// 저장된 인증 토큰을 삭제합니다.
  Future<void> deleteToken();

  /// 현재 로그인된 사용자 정보를 가져옵니다.
  ///
  /// Returns:
  /// - 로그인되어 있으면 User, 아니면 null
  Future<User?> getCurrentUser();

  /// 사용자가 로그인되어 있는지 확인합니다.
  Future<bool> isSignedIn();
}