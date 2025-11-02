import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:someverse/features/auth/domain/entities/region.dart';

part 'region_model.freezed.dart';
part 'region_model.g.dart';

/// Region의 데이터 모델 (JSON 직렬화 지원)
@freezed
abstract class RegionModel with _$RegionModel {
  const RegionModel._();

  const factory RegionModel({
    required String id,
    required String province,
    required String city,
  }) = _RegionModel;

  /// JSON에서 모델로 변환
  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);

  /// 도메인 엔티티로 변환
  Region toEntity() {
    return Region(
      id: id,
      province: province,
      city: city,
    );
  }

  /// 도메인 엔티티에서 모델로 변환
  factory RegionModel.fromEntity(Region entity) {
    return RegionModel(
      id: entity.id,
      province: entity.province,
      city: entity.city,
    );
  }
}
