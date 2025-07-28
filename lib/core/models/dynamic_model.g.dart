// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DynamicModelImpl _$$DynamicModelImplFromJson(Map<String, dynamic> json) =>
    _$DynamicModelImpl(
      id: json['id'] as String,
      modelName: json['modelName'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String?,
      fields: (json['fields'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, FieldConfig.fromJson(e as Map<String, dynamic>)),
      ),
      validationRules: (json['validationRules'] as List<dynamic>)
          .map((e) => ValidationRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      relationships: json['relationships'] as Map<String, dynamic>,
      uiConfig: json['uiConfig'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool? ?? true,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$DynamicModelImplToJson(_$DynamicModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'modelName': instance.modelName,
      'displayName': instance.displayName,
      'description': instance.description,
      'fields': instance.fields,
      'validationRules': instance.validationRules,
      'relationships': instance.relationships,
      'uiConfig': instance.uiConfig,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$FieldConfigImpl _$$FieldConfigImplFromJson(Map<String, dynamic> json) =>
    _$FieldConfigImpl(
      fieldName: json['fieldName'] as String,
      fieldType: json['fieldType'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String?,
      isRequired: json['isRequired'] as bool? ?? false,
      isEditable: json['isEditable'] as bool? ?? true,
      isVisible: json['isVisible'] as bool? ?? true,
      validationRules: json['validationRules'] as Map<String, dynamic>?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      defaultValue: json['defaultValue'] as String?,
      uiConfig: json['uiConfig'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FieldConfigImplToJson(_$FieldConfigImpl instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'fieldType': instance.fieldType,
      'displayName': instance.displayName,
      'description': instance.description,
      'isRequired': instance.isRequired,
      'isEditable': instance.isEditable,
      'isVisible': instance.isVisible,
      'validationRules': instance.validationRules,
      'options': instance.options,
      'defaultValue': instance.defaultValue,
      'uiConfig': instance.uiConfig,
    };

_$ValidationRuleImpl _$$ValidationRuleImplFromJson(Map<String, dynamic> json) =>
    _$ValidationRuleImpl(
      fieldName: json['fieldName'] as String,
      ruleType: json['ruleType'] as String,
      ruleConfig: json['ruleConfig'] as Map<String, dynamic>,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$ValidationRuleImplToJson(
        _$ValidationRuleImpl instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'ruleType': instance.ruleType,
      'ruleConfig': instance.ruleConfig,
      'errorMessage': instance.errorMessage,
    };
