import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:someverse/core/config/kakao_config.dart';

/// 카카오 로그인 서비스
///
/// 카카오 SDK를 통해 인가 코드를 받아오는 로직을 담당합니다.
class KakaoAuthService {
  /// 카카오 로그인을 실행하고 인가 코드를 반환합니다.
  ///
  /// Returns:
  /// - 성공 시: 인가 코드 문자열
  /// - 실패 시: Exception throw
  Future<String> getAuthorizationCode() async {
    // 리다이렉트 URI 생성 (kakao{NATIVE_APP_KEY}://oauth 형식)
    final redirectUri = 'kakao${KakaoConfig.nativeAppKey}://oauth';

    // 카카오톡 설치 여부 확인
    final talkInstalled = await kakao.isKakaoTalkInstalled();
    
    print('[KakaoAuthService] 카카오톡 설치 여부: $talkInstalled');
    print('[KakaoAuthService] 리다이렉트 URI: $redirectUri');

    try {
      if (talkInstalled) {
        // 카카오톡으로 로그인
        // authorizeWithTalk()은 인가 코드를 직접 반환합니다
        final authorizationCode = await kakao.AuthCodeClient.instance
            .authorizeWithTalk(
          redirectUri: redirectUri,
        );
        print('[KakaoAuthService] 카카오톡 로그인 인가 코드: $authorizationCode');
        return authorizationCode;
      } else {
        // 카카오계정으로 로그인
        // authorize()는 인가 코드를 직접 반환합니다
        final authorizationCode = await kakao.AuthCodeClient.instance.authorize(
          redirectUri: redirectUri,
        );
        print('[KakaoAuthService] 카카오계정 로그인 인가 코드: $authorizationCode');
        return authorizationCode;
      }
    } catch (error) {
      // 카카오톡 로그인 실패 시 카카오계정으로 재시도
      if (talkInstalled) {
        try {
          final authorizationCode = await kakao.AuthCodeClient.instance.authorize(
            redirectUri: redirectUri,
          );
          print('[KakaoAuthService] 재시도 - 카카오계정 로그인 인가 코드: $authorizationCode');
          return authorizationCode;
        } catch (retryError) {
          print('[KakaoAuthService] 카카오 로그인 재시도 실패: $retryError');
          throw Exception('카카오 로그인에 실패했습니다: $retryError');
        }
      } else {
        print('[KakaoAuthService] 카카오 로그인 실패: $error');
        throw Exception('카카오 로그인에 실패했습니다: $error');
      }
    }
  }
}