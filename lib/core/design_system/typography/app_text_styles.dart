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
}
