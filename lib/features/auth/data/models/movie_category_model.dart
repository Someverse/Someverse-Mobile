import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:someverse/features/auth/domain/entities/movie_category.dart';

part 'movie_category_model.freezed.dart';
part 'movie_category_model.g.dart';

/// MovieCategory의 데이터 모델 (JSON 직렬화 지원)
@freezed
abstract class MovieCategoryModel with _$MovieCategoryModel {
  const MovieCategoryModel._();

  const factory MovieCategoryModel({
    required String id,
    required String name,
  }) = _MovieCategoryModel;

  /// JSON에서 모델로 변환
  factory MovieCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MovieCategoryModelFromJson(json);

  /// 도메인 엔티티로 변환
  MovieCategory toEntity() {
    return MovieCategory(
      id: id,
      name: name,
    );
  }

  /// 도메인 엔티티에서 모델로 변환
  factory MovieCategoryModel.fromEntity(MovieCategory entity) {
    return MovieCategoryModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
