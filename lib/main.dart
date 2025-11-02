import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'core/config/kakao_config.dart';
import 'core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 카카오 SDK 초기화
  KakaoSdk.init(
    nativeAppKey: KakaoConfig.nativeAppKey,
    javaScriptAppKey: KakaoConfig.javaScriptAppKey,
  );

  runApp(
    const ProviderScope(
      child: SomeverseApp(),
    ),
  );
}

/// Someverse 앱의 루트 위젯
class SomeverseApp extends StatelessWidget {
  const SomeverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Someverse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
