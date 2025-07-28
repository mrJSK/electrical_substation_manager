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
      icon: json['icon'] as String?,
      category: json['category'] as String?,
      version: json['version'] as String?,
      organizationId: json['organizationId'] as String,
      fields: (json['fields'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, DynamicField.fromJson(e as Map<String, dynamic>)),
      ),
      validationRules:
          json['validationRules'] as Map<String, dynamic>? ?? const {},
      relationships: json['relationships'] as Map<String, dynamic>? ?? const {},
      uiConfig: json['uiConfig'] as Map<String, dynamic>? ?? const {},
      permissions: json['permissions'] as Map<String, dynamic>? ?? const {},
      sections: (json['sections'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      requiredFields: (json['requiredFields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      searchableFields: (json['searchableFields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      listViewFields: (json['listViewFields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      layoutConfig: json['layoutConfig'] as Map<String, dynamic>? ?? const {},
      isActive: json['isActive'] as bool? ?? true,
      isSystemModel: json['isSystemModel'] as bool? ?? false,
      allowDuplicates: json['allowDuplicates'] as bool? ?? false,
      enableAuditLog: json['enableAuditLog'] as bool? ?? false,
      enableVersioning: json['enableVersioning'] as bool? ?? false,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$DynamicModelImplToJson(_$DynamicModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'modelName': instance.modelName,
      'displayName': instance.displayName,
      'description': instance.description,
      'icon': instance.icon,
      'category': instance.category,
      'version': instance.version,
      'organizationId': instance.organizationId,
      'fields': instance.fields,
      'validationRules': instance.validationRules,
      'relationships': instance.relationships,
      'uiConfig': instance.uiConfig,
      'permissions': instance.permissions,
      'sections': instance.sections,
      'requiredFields': instance.requiredFields,
      'searchableFields': instance.searchableFields,
      'listViewFields': instance.listViewFields,
      'layoutConfig': instance.layoutConfig,
      'isActive': instance.isActive,
      'isSystemModel': instance.isSystemModel,
      'allowDuplicates': instance.allowDuplicates,
      'enableAuditLog': instance.enableAuditLog,
      'enableVersioning': instance.enableVersioning,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$DynamicFieldImpl _$$DynamicFieldImplFromJson(Map<String, dynamic> json) =>
    _$DynamicFieldImpl(
      fieldName: json['fieldName'] as String,
      fieldType: json['fieldType'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String?,
      helpText: json['helpText'] as String?,
      placeholder: json['placeholder'] as String?,
      section: json['section'] as String?,
      prefix: json['prefix'] as String?,
      suffix: json['suffix'] as String?,
      isRequired: json['isRequired'] as bool? ?? false,
      isEditable: json['isEditable'] as bool? ?? true,
      isVisible: json['isVisible'] as bool? ?? true,
      isUnique: json['isUnique'] as bool? ?? false,
      showInCreate: json['showInCreate'] as bool? ?? true,
      showInEdit: json['showInEdit'] as bool? ?? true,
      showInView: json['showInView'] as bool? ?? true,
      showInList: json['showInList'] as bool? ?? false,
      isSearchable: json['isSearchable'] as bool? ?? false,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      validationRules:
          json['validationRules'] as Map<String, dynamic>? ?? const {},
      uiConfig: json['uiConfig'] as Map<String, dynamic>? ?? const {},
      defaultValue: json['defaultValue'],
      referenceModel: json['referenceModel'] as String?,
      referenceField: json['referenceField'] as String?,
      order: (json['order'] as num?)?.toInt() ?? 0,
      minLength: (json['minLength'] as num?)?.toInt(),
      maxLength: (json['maxLength'] as num?)?.toInt(),
      maxLines: (json['maxLines'] as num?)?.toInt(),
      minValue: (json['minValue'] as num?)?.toDouble(),
      maxValue: (json['maxValue'] as num?)?.toDouble(),
      pattern: json['pattern'] as String?,
      textCapitalization: json['textCapitalization'] as String?,
      minDate: json['minDate'] == null
          ? null
          : DateTime.parse(json['minDate'] as String),
      maxDate: json['maxDate'] == null
          ? null
          : DateTime.parse(json['maxDate'] as String),
      divisions: (json['divisions'] as num?)?.toInt(),
      iconName: json['iconName'] as String?,
      colorScheme: json['colorScheme'] as String?,
      isReadOnly: json['isReadOnly'] as bool? ?? false,
      isHidden: json['isHidden'] as bool? ?? false,
      conditionalLogic: json['conditionalLogic'] as String?,
      allowedFileTypes: (json['allowedFileTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maxFileSize: (json['maxFileSize'] as num?)?.toInt(),
      allowMultiple: json['allowMultiple'] as bool? ?? false,
      lookupFilter: json['lookupFilter'] as String?,
      cascadeDelete: json['cascadeDelete'] as bool? ?? false,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      equipmentCategory: json['equipmentCategory'] as String?,
      isCriticalField: json['isCriticalField'] as bool? ?? false,
    );

Map<String, dynamic> _$$DynamicFieldImplToJson(_$DynamicFieldImpl instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'fieldType': instance.fieldType,
      'displayName': instance.displayName,
      'description': instance.description,
      'helpText': instance.helpText,
      'placeholder': instance.placeholder,
      'section': instance.section,
      'prefix': instance.prefix,
      'suffix': instance.suffix,
      'isRequired': instance.isRequired,
      'isEditable': instance.isEditable,
      'isVisible': instance.isVisible,
      'isUnique': instance.isUnique,
      'showInCreate': instance.showInCreate,
      'showInEdit': instance.showInEdit,
      'showInView': instance.showInView,
      'showInList': instance.showInList,
      'isSearchable': instance.isSearchable,
      'options': instance.options,
      'validationRules': instance.validationRules,
      'uiConfig': instance.uiConfig,
      'defaultValue': instance.defaultValue,
      'referenceModel': instance.referenceModel,
      'referenceField': instance.referenceField,
      'order': instance.order,
      'minLength': instance.minLength,
      'maxLength': instance.maxLength,
      'maxLines': instance.maxLines,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'pattern': instance.pattern,
      'textCapitalization': instance.textCapitalization,
      'minDate': instance.minDate?.toIso8601String(),
      'maxDate': instance.maxDate?.toIso8601String(),
      'divisions': instance.divisions,
      'iconName': instance.iconName,
      'colorScheme': instance.colorScheme,
      'isReadOnly': instance.isReadOnly,
      'isHidden': instance.isHidden,
      'conditionalLogic': instance.conditionalLogic,
      'allowedFileTypes': instance.allowedFileTypes,
      'maxFileSize': instance.maxFileSize,
      'allowMultiple': instance.allowMultiple,
      'lookupFilter': instance.lookupFilter,
      'cascadeDelete': instance.cascadeDelete,
      'unitOfMeasure': instance.unitOfMeasure,
      'equipmentCategory': instance.equipmentCategory,
      'isCriticalField': instance.isCriticalField,
    };

_$DynamicRecordImpl _$$DynamicRecordImplFromJson(Map<String, dynamic> json) =>
    _$DynamicRecordImpl(
      id: json['id'] as String,
      modelId: json['modelId'] as String,
      organizationId: json['organizationId'] as String,
      data: json['data'] as Map<String, dynamic>,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      computedFields:
          json['computedFields'] as Map<String, dynamic>? ?? const {},
      auditLog: json['auditLog'] as Map<String, dynamic>? ?? const {},
      status: json['status'] as String? ?? 'draft',
      version: (json['version'] as num?)?.toInt() ?? 1,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      assignedTo: json['assignedTo'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isLocked: json['isLocked'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      lastAccessedAt:
          const TimestampConverter().fromJson(json['lastAccessedAt']),
    );

Map<String, dynamic> _$$DynamicRecordImplToJson(_$DynamicRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'modelId': instance.modelId,
      'organizationId': instance.organizationId,
      'data': instance.data,
      'metadata': instance.metadata,
      'computedFields': instance.computedFields,
      'auditLog': instance.auditLog,
      'status': instance.status,
      'version': instance.version,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'assignedTo': instance.assignedTo,
      'isActive': instance.isActive,
      'isLocked': instance.isLocked,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'lastAccessedAt':
          const TimestampConverter().toJson(instance.lastAccessedAt),
    };
