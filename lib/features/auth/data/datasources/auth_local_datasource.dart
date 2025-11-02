import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:someverse/features/auth/data/datasources/auth_datasource.dart';
import 'package:someverse/features/auth/data/models/auth_token_model.dart';
import 'package:someverse/features/auth/data/models/user_model.dart';

/// 인증 관련 로컬 데이터 소스
///
/// 디바이스에 인증 토큰과 사용자 정보를 안전하게 저장하며,
/// 테스트 시에는 원격 데이터 소스를 대체할 수도 있습니다.
class AuthLocalDataSource implements AuthDataSource {
  final FlutterSecureStorage _secureStorage;

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_info';

  AuthLocalDataSource(this._secureStorage);

  @override
  Future<(AuthTokenModel, UserModel)> signInWithKakao(
    String authorizationCode,
  ) async {
    // 로그인 인가 코드 유효성 검증 (빈 문자열이 아니면 유효하다고 간주)
    if (authorizationCode.isEmpty) {
      throw Exception('카카오 로그인 인가 코드가 유효하지 않습니다.');
    }

    print('카카오 인가 코드 authorizationCode: $authorizationCode');

    // Mock 토큰 생성
    final tokenModel = AuthTokenModel(
      accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      tokenType: 'Bearer',
      expiresIn: 3600 * 24, // 24시간
      issuedAt: DateTime.now(),
    );

    // Mock 유저 생성
    final userModel = UserModel(
      id: 'mock_user_kakao_${DateTime.now().millisecondsSinceEpoch}',
      nickname: '카카오유저',
      gender: 'male',
      birthDate: '1990-01-01',
      activeRegions: ['서울'],
      profileImageUrls: [],
      preferredMovieCategories: [],
      preferredMovies: [],
      email: 'kakao@example.com',
      socialProvider: 'kakao',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // 로컬 저장소에 저장
    await saveToken(tokenModel);
    await saveUser(userModel);

    return (tokenModel, userModel);
  }

  @override
  Future<(AuthTokenModel, UserModel)> signInWithApple(
    String identityToken,
    String authorizationCode,
  ) async {
    // 로그인 토큰 유효성 검증
    if (identityToken.isEmpty || authorizationCode.isEmpty) {
      throw Exception('애플 로그인 토큰이 유효하지 않습니다.');
    }

    // Mock 토큰 생성
    final tokenModel = AuthTokenModel(
      accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      tokenType: 'Bearer',
      expiresIn: 3600 * 24, // 24시간
      issuedAt: DateTime.now(),
    );

    // Mock 유저 생성
    final userModel = UserModel(
      id: 'mock_user_apple_${DateTime.now().millisecondsSinceEpoch}',
      nickname: '애플유저',
      gender: 'female',
      birthDate: '1995-06-15',
      activeRegions: ['서울'],
      profileImageUrls: [],
      preferredMovieCategories: [],
      preferredMovies: [],
      email: 'apple@example.com',
      socialProvider: 'apple',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // 로컬 저장소에 저장
    await saveToken(tokenModel);
    await saveUser(userModel);

    return (tokenModel, userModel);
  }

  @override
  Future<void> signOut() async {
    await clearAll();
  }

  @override
  Future<AuthTokenModel> refreshAccessToken(String refreshToken) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('저장된 토큰이 없습니다.');
    }
    if (token.refreshToken != refreshToken) {
      throw Exception('Refresh Token이 일치하지 않습니다.');
    }
    return token;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final user = await getUser();
    if (user == null) {
      throw Exception('저장된 사용자 정보가 없습니다.');
    }
    return user;
  }

  Future<void> saveToken(AuthTokenModel token) async {
    try {
      final tokenJson = json.encode(token.toJson());
      await _secureStorage.write(key: _tokenKey, value: tokenJson);
    } catch (e) {
      throw Exception('토큰 저장에 실패했습니다: $e');
    }
  }

  Future<AuthTokenModel?> getToken() async {
    try {
      final tokenJson = await _secureStorage.read(key: _tokenKey);
      if (tokenJson == null) return null;

      final tokenMap = json.decode(tokenJson) as Map<String, dynamic>;
      return AuthTokenModel.fromJson(tokenMap);
    } catch (e) {
      throw Exception('토큰 조회에 실패했습니다: $e');
    }
  }

  Future<void> deleteToken() async {
    try {
      await _secureStorage.delete(key: _tokenKey);
    } catch (e) {
      throw Exception('토큰 삭제에 실패했습니다: $e');
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      await _secureStorage.write(key: _userKey, value: userJson);
    } catch (e) {
      throw Exception('사용자 정보 저장에 실패했습니다: $e');
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final userJson = await _secureStorage.read(key: _userKey);
      if (userJson == null) return null;

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw Exception('사용자 정보 조회에 실패했습니다: $e');
    }
  }

  Future<void> deleteUser() async {
    try {
      await _secureStorage.delete(key: _userKey);
    } catch (e) {
      throw Exception('사용자 정보 삭제에 실패했습니다: $e');
    }
  }

  Future<void> clearAll() async {
    try {
      await Future.wait([
        deleteToken(),
        deleteUser(),
      ]);
    } catch (e) {
      throw Exception('인증 정보 삭제에 실패했습니다: $e');
    }
  }
}
