import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

showSuccessPopUp(String message, BuildContext context) {
  return Flushbar(
    borderRadius: BorderRadius.circular(
      Sizes.height(context, 0.008),
    ),
    margin: EdgeInsets.symmetric(
      horizontal: Sizes.width(context, 0.032),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: Sizes.width(context, 0.066),
      vertical: Sizes.height(context, 0.014),
    ),
    messageText: Wrap(
      children: [
        Text(
          message,
          style: context.textTheme.displaySmall?.copyWith(
            fontSize: 14,
            color: AppColors.rideMeWhite400,
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.rideMeBlueNormal,
    duration: const Duration(seconds: 4),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
  )..show(context);
}
