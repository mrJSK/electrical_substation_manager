import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'dynamic_model.freezed.dart';
part 'dynamic_model.g.dart';

@freezed
class DynamicModel with _$DynamicModel {
  const DynamicModel._();

  const factory DynamicModel({
    required String id,
    required String modelName,
    required String displayName,
    String? description,
    String? icon,
    String? category, // Equipment, Maintenance, Inspection, Report, etc.
    String? version, // Model version for compatibility
    required String organizationId,
    required Map<String, DynamicField> fields,
    @Default({}) Map<String, dynamic> validationRules,
    @Default({}) Map<String, dynamic> relationships,
    @Default({}) Map<String, dynamic> uiConfig,
    @Default({}) Map<String, dynamic> permissions,
    @Default({}) Map<String, String> sections, // Field grouping
    @Default([]) List<String> requiredFields,
    @Default([]) List<String> searchableFields, // For search functionality
    @Default([]) List<String> listViewFields, // Fields to show in list views
    @Default({}) Map<String, dynamic> layoutConfig, // Form layout configuration
    @Default(true) bool isActive,
    @Default(false) bool isSystemModel,
    @Default(false) bool allowDuplicates,
    @Default(false) bool enableAuditLog,
    @Default(false) bool enableVersioning,
    String? createdBy,
    String? updatedBy,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _DynamicModel;

  factory DynamicModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicModelFromJson(json);

  factory DynamicModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DynamicModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods for form building
  List<DynamicField> get orderedFields {
    final fieldList = fields.values.toList();
    fieldList.sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
    return fieldList;
  }

  List<DynamicField> get visibleFields =>
      orderedFields.where((field) => field.isVisible).toList();

  List<DynamicField> get editableFields =>
      orderedFields.where((field) => field.isEditable).toList();

  List<DynamicField> get requiredFieldObjects =>
      orderedFields.where((field) => field.isRequired).toList();

  // Group fields by section for better form organization
  Map<String, List<DynamicField>> get fieldsBySection {
    final Map<String, List<DynamicField>> grouped = {};

    for (final field in orderedFields) {
      final section = field.section ?? 'General';
      grouped.putIfAbsent(section, () => []).add(field);
    }

    return grouped;
  }

  // Get fields for specific operations
  List<DynamicField> getFieldsForOperation(String operation) {
    switch (operation.toLowerCase()) {
      case 'create':
        return editableFields.where((f) => f.showInCreate).toList();
      case 'edit':
        return editableFields.where((f) => f.showInEdit).toList();
      case 'view':
        return visibleFields.where((f) => f.showInView).toList();
      case 'list':
        return orderedFields
            .where((f) => listViewFields.contains(f.fieldName))
            .toList();
      case 'search':
        return orderedFields
            .where((f) => searchableFields.contains(f.fieldName))
            .toList();
      default:
        return orderedFields;
    }
  }

  // Validation methods
  bool validateRecord(Map<String, dynamic> data) {
    // Check required fields
    for (final fieldName in requiredFields) {
      if (!data.containsKey(fieldName) ||
          data[fieldName] == null ||
          data[fieldName].toString().trim().isEmpty) {
        return false;
      }
    }

    // Validate each field
    for (final field in fields.values) {
      if (!field.validateValue(data[field.fieldName])) {
        return false;
      }
    }

    return true;
  }

  List<String> getValidationErrors(Map<String, dynamic> data) {
    final errors = <String>[];

    // Check required fields
    for (final fieldName in requiredFields) {
      final field = fields[fieldName];
      if (field != null &&
          (!data.containsKey(fieldName) ||
              data[fieldName] == null ||
              data[fieldName].toString().trim().isEmpty)) {
        errors.add('${field.displayName} is required');
      }
    }

    // Validate each field
    for (final field in fields.values) {
      final fieldErrors = field.getValidationErrors(data[field.fieldName]);
      errors.addAll(fieldErrors.map((e) => '${field.displayName}: $e'));
    }

    return errors;
  }

  // Check if user has permission for specific operation
  bool hasPermission(String userId, String operation,
      [Map<String, dynamic>? userRoles]) {
    final modelPermissions = permissions[operation] as List<String>?;
    if (modelPermissions == null || modelPermissions.isEmpty) {
      return true; // No restrictions
    }

    // Check user roles (simplified - enhance based on your permission system)
    final roles = userRoles?['roles'] as List<String>? ?? [];
    return modelPermissions.any((permission) => roles.contains(permission));
  }

  // Get model statistics
  Map<String, dynamic> getModelStats() {
    return {
      'totalFields': fields.length,
      'requiredFields': requiredFields.length,
      'editableFields': editableFields.length,
      'visibleFields': visibleFields.length,
      'sections': fieldsBySection.keys.length,
      'hasValidation': validationRules.isNotEmpty,
      'hasRelationships': relationships.isNotEmpty,
    };
  }
}

@freezed
class DynamicField with _$DynamicField {
  const DynamicField._();

  const factory DynamicField({
    required String fieldName,
    required String fieldType, // Use FieldType enum values as strings
    required String displayName,
    String? description,
    String? helpText, // Additional help text for users
    String? placeholder,
    String? section, // Group fields in sections
    String? prefix, // Input prefix (e.g., "$", "₹")
    String? suffix, // Input suffix (e.g., "kV", "MW")
    @Default(false) bool isRequired,
    @Default(true) bool isEditable,
    @Default(true) bool isVisible,
    @Default(false) bool isUnique,
    @Default(true) bool showInCreate, // Show in create forms
    @Default(true) bool showInEdit, // Show in edit forms
    @Default(true) bool showInView, // Show in view/detail screens
    @Default(false) bool showInList, // Show in list views
    @Default(false) bool isSearchable, // Include in search
    @Default([]) List<String> options, // For selection fields
    @Default({}) Map<String, dynamic> validationRules,
    @Default({}) Map<String, dynamic> uiConfig,
    dynamic defaultValue,
    String? referenceModel, // For reference fields
    String? referenceField, // Field to display from referenced model
    @Default(0) int order,

    // Additional validation properties
    int? minLength,
    int? maxLength,
    int? maxLines, // For textarea fields
    double? minValue,
    double? maxValue,
    String? pattern, // Regex pattern for validation
    String? textCapitalization, // none, words, sentences, characters
    DateTime? minDate,
    DateTime? maxDate,
    int? divisions, // For slider fields

    // UI enhancement properties
    String? iconName, // Icon to show with field
    String? colorScheme, // Color scheme for field
    @Default(false) bool isReadOnly, // Read-only in all contexts
    @Default(false) bool isHidden, // Hidden but present in data
    String? conditionalLogic, // Show/hide based on other field values

    // File field properties
    @Default([]) List<String> allowedFileTypes, // For file fields
    int? maxFileSize, // In bytes
    @Default(false) bool allowMultiple, // Allow multiple file selection

    // Relationship properties
    String? lookupFilter, // Filter for lookup fields
    @Default(false) bool cascadeDelete, // Cascade delete for references

    // Electrical industry specific
    String? unitOfMeasure, // kV, MW, A, etc.
    String? equipmentCategory, // For equipment-related fields
    @Default(false) bool isCriticalField, // Mark as critical for safety
  }) = _DynamicField;

  factory DynamicField.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldFromJson(json);

  // Helper methods for field types
  bool get isSelectionField =>
      fieldType == 'selection' || fieldType == 'multiselection';

  bool get isReferenceField => fieldType == 'reference';

  bool get isFileField => fieldType == 'file' || fieldType == 'image';

  bool get isNumericField =>
      fieldType == 'number' || fieldType == 'integer' || fieldType == 'double';

  bool get isDateField =>
      fieldType == 'date' || fieldType == 'datetime' || fieldType == 'time';

  bool get isTextualField =>
      fieldType == 'string' || fieldType == 'text' || fieldType == 'textarea';

  bool get hasOptions => options.isNotEmpty;

  bool get hasValidation => validationRules.isNotEmpty || isRequired;

  String get inputType => uiConfig['inputType'] ?? fieldType;

  String get displayIcon => iconName ?? _getDefaultIcon();

  // Validation methods
  bool validateValue(dynamic value) {
    if (isRequired && (value == null || value.toString().trim().isEmpty)) {
      return false;
    }

    if (value == null || value.toString().trim().isEmpty) {
      return true; // Empty values are valid for non-required fields
    }

    return getValidationErrors(value).isEmpty;
  }

  List<String> getValidationErrors(dynamic value) {
    final errors = <String>[];

    if (value == null || value.toString().trim().isEmpty) {
      if (isRequired) {
        errors.add('This field is required');
      }
      return errors;
    }

    final stringValue = value.toString();

    // Length validation
    if (minLength != null && stringValue.length < minLength!) {
      errors.add('Minimum length is ${minLength!} characters');
    }
    if (maxLength != null && stringValue.length > maxLength!) {
      errors.add('Maximum length is ${maxLength!} characters');
    }

    // Numeric validation
    if (isNumericField) {
      final numValue = double.tryParse(stringValue);
      if (numValue == null) {
        errors.add('Must be a valid number');
      } else {
        if (minValue != null && numValue < minValue!) {
          errors.add('Minimum value is ${minValue!}');
        }
        if (maxValue != null && numValue > maxValue!) {
          errors.add('Maximum value is ${maxValue!}');
        }
      }
    }

    // Pattern validation
    if (pattern != null && !RegExp(pattern!).hasMatch(stringValue)) {
      errors.add('Invalid format');
    }

    // Email validation
    if (fieldType == 'email' && !_isValidEmail(stringValue)) {
      errors.add('Invalid email format');
    }

    // Phone validation
    if (fieldType == 'phone' && !_isValidPhone(stringValue)) {
      errors.add('Invalid phone format');
    }

    // URL validation
    if (fieldType == 'url' && !_isValidUrl(stringValue)) {
      errors.add('Invalid URL format');
    }

    // Selection validation
    if (isSelectionField && hasOptions && !options.contains(stringValue)) {
      errors.add('Invalid selection');
    }

    return errors;
  }

  // Get formatted display value
  String getDisplayValue(dynamic value) {
    if (value == null) return '';

    final stringValue = value.toString();

    // Add prefix/suffix
    final formattedValue = '${prefix ?? ''}$stringValue${suffix ?? ''}';

    // Handle special field types
    switch (fieldType) {
      case 'date':
        if (value is DateTime) {
          return '${value.day}/${value.month}/${value.year}';
        }
        break;
      case 'datetime':
        if (value is DateTime) {
          return '${value.day}/${value.month}/${value.year} ${value.hour}:${value.minute.toString().padLeft(2, '0')}';
        }
        break;
      case 'boolean':
        return value == true ? 'Yes' : 'No';
      case 'number':
        if (unitOfMeasure != null) {
          return '$formattedValue $unitOfMeasure';
        }
        break;
    }

    return formattedValue;
  }

  // Helper methods for UI configuration
  Widget? getFieldIcon() {
    // Return appropriate icon widget based on iconName
    // This would be implemented in your UI layer
    return null;
  }

  Map<String, dynamic> getUIConfiguration() {
    return {
      ...uiConfig,
      'icon': displayIcon,
      'colorScheme': colorScheme,
      'prefix': prefix,
      'suffix': suffix,
      'placeholder': placeholder,
      'helpText': helpText,
      'isReadOnly': isReadOnly,
      'isCritical': isCriticalField,
    };
  }

  // Private helper methods
  String _getDefaultIcon() {
    switch (fieldType) {
      case 'string':
      case 'text':
        return 'text_fields';
      case 'number':
      case 'integer':
      case 'double':
        return 'numbers';
      case 'boolean':
        return 'check_box';
      case 'date':
      case 'datetime':
        return 'calendar_today';
      case 'selection':
        return 'arrow_drop_down';
      case 'file':
        return 'attach_file';
      case 'image':
        return 'image';
      case 'email':
        return 'email';
      case 'phone':
        return 'phone';
      case 'url':
        return 'link';
      case 'location':
        return 'location_on';
      case 'reference':
        return 'link';
      default:
        return 'input';
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(phone);
  }

  bool _isValidUrl(String url) {
    return RegExp(r'^https?:\/\/').hasMatch(url);
  }
}

@freezed
class DynamicRecord with _$DynamicRecord {
  const DynamicRecord._();

  const factory DynamicRecord({
    required String id,
    required String modelId,
    required String organizationId,
    required Map<String, dynamic> data,
    @Default({}) Map<String, dynamic> metadata,
    @Default({}) Map<String, dynamic> computedFields, // Calculated fields
    @Default({}) Map<String, dynamic> auditLog, // Change history
    @Default('draft') String status, // draft, active, archived, deleted
    @Default(1) int version, // Record version for optimistic locking
    String? createdBy,
    String? updatedBy,
    String? assignedTo, // For workflow management
    @Default(true) bool isActive,
    @Default(false) bool isLocked, // Prevent editing
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? lastAccessedAt,
  }) = _DynamicRecord;

  factory DynamicRecord.fromJson(Map<String, dynamic> json) =>
      _$DynamicRecordFromJson(json);

  factory DynamicRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DynamicRecord.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Enhanced helper methods
  T? getValue<T>(String fieldName, [T? defaultValue]) {
    if (!data.containsKey(fieldName)) return defaultValue;
    final value = data[fieldName];
    if (value is T) return value;

    // Try to convert common types
    if (T == String) return value?.toString() as T?;
    if (T == int && value is num) return value.toInt() as T?;
    if (T == double && value is num) return value.toDouble() as T?;
    if (T == bool) {
      if (value is bool) return value as T?;
      if (value is String) {
        return (value.toLowerCase() == 'true' || value == '1') as T?;
      }
    }

    return defaultValue;
  }

  String getDisplayValue(String fieldName, [String defaultValue = '']) {
    final value = data[fieldName];
    return value?.toString() ?? defaultValue;
  }

  // Get formatted display value using field configuration
  String getFormattedValue(String fieldName, DynamicField field,
      [String defaultValue = '']) {
    final value = data[fieldName];
    if (value == null) return defaultValue;

    return field.getDisplayValue(value);
  }

  // Check if record has been modified since last save
  bool hasChanges(Map<String, dynamic> newData) {
    for (final entry in newData.entries) {
      if (data[entry.key] != entry.value) {
        return true;
      }
    }
    return false;
  }

  // Get record summary for list views
  Map<String, dynamic> getSummary(List<String> summaryFields) {
    final summary = <String, dynamic>{};
    for (final field in summaryFields) {
      summary[field] = data[field];
    }
    return summary;
  }

  // Check if record matches search criteria
  bool matchesSearch(String searchTerm, List<String> searchableFields) {
    final term = searchTerm.toLowerCase();

    for (final fieldName in searchableFields) {
      final value = data[fieldName]?.toString()?.toLowerCase() ?? '';
      if (value.contains(term)) {
        return true;
      }
    }

    return false;
  }

  // Get record history if audit log is enabled
  List<Map<String, dynamic>> getHistory() {
    final history = auditLog['history'] as List<dynamic>? ?? [];
    return history.cast<Map<String, dynamic>>();
  }

  // Add change to audit log
  DynamicRecord addToAuditLog(
      String action, String userId, Map<String, dynamic> changes) {
    final newAuditLog = Map<String, dynamic>.from(auditLog);
    final history = newAuditLog['history'] as List<dynamic>? ?? [];

    history.add({
      'action': action,
      'userId': userId,
      'timestamp': DateTime.now().toIso8601String(),
      'changes': changes,
    });

    newAuditLog['history'] = history;

    return copyWith(
      auditLog: newAuditLog,
      updatedBy: userId,
      updatedAt: DateTime.now(),
      version: version + 1,
    );
  }
}

// Enhanced enum with more field types for electrical industry
enum FieldType {
  @JsonValue('string')
  string,
  @JsonValue('text')
  text,
  @JsonValue('textarea')
  textarea,
  @JsonValue('number')
  number,
  @JsonValue('integer')
  integer,
  @JsonValue('double')
  double,
  @JsonValue('boolean')
  boolean,
  @JsonValue('switch')
  switchField,
  @JsonValue('checkbox')
  checkbox,
  @JsonValue('date')
  date,
  @JsonValue('datetime')
  datetime,
  @JsonValue('time')
  time,
  @JsonValue('selection')
  selection,
  @JsonValue('multiselection')
  multiselection,
  @JsonValue('radio')
  radio,
  @JsonValue('slider')
  slider,
  @JsonValue('file')
  file,
  @JsonValue('image')
  image,
  @JsonValue('reference')
  reference,
  @JsonValue('location')
  location,
  @JsonValue('email')
  email,
  @JsonValue('phone')
  phone,
  @JsonValue('url')
  url,
  @JsonValue('password')
  password,
  @JsonValue('color')
  color,
  @JsonValue('currency')
  currency,
  @JsonValue('percentage')
  percentage,

  // Electrical industry specific types
  @JsonValue('voltage')
  voltage,
  @JsonValue('current')
  current,
  @JsonValue('power')
  power,
  @JsonValue('frequency')
  frequency,
  @JsonValue('temperature')
  temperature,
  @JsonValue('pressure')
  pressure,
  @JsonValue('equipment_id')
  equipmentId,
  @JsonValue('maintenance_type')
  maintenanceType,
  @JsonValue('safety_rating')
  safetyRating,
}

// Timestamp converter for Firestore integration
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    return object?.toIso8601String();
  }
}

// Extension methods for easier usage
extension DynamicModelExtensions on DynamicModel {
  // Get field by name with null safety
  DynamicField? getField(String fieldName) => fields[fieldName];

