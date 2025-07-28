class FieldConfig {
  final String fieldName;
  final String displayName;
  final String fieldType;
  final bool? isRequired;
  final String? description;
  final String? helpText;
  final String? placeholder;
  final String? section;
  final String? prefix;
  final String? suffix;
  final int? maxLength;
  final int? minLength;
  final int? maxLines;
  final double? minValue;
  final double? maxValue;
  final int? divisions;
  final List<String>? options;
  final String? pattern;
  final String? textCapitalization;
  final DateTime? minDate;
  final DateTime? maxDate;

  const FieldConfig({
    required this.fieldName,
    required this.displayName,
    required this.fieldType,
    this.isRequired,
    this.description,
    this.helpText,
    this.placeholder,
    this.section,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.minLength,
    this.maxLines,
    this.minValue,
    this.maxValue,
    this.divisions,
    this.options,
    this.pattern,
    this.textCapitalization,
    this.minDate,
    this.maxDate,
  });

  factory FieldConfig.fromJson(Map<String, dynamic> json) {
    return FieldConfig(
      fieldName: json['fieldName'] as String,
      displayName: json['displayName'] as String,
      fieldType: json['fieldType'] as String,
      isRequired: json['isRequired'] as bool?,
      description: json['description'] as String?,
      helpText: json['helpText'] as String?,
      placeholder: json['placeholder'] as String?,
      section: json['section'] as String?,
      prefix: json['prefix'] as String?,
      suffix: json['suffix'] as String?,
      maxLength: json['maxLength'] as int?,
      minLength: json['minLength'] as int?,
      maxLines: json['maxLines'] as int?,
      minValue: json['minValue']?.toDouble(),
      maxValue: json['maxValue']?.toDouble(),
      divisions: json['divisions'] as int?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      pattern: json['pattern'] as String?,
      textCapitalization: json['textCapitalization'] as String?,
      minDate: json['minDate'] != null
          ? DateTime.parse(json['minDate'] as String)
          : null,
      maxDate: json['maxDate'] != null
          ? DateTime.parse(json['maxDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldName': fieldName,
      'displayName': displayName,
      'fieldType': fieldType,
      'isRequired': isRequired,
      'description': description,
      'helpText': helpText,
      'placeholder': placeholder,
      'section': section,
      'prefix': prefix,
      'suffix': suffix,
      'maxLength': maxLength,
      'minLength': minLength,
      'maxLines': maxLines,
      'minValue': minValue,
      'maxValue': maxValue,
      'divisions': divisions,
      'options': options,
      'pattern': pattern,
      'textCapitalization': textCapitalization,
      'minDate': minDate?.toIso8601String(),
      'maxDate': maxDate?.toIso8601String(),
    };
  }

  FieldConfig copyWith({
    String? fieldName,
    String? displayName,
    String? fieldType,
    bool? isRequired,
    String? description,
    String? helpText,
    String? placeholder,
    String? section,
    String? prefix,
    String? suffix,
    int? maxLength,
    int? minLength,
    int? maxLines,
    double? minValue,
    double? maxValue,
    int? divisions,
    List<String>? options,
    String? pattern,
    String? textCapitalization,
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    return FieldConfig(
      fieldName: fieldName ?? this.fieldName,
      displayName: displayName ?? this.displayName,
      fieldType: fieldType ?? this.fieldType,
      isRequired: isRequired ?? this.isRequired,
      description: description ?? this.description,
      helpText: helpText ?? this.helpText,
      placeholder: placeholder ?? this.placeholder,
      section: section ?? this.section,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      maxLength: maxLength ?? this.maxLength,
      minLength: minLength ?? this.minLength,
      maxLines: maxLines ?? this.maxLines,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      divisions: divisions ?? this.divisions,
      options: options ?? this.options,
      pattern: pattern ?? this.pattern,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      minDate: minDate ?? this.minDate,
      maxDate: maxDate ?? this.maxDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FieldConfig) return false;
    return fieldName == other.fieldName &&
        displayName == other.displayName &&
        fieldType == other.fieldType;
  }

  @override
  int get hashCode {
    return fieldName.hashCode ^ displayName.hashCode ^ fieldType.hashCode;
  }

  @override
  String toString() {
    return 'FieldConfig(fieldName: $fieldName, displayName: $displayName, fieldType: $fieldType)';
  }
}
