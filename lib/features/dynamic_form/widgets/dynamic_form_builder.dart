import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/dynamic_model.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/models/field_config.dart';

class DynamicFormBuilder extends ConsumerStatefulWidget {
  final DynamicModel model;
  final Map<String, dynamic>? initialData;
  final String? recordId;
  final void Function(Map<String, dynamic>) onSubmit;
  final void Function(String fieldName, dynamic value)? onFieldChanged;
  final void Function(bool isValid)? onValidationChanged;
  final bool readOnly;
  final bool showProgress;
  final EdgeInsetsGeometry? padding;

  const DynamicFormBuilder({
    super.key,
    required this.model,
    this.initialData,
    this.recordId,
    required this.onSubmit,
    this.onFieldChanged,
    this.onValidationChanged,
    this.readOnly = false,
    this.showProgress = true,
    this.padding,
  });

  @override
  ConsumerState<DynamicFormBuilder> createState() => _DynamicFormBuilderState();
}

class _DynamicFormBuilderState extends ConsumerState<DynamicFormBuilder>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  int _currentStep = 0;
  int _totalSteps = 1;
  Map<String, FocusNode> _focusNodes = {};
  bool _isValidating = false;
  List<String> _validationErrors = [];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeFocusNodes();
    _calculateSteps();
  }

  void _setupAnimations() {
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }

  void _initializeFocusNodes() {
    _focusNodes = {};
    for (final field in widget.model.fields.values) {
      _focusNodes[field.fieldName] = FocusNode();
    }
  }

  void _calculateSteps() {
    final sections = widget.model.fields.values
        .map((f) => f.section ?? 'General')
        .toSet()
        .length;
    _totalSteps = sections > 1 ? sections : widget.model.fields.length;
  }

  @override
  void dispose() {
    _progressController.dispose();
    for (final node in _focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress indicator
          if (widget.showProgress) ...[
            _buildProgressIndicator(),
            const SizedBox(height: 24),
          ],

          // Form content
          FormBuilder(
            key: _formKey,
            initialValue: widget.initialData ?? {},
            onChanged: _handleFormChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: _buildFormContent(),
          ),

          // Validation errors
          if (_validationErrors.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildValidationErrors(),
          ],

          const SizedBox(height: 24),

          // Form actions
          _buildFormActions(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final progress = _totalSteps > 0 ? (_currentStep + 1) / _totalSteps : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Form Progress',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text(
              '${(_currentStep + 1).clamp(0, _totalSteps)}/$_totalSteps',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: progress * _progressAnimation.value,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
              minHeight: 6,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFormContent() {
    final fieldsBySection = _groupFieldsBySection();

    if (fieldsBySection.length == 1) {
      return _buildFieldList(fieldsBySection.values.first);
    } else {
      return _buildSectionedForm(fieldsBySection);
    }
  }

  Widget _buildFieldList(List<FieldConfig> fields) {
    return Column(
      children: fields
          .map((field) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildField(field),
              ))
          .toList(),
    );
  }

  Widget _buildSectionedForm(Map<String, List<FieldConfig>> fieldsBySection) {
    return Column(
      children: fieldsBySection.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(entry.key),
            const SizedBox(height: 16),
            ..._buildSectionFields(entry.value),
            const SizedBox(height: 24),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(String sectionName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getSectionIcon(sectionName),
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            sectionName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSectionFields(List<FieldConfig> fields) {
    return fields
        .map((field) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildField(field),
            ))
        .toList();
  }

  Widget _buildField(FieldConfig field) {
    final isRequired = field.isRequired ?? false;
    final validators = _buildValidators(field);

    Widget fieldWidget;

    switch (field.fieldType.toLowerCase()) {
      case 'text':
      case 'string':
        fieldWidget = _buildTextField(field, validators);
        break;
      case 'number':
      case 'integer':
      case 'double':
        fieldWidget = _buildNumberField(field, validators);
        break;
      case 'email':
        fieldWidget = _buildEmailField(field, validators);
        break;
      case 'phone':
        fieldWidget = _buildPhoneField(field, validators);
        break;
      case 'password':
        fieldWidget = _buildPasswordField(field, validators);
        break;
      case 'textarea':
      case 'multiline':
        fieldWidget = _buildTextAreaField(field, validators);
        break;
      case 'boolean':
      case 'switch':
        fieldWidget = _buildSwitchField(field);
        break;
      case 'checkbox':
        fieldWidget = _buildCheckboxField(field);
        break;
      case 'date':
        fieldWidget = _buildDateField(field, validators);
        break;
      case 'datetime':
        fieldWidget = _buildDateTimeField(field, validators);
        break;
      case 'time':
        fieldWidget = _buildTimeField(field, validators);
        break;
      case 'dropdown':
      case 'select':
        fieldWidget = _buildDropdownField(field, validators);
        break;
      case 'radio':
        fieldWidget = _buildRadioField(field, validators);
        break;
      case 'slider':
        fieldWidget = _buildSliderField(field);
        break;
      case 'file':
        fieldWidget = _buildFileField(field);
        break;
      case 'color':
        fieldWidget = _buildColorField(field);
        break;
      default:
        fieldWidget = _buildTextField(field, validators);
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.description != null) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    field.description!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        fieldWidget,
      ],
    );
  }

  Widget _buildTextField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderTextField(
      name: field.fieldName,
      focusNode: _focusNodes[field.fieldName],
      decoration: _buildInputDecoration(field),
      validator: FormBuilderValidators.compose(validators),
      readOnly: widget.readOnly,
      maxLength: field.maxLength,
      textCapitalization: _getTextCapitalization(field),
      keyboardType: _getKeyboardType(field),
      inputFormatters: _getInputFormatters(field),
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildNumberField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderTextField(
      name: field.fieldName,
      focusNode: _focusNodes[field.fieldName],
      decoration: _buildInputDecoration(field),
      validator: FormBuilderValidators.compose(validators),
      readOnly: widget.readOnly,
      keyboardType: field.fieldType == 'double'
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      inputFormatters: [
        if (field.fieldType == 'integer')
          FilteringTextInputFormatter.digitsOnly,
        if (field.fieldType == 'double')
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildEmailField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderTextField(
      name: field.fieldName,
      focusNode: _focusNodes[field.fieldName],
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      validator: FormBuilderValidators.compose(validators),
      readOnly: widget.readOnly,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildPhoneField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderTextField(
      name: field.fieldName,
      focusNode: _focusNodes[field.fieldName],
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: const Icon(Icons.phone_outlined),
      ),
      validator: FormBuilderValidators.compose(validators),
      readOnly: widget.readOnly,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s\(\)]')),
      ],
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildPasswordField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderTextField(
      name: field.fieldName,
      focusNode: _focusNodes[field.fieldName],
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: const Icon(Icons.visibility_off),
      ),
      validator: FormBuilderValidators.compose(validators),
      readOnly: widget.readOnly,
      obscureText: true,
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildTextAreaField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderTextField(
      name: field.fieldName,
      focusNode: _focusNodes[field.fieldName],
      decoration: _buildInputDecoration(field),
      validator: FormBuilderValidators.compose(validators),
      readOnly: widget.readOnly,
      maxLines: field.maxLines ?? 4,
      minLines: 3,
      maxLength: field.maxLength,
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildSwitchField(FieldConfig field) {
    return FormBuilderSwitch(
      name: field.fieldName,
      title: Text(
        field.displayName,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      subtitle: field.description != null
          ? Text(
              field.description!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            )
          : null,
      controlAffinity: ListTileControlAffinity.trailing,
      decoration: _buildInputDecoration(field, showBorder: false),
      onChanged: widget.readOnly
          ? null
          : (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildCheckboxField(FieldConfig field) {
    return FormBuilderCheckbox(
      name: field.fieldName,
      title: Text(
        field.displayName,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      subtitle: field.description != null
          ? Text(
              field.description!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            )
          : null,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: widget.readOnly
          ? null
          : (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildDateField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderDateTimePicker(
      name: field.fieldName,
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: const Icon(Icons.calendar_today_outlined),
      ),
      inputType: InputType.date,
      validator: FormBuilderValidators.compose(validators),
      enabled: !widget.readOnly,
      firstDate: field.minDate,
      lastDate: field.maxDate,
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildDateTimeField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderDateTimePicker(
      name: field.fieldName,
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: const Icon(Icons.event_outlined),
      ),
      inputType: InputType.both,
      validator: FormBuilderValidators.compose(validators),
      enabled: !widget.readOnly,
      firstDate: field.minDate,
      lastDate: field.maxDate,
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildTimeField(
      FieldConfig field, List<String? Function(String?)> validators) {
    return FormBuilderDateTimePicker(
      name: field.fieldName,
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: const Icon(Icons.access_time_outlined),
      ),
      inputType: InputType.time,
      validator: FormBuilderValidators.compose(validators),
      enabled: !widget.readOnly,
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildDropdownField(
      FieldConfig field, List<String? Function(String?)> validators) {
    final options = field.options ?? [];

    return FormBuilderDropdown<String>(
      name: field.fieldName,
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: const Icon(Icons.arrow_drop_down_outlined),
      ),
      validator: FormBuilderValidators.compose(validators),
      items: options
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: widget.readOnly
          ? null
          : (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildRadioField(
      FieldConfig field, List<String? Function(String?)> validators) {
    final options = field.options ?? [];

    return FormBuilderRadioGroup<String>(
      name: field.fieldName,
      decoration: _buildInputDecoration(field, showBorder: false),
      validator: FormBuilderValidators.compose(validators),
      options: options
          .map((option) => FormBuilderFieldOption(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: widget.readOnly
          ? null
          : (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildSliderField(FieldConfig field) {
    final min = field.minValue ?? 0.0;
    final max = field.maxValue ?? 100.0;

    return FormBuilderSlider(
      name: field.fieldName,
      decoration: _buildInputDecoration(field, showBorder: false),
      min: min,
      max: max,
      divisions: field.divisions ?? 10,
      onChanged: widget.readOnly
          ? null
          : (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildFileField(FieldConfig field) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            'Upload ${field.displayName}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: widget.readOnly ? null : () => _handleFileUpload(field),
            icon: const Icon(Icons.attach_file),
            label: const Text('Choose File'),
          ),
        ],
      ),
    );
  }

  Widget _buildColorField(FieldConfig field) {
    return FormBuilderTextField(
      name: field.fieldName,
      decoration: _buildInputDecoration(field).copyWith(
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue, // Default color
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.palette_outlined),
          onPressed: widget.readOnly ? null : () => _showColorPicker(field),
        ),
      ),
      readOnly: true,
      onChanged: (value) => _handleFieldChanged(field.fieldName, value),
    );
  }

  Widget _buildValidationErrors() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Please fix the following errors:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...(_validationErrors.map((error) => Padding(
                padding: const EdgeInsets.only(left: 28, bottom: 4),
                child: Text(
                  '• $error',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade600,
                  ),
                ),
              ))),
        ],
      ),
    );
  }

  Widget _buildFormActions() {
    return Column(
      children: [
        // Primary submit button
        SizedBox(
          width: double.infinity,
          child: OnlineOperationGuard(
            onTap: _handleSubmit,
            offlineMessage: 'Submitting forms requires internet connection',
            child: ElevatedButton.icon(
              onPressed: _isValidating ? null : _handleSubmit,
              icon: _isValidating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(widget.recordId != null ? Icons.update : Icons.save),
              label: Text(
                _isValidating
                    ? 'Validating...'
                    : widget.recordId != null
                        ? 'Update Record'
                        : 'Save Record',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Secondary actions
        if (!widget.readOnly) ...[
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _handleSaveDraft,
                  icon: const Icon(Icons.drafts, size: 18),
                  label: const Text('Save Draft'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _handleReset,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  // Helper methods
  InputDecoration _buildInputDecoration(FieldConfig field,
      {bool showBorder = true}) {
    final isRequired = field.isRequired ?? false;

    return InputDecoration(
      labelText: field.displayName + (isRequired ? ' *' : ''),
      helperText: field.helpText,
      hintText: field.placeholder,
      prefixText: field.prefix,
      suffixText: field.suffix,
      border: showBorder ? const OutlineInputBorder() : InputBorder.none,
      enabledBorder: showBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            )
          : InputBorder.none,
      focusedBorder: showBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            )
          : InputBorder.none,
      errorBorder: showBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade400),
            )
          : InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  List<String? Function(String?)> _buildValidators(FieldConfig field) {
    final validators = <String? Function(String?)>[];

    if (field.isRequired ?? false) {
      validators.add(FormBuilderValidators.required());
    }

    if (field.minLength != null) {
      validators.add(FormBuilderValidators.minLength(field.minLength!));
    }

    if (field.maxLength != null) {
      validators.add(FormBuilderValidators.maxLength(field.maxLength!));
    }

    switch (field.fieldType.toLowerCase()) {
      case 'email':
        validators.add(FormBuilderValidators.email());
        break;
      case 'number':
      case 'integer':
        validators.add(FormBuilderValidators.integer());
        if (field.minValue != null) {
          validators.add(FormBuilderValidators.min(field.minValue!));
        }
        if (field.maxValue != null) {
          validators.add(FormBuilderValidators.max(field.maxValue!));
        }
        break;
      case 'double':
        validators.add(FormBuilderValidators.numeric());
        if (field.minValue != null) {
          validators.add(FormBuilderValidators.min(field.minValue!));
        }
        if (field.maxValue != null) {
          validators.add(FormBuilderValidators.max(field.maxValue!));
        }
        break;
    }

    if (field.pattern != null) {
      validators.add(FormBuilderValidators.match(RegExp(field.pattern!)));
    }

    return validators;
  }

  TextCapitalization _getTextCapitalization(FieldConfig field) {
    switch (field.textCapitalization?.toLowerCase()) {
      case 'words':
        return TextCapitalization.words;
      case 'sentences':
        return TextCapitalization.sentences;
      case 'characters':
        return TextCapitalization.characters;
      default:
        return TextCapitalization.none;
    }
  }

  TextInputType _getKeyboardType(FieldConfig field) {
    switch (field.fieldType.toLowerCase()) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'number':
      case 'integer':
        return TextInputType.number;
      case 'double':
        return const TextInputType.numberWithOptions(decimal: true);
      case 'url':
        return TextInputType.url;
      case 'multiline':
      case 'textarea':
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _getInputFormatters(FieldConfig field) {
    final formatters = <TextInputFormatter>[];

    if (field.maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(field.maxLength!));
    }

    switch (field.fieldType.toLowerCase()) {
      case 'integer':
        formatters.add(FilteringTextInputFormatter.digitsOnly);
        break;
      case 'double':
        formatters
            .add(FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')));
        break;
      case 'phone':
        formatters
            .add(FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s\(\)]')));
        break;
    }

    return formatters;
  }

  Map<String, List<FieldConfig>> _groupFieldsBySection() {
    final Map<String, List<FieldConfig>> grouped = {};

    for (final field in widget.model.fields.values) {
      final section = field.section ?? 'General';
      grouped.putIfAbsent(section, () => []).add(field);
    }

    return grouped;
  }

  IconData _getSectionIcon(String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'general':
        return Icons.info_outline;
      case 'equipment':
        return Icons.electrical_services;
      case 'maintenance':
        return Icons.build;
      case 'safety':
        return Icons.security;
      case 'technical':
        return Icons.engineering;
      case 'location':
        return Icons.location_on_outlined;
      case 'contact':
        return Icons.contact_mail_outlined;
      default:
        return Icons.folder_outlined;
    }
  }

  void _handleFormChanged() {
    _updateProgress();
    _validateForm();
  }

  void _updateProgress() {
    if (!widget.showProgress) return;

    final formData = _formKey.currentState?.value ?? {};
    final filledFields = formData.values
        .where((value) => value != null && value.toString().trim().isNotEmpty)
        .length;

    final newStep =
        (filledFields / widget.model.fields.length * _totalSteps).floor();

    if (newStep != _currentStep) {
      setState(() => _currentStep = newStep.clamp(0, _totalSteps - 1));
      _progressController.forward();
    }
  }

  void _validateForm() async {
    setState(() => _isValidating = true);

    await Future.delayed(const Duration(milliseconds: 300));

    final errors = <String>[];
    final formState = _formKey.currentState;

    if (formState != null) {
      for (final field in widget.model.fields.values) {
        final value = formState.fields[field.fieldName]?.value;
        final validators = _buildValidators(field);

        for (final validator in validators) {
          final error = validator(value?.toString());
          if (error != null) {
            errors.add('${field.displayName}: $error');
            break;
          }
        }
      }
    }

    setState(() {
      _validationErrors = errors;
      _isValidating = false;
    });

    widget.onValidationChanged?.call(errors.isEmpty);
  }

  void _handleFieldChanged(String fieldName, dynamic value) {
    widget.onFieldChanged?.call(fieldName, value);
    _updateProgress();
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // Add haptic feedback
      HapticFeedback.lightImpact();

      final formData = _formKey.currentState!.value;
      widget.onSubmit(formData);
    } else {
      // Show validation errors
      _validateForm();

      // Scroll to first error
      final firstErrorField = _formKey.currentState?.fields.entries
          .firstWhere((entry) => entry.value.hasError,
              orElse: () => throw StateError('No error found'))
          .key;

      if (firstErrorField != null && _focusNodes[firstErrorField] != null) {
        _focusNodes[firstErrorField]!.requestFocus();
      }
    }
  }

  void _handleSaveDraft() {
    final formData = _formKey.currentState?.value ?? {};

    // Save to local storage or send to server as draft
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.drafts, color: Colors.white),
            SizedBox(width: 12),
            Text('Draft saved successfully'),
          ],
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handleReset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 12),
            Text('Reset Form'),
          ],
        ),
        content: const Text(
          'Are you sure you want to reset all form data? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _formKey.currentState?.reset();
      setState(() {
        _currentStep = 0;
        _validationErrors.clear();
      });
      _progressController.reset();
    }
  }

  void _handleFileUpload(FieldConfig field) {
    // Implement file upload logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File upload functionality coming soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showColorPicker(FieldConfig field) {
    // Implement color picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Color picker functionality coming soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
