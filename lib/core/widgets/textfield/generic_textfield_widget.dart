import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

/// ### GenericTextField Widget
///
/// The `GenericTextField` widget is a customizable text input field.
/// It provides flexibility in customization options such as hint text, label, error handling, keyboard type, and more.
///
/// #### Notes:
/// - The widget automatically handles text field styling based on the provided properties and the current context.theme.
/// - It uses `TextEditingController` to control the text field's content and provide additional functionalities like clearing the text.
/// - The `GenericTextField` widget encapsulates a `TextField` widget and adds additional functionalities such as label, error handling, and suffix icon.
///
/// #### Example Usage:
/// ```dart
/// GenericTextField(
///   hint: 'Enter your password',
///   label: 'Password',
///   controller: _passwordController,
///   isPasswordField: true,
///   onChanged: (value) {
///     // Handle password input changes
///   },
///   showPassword: _showPassword,
///   suffixOnTap: () {
///     setState(() {
///       _showPassword = !_showPassword;
///     });
///   },
/// )
/// ```

class GenericTextField extends StatelessWidget {
  /// A String representing the hint text displayed in the text field when it's empty.
  final String hint;

  /// An optional String representing the label text displayed above the text field.
  final String? label;

  final FocusNode? focus;

  ///  An optional integer representing the maximum number of lines the text field can have.
  ///  Defaults to 1 if not provided.
  final int? maxLines;

  ///  An optional integer representing the maximum number of characters the text field can take.
  final int? maxLength;

  ///  An optional input formatters list for formatting the textfield input.
  final List<TextInputFormatter>? inputFormatters;

  /// An optional String representing the error text to display below the text field when there's an error.
  final String? errorText;

  /// An optional boolean flag indicating whether to show the suffix icon.
  final bool? showSuffixIcon;

  final bool? filled;

  /// A boolean flag indicating whether to focus the textfield automatically.
  final bool autoFocus;

  /// An optional TextInputType specifying the type of keyboard to display.
  final TextInputType? keyboardType;

  /// An optional Widget for the prefix.
  final Widget? prefixIcon;

  /// An optional Widget for the suffix.
  final Widget? suffixIcon;

  /// An optional callback function that is called when the suffix icon is tapped.
  final void Function()? suffixOnTap;

  /// A TextEditingController used to control the text field's text and selection.
  final TextEditingController controller;

  /// An optional `TextInputAction` specifying the action button to display on the keyboard.
  final TextInputAction? textInputAction;

  /// An optional callback function that is called when the text field's content changes.
  final void Function(String)? onChanged;

  /// An optional boolean flag indicating whether the text field is active.
  final bool? enabled;

  /// An optional callback function that is called when the text field is tapped
  final void Function()? onTap;

  /// ### Constructor for `GenericTextField` widget
  ///
  /// #### Parameters:
  /// - `hint` (required): A String representing the hint text displayed in the text field when it's empty.
  /// - `controller` (required): A `TextEditingController` used to control the text field's text and selection.
  /// - `prefixIcon`: An optional Widget for the prefix.
  /// - `suffixIcon`: An optional Widget for the suffix.
  /// - `label`: An optional String representing the label text displayed above the text field.
  /// - `maxLines`: An optional integer representing the maximum number of lines the text field can have. Defaults to 1 if not provided.
  /// - `maxLength`: An optional integer representing the maximum number of characters the text field can have.
  /// - `inputFormatters`: An optional input formatters list for formatting the textfield input.
  /// - `onChanged`: An optional callback function that is called when the text field's content changes.
  /// - `errorText`: An optional String representing the error text to display below the text field when there's an error.
  /// - `suffixOnTap`: An optional callback function that is called when the suffix icon is tapped.
  /// - `showPassword`: An optional boolean flag indicating whether to show the password. Only applicable if isPasswordField is true.
  /// - `showSuffixIcon`: An optional boolean flag indicating whether to show the show the suffix icon.
  /// - `autoFocus`: A boolean flag indicating whether to focus the textfield automatically.
  /// - `keyboardType`: An optional `TextInputType` specifying the type of keyboard to display.
  /// - `textInputAction`: An optional `TextInputAction` specifying the action button to display on the keyboard.
  /// - `textCapitalization`: An optional `TextCapitalization` specifying how the text should be capitalized.
  /// - `isSearchField`: An optional boolean flag indicating whether the text field is for search input. Defaults to false if not provided.
  /// - `isPasswordField`: An optional boolean flag indicating whether the text field is for password input. Defaults to false if not provided.

  const GenericTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.label,
    this.onTap,
    this.focus,
    this.enabled,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnTap,
    this.keyboardType,
    this.showSuffixIcon,
    this.inputFormatters,
    this.textInputAction,
    this.autoFocus = false,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final outLineBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: errorText != null
            ? AppColors.rideMeErrorNormalHover
            : AppColors.rideMeBlack20,
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
          if (label != null)
            //label
            Padding(
              padding: EdgeInsets.only(
                bottom: Sizes.height(context, 0.008),
              ),
              child: Text(
                label!,
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          //Textfield
          GestureDetector(
            onTap: onTap,
            child: TextField(
              focusNode: focus,
              enabled: enabled,
              autofocus: autoFocus,
              onChanged: onChanged,
              controller: controller,
              maxLines: maxLines ?? 1,
              maxLength: maxLength,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              onTapOutside: (enabled ?? false)
                  ? null
                  : (_) => FocusManager.instance.primaryFocus?.unfocus(),
              cursorColor: AppColors.rideMeBlackNormalHover,
              buildCounter: (context,
                      {required currentLength,
                      required isFocused,
                      required maxLength}) =>
                  null,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: enabled ?? true ? null : AppColors.rideMeGreyDarkHover,
              ),
              decoration: InputDecoration(
                filled: filled,
                fillColor: AppColors.rideMeGreyNormal,
                hintText: hint,
                hintStyle: context.textTheme.displaySmall?.copyWith(
                  color: AppColors.rideMeGreyNormalActive,
                ),
                errorMaxLines: 2,
                errorText: errorText,
                border: outLineBorder,
                errorBorder: outLineBorder,
                enabledBorder: outLineBorder,
                focusedBorder: outLineBorder,
                disabledBorder: outLineBorder,
                focusedErrorBorder: outLineBorder,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Sizes.height(context, 0.018),
                  horizontal: Sizes.width(context, 0.02),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
