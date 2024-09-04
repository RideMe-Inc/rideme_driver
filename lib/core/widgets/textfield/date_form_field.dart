import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class DateFormBuilderField extends StatelessWidget {
  final String label;
  final bool enabled;
  final String fieldName;
  final DateTime? initialValue;
  final TextEditingController controller;
  final void Function(DateTime?)? onChanged;
  final String? Function(DateTime?)? validator;

  //Creates a Date form field with FormBuilderDateTimePicker
  const DateFormBuilderField({
    super.key,
    this.initialValue,
    this.enabled = true,
    required this.label,
    required this.fieldName,
    required this.onChanged,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final outLineBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.rideMeBlack20,
      ),
      borderRadius: BorderRadius.circular(
        Sizes.height(context, 0.005),
      ),
    );
    return Padding(
      padding: EdgeInsets.only(top: Sizes.height(context, 0.02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.displaySmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          Space.height(context, 0.004),

          //expiry date
          FormBuilderDateTimePicker(
            name: fieldName,
            enabled: enabled,
            validator: validator,
            onChanged: onChanged,
            controller: controller,
            inputType: InputType.date,
            initialValue: initialValue,
            style: context.textTheme.displaySmall,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              filled: false,
              hintText: '(DD/MM/YYYY)',
              contentPadding: EdgeInsets.symmetric(
                vertical: Sizes.height(context, 0.015),
                horizontal: Sizes.width(context, 0.02),
              ),
              border: outLineBorder,
              focusedBorder: outLineBorder,
              enabledBorder: outLineBorder,
              disabledBorder: outLineBorder,
            ),
          ),
        ],
      ),
    );
  }
}
