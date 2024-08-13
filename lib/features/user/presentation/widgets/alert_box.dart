import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class AlertBox extends StatelessWidget {
  final String message;
  const AlertBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.height(context, 0.026),
        horizontal: Sizes.width(context, 0.026),
      ),
      decoration: BoxDecoration(
        color: AppColors.rideMeErrorLightHover,
        borderRadius: BorderRadiusDirectional.circular(
          Sizes.height(context, 0.014),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //alert logo
          SvgPicture.asset(
            SvgNameConstants.aboutSVG,
            height: Sizes.height(context, 0.024),
          ),

          Space.width(context, 0.032),

          //message
          Expanded(
            child: Text(
              message,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.rideMeBlackNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
