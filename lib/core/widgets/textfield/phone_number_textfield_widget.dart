import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class PhoneNumberTextField extends StatefulWidget {
  final PhoneNumber number;
  final TextEditingController? controller;
  final void Function(bool)? onInputValidated;
  final void Function(PhoneNumber)? onInputChanged;

  ///Creates a phone number textfield with a label.
  const PhoneNumberTextField({
    super.key,
    this.controller,
    required this.number,
    required this.onInputChanged,
    required this.onInputValidated,
  });

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    final outLineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.height(context, 0.005)),
      borderSide: const BorderSide(
        color: AppColors.rideMeBlack20,
      ),
    );

    return InternationalPhoneNumberInput(
      cursorColor: AppColors.rideMeBlackNormalHover,

      initialValue: widget.number,
      countries: const ['US', 'GH'],
      // selectorButtonOnErrorPadding: 0,
      onInputChanged: widget.onInputChanged,
      selectorConfig: const SelectorConfig(),
      spaceBetweenSelectorAndTextField: 0,
      textFieldController: widget.controller,
      onInputValidated: widget.onInputValidated,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputDecoration: InputDecoration(
        filled: false,
        hintStyle: context.theme.inputDecorationTheme.hintStyle,
        errorStyle: context.theme.inputDecorationTheme.errorStyle,
        contentPadding: EdgeInsets.symmetric(
          vertical: Sizes.height(context, 0.015),
          horizontal: Sizes.width(context, 0.03),
        ),
        border: outLineBorder,
        focusedBorder: outLineBorder,
        enabledBorder: outLineBorder,
        hintText: context.appLocalizations.mobileNumber,
      ),
    );
  }
}
