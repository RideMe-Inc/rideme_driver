import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/authentication/presentation/widgets/custom_otp_field.dart';

class OTPTextfield extends StatefulWidget {
  final String timeRemaining;
  final bool hasError, canResendOTP;
  final void Function()? resendOnTap;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;

  const OTPTextfield({
    super.key,
    required this.hasError,
    required this.controller,
    required this.resendOnTap,
    required this.onChanged,
    required this.onCompleted,
    required this.canResendOTP,
    required this.timeRemaining,
  });

  @override
  State<OTPTextfield> createState() => _OTPTextfieldState();
}

class _OTPTextfieldState extends State<OTPTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //otp textfield
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width(
              context,
              0.02,
            ),
          ),
          child: CustomOtpNewField(
            hasError: widget.hasError,
            onChanged: widget.onChanged,
            controller: widget.controller,
            onCompleted: widget.onCompleted,
          ),
        ),

        Space.height(context, 0.03),

        //otp message
        GestureDetector(
          onTap: widget.resendOnTap,
          child: Center(
            child: Text(
              context.appLocalizations.didntReceiveACode(widget.timeRemaining),
              style: context.textTheme.displaySmall?.copyWith(
                color: widget.canResendOTP
                    ? AppColors.rideMeBlueNormal
                    : AppColors.rideMeGreyNormalActive,
                decoration: TextDecoration.underline,
                decorationColor: widget.canResendOTP
                    ? AppColors.rideMeBlueNormal
                    : AppColors.rideMeGreyNormalActive,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
