import 'package:freezed_annotation/freezed_annotation.dart';

part 'region.freezed.dart';

/// 활동 지역을 나타내는 도메인 엔티티
///
/// 온보딩 과정에서 사용자가 활동 지역을 선택할 때 사용됩니다.
@freezed
class Region with _$Region {
  const Region._();

  const factory Region({
    /// 지역 고유 식별자
    required String id,

    /// 시/도 (예: 서울특별시, 경기도)
    required String province,

    /// 시/군/구 (예: 강남구, 수원시) - 선택적
    required String city,
  }) = _Region;

  /// 전체 지역명을 반환합니다 (예: 서울특별시 강남구)
  String get fullName => '$province $city';
}

