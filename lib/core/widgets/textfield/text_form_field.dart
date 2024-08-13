import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rideme_driver/core/widgets/textfield/generic_textfield_widget.dart';

class TextFormBuilderField extends StatelessWidget {
  final bool enabled;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? showSuffixIcon;
  final String? initialValue;
  final String name, label, hint;
  final void Function()? suffixOnTap;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const TextFormBuilderField({
    super.key,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnTap,
    this.initialValue,
    this.keyboardType,
    this.showSuffixIcon,
    this.inputFormatters,
    this.focusNode,
    this.enabled = true,
    required this.name,
    required this.hint,
    required this.label,
    required this.onChanged,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      onChanged: onChanged,
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => GenericTextField(
        hint: hint,
        focus: focusNode,
        maxLines: 1,
        autoFocus: true,
        label: label,
        enabled: enabled,
        maxLength: maxLength,
        suffixIcon: suffixIcon,
        controller: controller,
        prefixIcon: prefixIcon,
        suffixOnTap: suffixOnTap,
        onChanged: field.didChange,
        errorText: field.errorText,
        keyboardType: keyboardType,
        showSuffixIcon: showSuffixIcon,
        inputFormatters: inputFormatters,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
