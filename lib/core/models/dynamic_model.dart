import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'dynamic_model.freezed.dart';
part 'dynamic_model.g.dart';

@freezed
class DynamicModel with _$DynamicModel {
  const factory DynamicModel({
    required String id,
    required String modelName,
    required String displayName,
    String? description,
    required Map<String, FieldConfig> fields,
    required List<ValidationRule> validationRules,
    required Map<String, dynamic> relationships,
    required Map<String, dynamic> uiConfig,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _DynamicModel;

  factory DynamicModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicModelFromJson(json);

  factory DynamicModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DynamicModel.fromJson({...data, 'id': doc.id});
  }
}

@freezed
class FieldConfig with _$FieldConfig {
  const factory FieldConfig({
    required String fieldName,
    required String
        fieldType, // 'string', 'number', 'boolean', 'date', 'dropdown'
    required String displayName,
    String? description,
    @Default(false) bool isRequired,
    @Default(true) bool isEditable,
    @Default(true) bool isVisible,
    Map<String, dynamic>? validationRules,
    List<String>? options, // For dropdown fields
    String? defaultValue,
    Map<String, dynamic>? uiConfig,
  }) = _FieldConfig;

  factory FieldConfig.fromJson(Map<String, dynamic> json) =>
      _$FieldConfigFromJson(json);
}

@freezed
class ValidationRule with _$ValidationRule {
  const factory ValidationRule({
    required String fieldName,
    required String ruleType, // 'required', 'min', 'max', 'pattern', 'custom'
    required Map<String, dynamic> ruleConfig,
    String? errorMessage,
  }) = _ValidationRule;

  factory ValidationRule.fromJson(Map<String, dynamic> json) =>
      _$ValidationRuleFromJson(json);
}
