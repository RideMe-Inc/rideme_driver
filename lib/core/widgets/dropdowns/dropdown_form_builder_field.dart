import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rideme_driver/core/widgets/dropdowns/dropdown_field.dart';

class DropdownFormBuilderField<T> extends StatelessWidget {
  final String hint;
  final String label;
  final String fieldName;
  final void Function(T?) onChanged;
  final String? Function(T?) validator;
  final List<DropdownMenuItem<T>>? items;

  const DropdownFormBuilderField({
    super.key,
    required this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.fieldName,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: fieldName,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => DropdownField(
        hint: hint,
        label: label,
        value: field.value,
        errorText: field.errorText,
        onChanged: (p0) {
          onChanged(p0);
          field.didChange(p0);
        },
        items: items,
      ),
    );
  }
}
