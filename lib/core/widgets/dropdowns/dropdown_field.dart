import 'package:flutter/material.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class DropdownField<T> extends StatelessWidget {
  final String hint;
  final String label;
  final dynamic value;
  final String? errorText;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;

  ///Dropdown field with labels.
  ///
  ///Provide custom validation and actions with onChanged.
  ///
  ///Make the field required with the isRequired boolean.
  ///
  ///Add [DropdownMenuItem] to the dropdown using items.
  ///
  const DropdownField({
    super.key,
    required this.hint,
    required this.label,
    required this.value,
    required this.errorText,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final outLineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.rideMeBlack20),
      borderRadius: BorderRadius.circular(
        Sizes.height(context, 0.01),
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.height(context, 0.012),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //label
          Text(
            label,
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          Space.height(context, 0.004),

          Space.height(context, 0.008),

          // dropdown field
          DropdownButtonFormField<T>(
            value: value,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.appBarTheme.foregroundColor,
            ),
            // iconSize: 0,
            decoration: InputDecoration(
              filled: false,
              contentPadding: EdgeInsets.symmetric(
                vertical: Sizes.height(context, 0.015),
                horizontal: Sizes.width(context, 0.03),
              ),
              border: outLineBorder,
              focusedBorder: outLineBorder,
              enabledBorder: outLineBorder,
              hintText: hint,
              errorText: errorText,
            ),
            items: items,
            onChanged: onChanged,
            style: theme.textTheme.displaySmall,
            dropdownColor: theme.scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }
}
