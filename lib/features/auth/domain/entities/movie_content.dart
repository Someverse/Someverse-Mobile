import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_content.freezed.dart';

/// 영화 콘텐츠를 나타내는 도메인 엔티티
///
/// 온보딩 과정에서 사용자가 선호하는 영화 작품을 선택할 때 사용됩니다.
@freezed
abstract class MovieContent with _$MovieContent {
  const factory MovieContent({
    /// 영화 고유 식별자
    required String id,

    /// 영화 제목
    required String title,

    /// 포스터 이미지 URL
    required String posterUrl,

    /// 영화가 속한 카테고리 ID 목록
    required List<String> categoryIds,

    /// 개봉 연도
    int? releaseYear,

    /// 감독
    String? director,

    /// 평점
    double? rating,
  }) = _MovieContent;
}