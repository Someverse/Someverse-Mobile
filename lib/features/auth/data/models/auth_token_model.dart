import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:someverse/features/auth/domain/entities/auth_token.dart';

part 'auth_token_model.freezed.dart';
part 'auth_token_model.g.dart';

/// AuthToken의 데이터 모델 (JSON 직렬화 지원)
@freezed
abstract class AuthTokenModel with _$AuthTokenModel {
  const AuthTokenModel._();

  const factory AuthTokenModel({
    required String accessToken,
    required String refreshToken,
    @Default('Bearer') String tokenType,
    int? expiresIn,
    DateTime? issuedAt,
  }) = _AuthTokenModel;

  /// JSON에서 모델로 변환
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenModelFromJson(json);

  /// 도메인 엔티티로 변환
  AuthToken toEntity() {
    return AuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
      issuedAt: issuedAt,
    );
  }

  /// 도메인 엔티티에서 모델로 변환
  factory AuthTokenModel.fromEntity(AuthToken entity) {
    return AuthTokenModel(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      tokenType: entity.tokenType,
      expiresIn: entity.expiresIn,
      issuedAt: entity.issuedAt,
    );
  }
}