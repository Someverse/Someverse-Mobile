import 'package:dio/dio.dart';
import 'package:someverse/features/auth/data/datasources/auth_datasource.dart';
import 'package:someverse/features/auth/data/models/auth_token_model.dart';
import 'package:someverse/features/auth/data/models/user_model.dart';

/// 인증 관련 원격 데이터 소스
///
/// API 서버와 통신하여 인증 관련 데이터를 주고받습니다.
class AuthRemoteDataSource implements AuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<(AuthTokenModel, UserModel)> signInWithKakao(
      String authorizationCode) async {
    try {
      final response = await _dio.post(
        '/auth/kakao',
        data: {'authorization_code': authorizationCode},
      );

      final tokenModel = AuthTokenModel.fromJson(response.data['token']);
      final userModel = UserModel.fromJson(response.data['user']);

      return (tokenModel, userModel);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<(AuthTokenModel, UserModel)> signInWithApple(
    String identityToken,
    String authorizationCode,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/apple',
        data: {
          'identity_token': identityToken,
          'authorization_code': authorizationCode,
        },
      );

      final tokenModel = AuthTokenModel.fromJson(response.data['token']);
      final userModel = UserModel.fromJson(response.data['user']);

      return (tokenModel, userModel);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dio.post('/auth/signout');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokenModel> refreshAccessToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      return AuthTokenModel.fromJson(response.data['token']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me');
      return UserModel.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return Exception('잘못된 요청입니다: $message');
        case 401:
          return Exception('인증에 실패했습니다: $message');
        case 403:
          return Exception('접근 권한이 없습니다: $message');
        case 404:
          return Exception('리소스를 찾을 수 없습니다: $message');
        case 500:
          return Exception('서버 오류가 발생했습니다: $message');
        default:
          return Exception('네트워크 오류: $message');
      }
    } else {
      return Exception('네트워크 연결을 확인해주세요');
    }
  }
}
