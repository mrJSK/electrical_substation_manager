import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
class OrganizationModel with _$OrganizationModel {
  const factory OrganizationModel({
    required String id,
    required String name,
    String? description,
    required String type, // 'enterprise', 'department', 'team'
    required Map<String, dynamic> settings,
    required List<String> hierarchyLevels,
    String? logoUrl,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _OrganizationModel;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  factory OrganizationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrganizationModel.fromJson({...data, 'id': doc.id});
  }
}

@freezed
class OrganizationalUnit with _$OrganizationalUnit {
  const factory OrganizationalUnit({
    required String id,
    required String organizationId,
    String? parentUnitId,
    required String unitType,
    required int level,
    required String name,
    String? description,
    required Map<String, dynamic> permissionsConfig,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
  }) = _OrganizationalUnit;

  factory OrganizationalUnit.fromJson(Map<String, dynamic> json) =>
      _$OrganizationalUnitFromJson(json);

  factory OrganizationalUnit.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrganizationalUnit.fromJson({...data, 'id': doc.id});
  }
}
