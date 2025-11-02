import 'package:flutter/material.dart';

/// 앱에서 사용하는 타이포그래피 스타일
class AppTextStyles {
  AppTextStyles._();

  // 폰트 패밀리
  static const String _fontFamily = 'Pretendard';

  // Display 스타일
  static const TextStyle loginTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: -0.9,
  );

  // 브랜드 스타일
  static const TextStyle brandName = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.45,
  );

  // 로그인 화면 스타일
  static const TextStyle loginMainTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: -0.9,
  );

  static const TextStyle loginSubtitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: -0.4,
  );

  static const TextStyle socialLoginButton = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: -0.4,
  );

  static const TextStyle legalText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -0.35,
  );

  static const TextStyle businessInfo = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.35,
  );
}
