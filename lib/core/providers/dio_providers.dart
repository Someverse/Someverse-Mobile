import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_providers.g.dart';

// ============================================================================
// Infrastructure Providers (Dio, SecureStorage)
// ============================================================================

/// 환경 설정 읽기 (test, dev, prod)
String _getEnvironment() {
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  return env.toLowerCase();
}

/// Dio 인스턴스 제공
@riverpod
Dio dio(Ref ref) {
  final env = _getEnvironment();
  
  final baseUrl = switch (env) {
    'prod' => 'https://api.someverse.com',
    'staging' => 'https://staging-api.someverse.com',
    _ => 'https://dev-api.someverse.com',
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // TODO: Interceptor 추가 (인증 토큰 자동 추가, 로깅 등)

  return dio;
}

/// FlutterSecureStorage 인스턴스 제공
@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}