  // Check if field exists
  bool hasField(String fieldName) => fields.containsKey(fieldName);

  // Get required field names as set for faster lookup
  Set<String> get requiredFieldsSet => requiredFields.toSet();

  // Get fields suitable for electrical equipment
  List<DynamicField> get electricalFields =>
      orderedFields.where((f) => _isElectricalField(f.fieldType)).toList();

  bool _isElectricalField(String fieldType) {
    return [
      'voltage',
      'current',
      'power',
      'frequency',
      'temperature',
      'pressure',
      'equipment_id',
      'maintenance_type',
      'safety_rating',
    ].contains(fieldType);
  }
}

extension DynamicRecordExtensions on DynamicRecord {
  // Quick status checks
  bool get isDraft => status == 'draft';
  bool get isPublished => status == 'active';
  bool get isArchived => status == 'archived';
  bool get isDeleted => status == 'deleted';

  // Equipment-specific helpers
  String? get equipmentId => getValue<String>('equipment_id');
  String? get equipmentName => getValue<String>('equipment_name');
  String? get equipmentType => getValue<String>('equipment_type');
  double? get voltageRating => getValue<double>('voltage_rating');
  String? get maintenanceType => getValue<String>('maintenance_type');

  // Safety checks
  bool get isCriticalEquipment {
    final safetyRating = getValue<String>('safety_rating');
    return safetyRating == 'critical' || safetyRating == 'high';
  }
}
