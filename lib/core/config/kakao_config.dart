/// 카카오 SDK 설정
///
/// dart-define을 통해 네이티브 앱 키와 자바스크립트 앱 키를 주입받습니다.
class KakaoConfig {
  /// 카카오 네이티브 앱 키
  static String get nativeAppKey {
    const key = String.fromEnvironment(
      'KAKAO_NATIVE_APP_KEY',
      defaultValue: '',
    );
    if (key.isEmpty) {
      throw Exception(
        'KAKAO_NATIVE_APP_KEY가 설정되지 않았습니다. '
        '--dart-define=KAKAO_NATIVE_APP_KEY=your_key로 설정해주세요.',
      );
    }
    return key;
  }

  /// 카카오 자바스크립트 앱 키
  static String get javaScriptAppKey {
    const key = String.fromEnvironment(
      'KAKAO_JAVASCRIPT_APP_KEY',
      defaultValue: '',
    );
    if (key.isEmpty) {
      throw Exception(
        'KAKAO_JAVASCRIPT_APP_KEY가 설정되지 않았습니다. '
        '--dart-define=KAKAO_JAVASCRIPT_APP_KEY=your_key로 설정해주세요.',
      );
    }
    return key;
  }
}

