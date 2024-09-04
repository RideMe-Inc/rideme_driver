import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double? height, width;
  final Color? indicatorColor;
  final Color? backgroundColor;
  const LoadingIndicator({
    super.key,
    this.height,
    this.width,
    this.indicatorColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? context.theme.scaffoldBackgroundColor,
      width: width,
      height: height ?? Sizes.height(context, 0.1),
      child: Center(
        child: CircularProgressIndicator(
          color: indicatorColor ?? AppColors.rideMeBlueNormal,
        ),
      ),
    );
  }
}
