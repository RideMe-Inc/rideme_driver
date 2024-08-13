import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class CustomOtpNewField extends StatefulWidget {
  final int? length;
  final bool hasError;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  final Color? focusedColor,
      focusBorderColor,
      errorBorderColor,
      defaultBorderColor,
      backgroundColor;

  final double? height, width, borderRadius, margin;
  final TextStyle? textStyle;

  const CustomOtpNewField({
    super.key,
    this.length,
    required this.controller,
    this.focusedColor,
    this.defaultBorderColor,
    this.backgroundColor,
    this.height,
    this.width,
    this.borderRadius,
    this.onChanged,
    this.onCompleted,
    this.margin,
    this.textStyle,
    this.errorBorderColor,
    this.focusBorderColor,
    required this.hasError,
  });

  @override
  State<CustomOtpNewField> createState() => _CustomOtpNewFieldState();
}

class _CustomOtpNewFieldState extends State<CustomOtpNewField> {
  @override
  Widget build(BuildContext context) {
    final otpDecoration = PinTheme(
      width: Sizes.width(context, widget.width ?? 0.15),
      height: Sizes.height(context, widget.height ?? 0.055),
      margin: EdgeInsets.symmetric(
        horizontal: widget.margin ?? Sizes.width(context, 0.004),
      ),
      textStyle: widget.textStyle ??
          context.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.rideMeBlackNormal,
          ),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(
          widget.borderRadius ?? Sizes.height(context, 0.006),
        ),
        border:
            Border.all(color: context.theme.inputDecorationTheme.fillColor!),
      ),
    );
    return Pinput(
      errorBuilder:
          !widget.hasError ? null : (errorText, pin) => const SizedBox(),
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      length: widget.length ?? 6,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      controller: widget.controller,
      forceErrorState: widget.hasError,
      defaultPinTheme: otpDecoration,
      focusedPinTheme: otpDecoration.copyWith(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          border: Border.all(
            color: AppColors.rideMeBlackNormal,
          ),
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? Sizes.height(context, 0.006),
          ),
        ),
      ),
      errorPinTheme: otpDecoration.copyWith(
        decoration: BoxDecoration(
          color: context.theme.inputDecorationTheme.fillColor,
          border: Border.all(
            color: AppColors.rideMeErrorNormal,
          ),
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? Sizes.height(context, 0.006),
          ),
        ),
      ),
    );
  }
}
