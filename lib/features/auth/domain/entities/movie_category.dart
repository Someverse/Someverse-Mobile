import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_category.freezed.dart';

/// 영화 카테고리를 나타내는 도메인 엔티티
///
/// 온보딩 과정에서 사용자가 선호하는 영화 장르를 선택할 때 사용됩니다.
@freezed
class MovieCategory with _$MovieCategory {
  const factory MovieCategory({
    /// 카테고리 고유 식별자
    required String id,

    /// 카테고리 이름 (예: 액션, 로맨스, 스릴러)
    required String name,
  }) = _MovieCategory;
}

