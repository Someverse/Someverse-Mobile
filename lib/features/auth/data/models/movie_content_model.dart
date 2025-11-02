import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:someverse/features/auth/domain/entities/movie_content.dart';

part 'movie_content_model.freezed.dart';
part 'movie_content_model.g.dart';

/// MovieContent의 데이터 모델 (JSON 직렬화 지원)
@freezed
abstract class MovieContentModel with _$MovieContentModel {
  const MovieContentModel._();

  const factory MovieContentModel({
    required String id,
    required String title,
    required String posterUrl,
    required List<String> categoryIds,
    int? releaseYear,
    String? director,
    double? rating,
  }) = _MovieContentModel;

  /// JSON에서 모델로 변환
  factory MovieContentModel.fromJson(Map<String, dynamic> json) =>
      _$MovieContentModelFromJson(json);

  /// 도메인 엔티티로 변환
  MovieContent toEntity() {
    return MovieContent(
      id: id,
      title: title,
      posterUrl: posterUrl,
      categoryIds: categoryIds,
      releaseYear: releaseYear,
      director: director,
      rating: rating,
    );
  }

  /// 도메인 엔티티에서 모델로 변환
  factory MovieContentModel.fromEntity(MovieContent entity) {
    return MovieContentModel(
      id: entity.id,
      title: entity.title,
      posterUrl: entity.posterUrl,
      categoryIds: entity.categoryIds,
      releaseYear: entity.releaseYear,
      director: entity.director,
      rating: entity.rating,
    );
  }
}