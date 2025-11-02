import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:someverse/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User의 데이터 모델 (JSON 직렬화 지원)
@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String nickname,
    required String gender,
    required String birthDate,
    required List<String> activeRegions,
    required List<String> profileImageUrls,
    required List<String> preferredMovieCategories,
    required List<String> preferredMovies,
    String? email,
    String? phoneNumber,
    String? socialProvider,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  /// JSON에서 모델로 변환
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// 도메인 엔티티로 변환
  User toEntity() {
    return User(
      id: id,
      nickname: nickname,
      gender: _parseGender(gender),
      birthDate: DateTime.parse(birthDate),
      activeRegions: activeRegions,
      profileImageUrls: profileImageUrls,
      preferredMovieCategories: preferredMovieCategories,
      preferredMovies: preferredMovies,
      email: email,
      phoneNumber: phoneNumber,
      socialProvider: socialProvider != null
          ? _parseSocialProvider(socialProvider!)
          : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// 도메인 엔티티에서 모델로 변환
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      nickname: entity.nickname,
      gender: entity.gender.name,
      birthDate: entity.birthDate.toIso8601String().split('T')[0],
      activeRegions: entity.activeRegions,
      profileImageUrls: entity.profileImageUrls,
      preferredMovieCategories: entity.preferredMovieCategories,
      preferredMovies: entity.preferredMovies,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      socialProvider: entity.socialProvider?.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Gender _parseGender(String value) {
    return Gender.fromString(value);
  }

  SocialProvider? _parseSocialProvider(String value) {
    return SocialProvider.fromString(value);
  }
}