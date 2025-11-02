import 'package:someverse/features/auth/data/models/auth_token_model.dart';
import 'package:someverse/features/auth/data/models/user_model.dart';

/// 인증 파사드 데이터 소스
///
/// 사용처(리포지토리)는 이 인터페이스만 의존하고,
/// 구현체는 원격 API, 로컬 스텁 등 다양한 전략으로 제공될 수 있습니다.
abstract class AuthDataSource {
  Future<(AuthTokenModel, UserModel)> signInWithKakao(String authorizationCode);

  Future<(AuthTokenModel, UserModel)> signInWithApple(
    String identityToken,
    String authorizationCode,
  );

  Future<void> signOut();

  Future<AuthTokenModel> refreshAccessToken(String refreshToken);

  Future<UserModel> getCurrentUser();
}
