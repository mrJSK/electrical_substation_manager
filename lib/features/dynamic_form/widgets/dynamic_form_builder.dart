import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../core/models/dynamic_model.dart';

class DynamicFormBuilder extends StatefulWidget {
  final DynamicModel model;
  final Map<String, dynamic>? initialData;
  final void Function(Map<String, dynamic>) onSubmit;
  const DynamicFormBuilder({
    super.key,
    required this.model,
    this.initialData,
    required this.onSubmit,
  });

  @override
  State<DynamicFormBuilder> createState() => _DynamicFormBuilderState();
}

class _DynamicFormBuilderState extends State<DynamicFormBuilder> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      initialValue: widget.initialData ?? {},
      child: Column(
        children: [
          ...widget.model.fields.values.map(_buildField).toList(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                widget.onSubmit(_formKey.currentState!.value);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildField(FieldConfig field) {
    final name = field.fieldName;
    switch (field.fieldType) {
      case 'number':
        return FormBuilderTextField(
          name: name,
          decoration: InputDecoration(labelText: field.displayName),
          keyboardType: TextInputType.number,
        );
      case 'boolean':
        return FormBuilderSwitch(
          name: name,
          title: Text(field.displayName),
        );
      case 'date':
        return FormBuilderDateTimePicker(
          name: name,
          decoration: InputDecoration(labelText: field.displayName),
        );
      case 'dropdown':
        return FormBuilderDropdown(
          name: name,
          decoration: InputDecoration(labelText: field.displayName),
          items: field.options!
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
        );
      default: // string
        return FormBuilderTextField(
          name: name,
          decoration: InputDecoration(labelText: field.displayName),
        );
    }
  }
}
