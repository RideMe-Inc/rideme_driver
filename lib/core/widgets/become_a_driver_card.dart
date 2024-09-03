import 'package:flutter/material.dart';
import 'package:rideme_driver/assets/images/image_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/mixins/url_launcher_mixin.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class BecomeADriverCard extends StatelessWidget with UrlLauncherMixin {
  const BecomeADriverCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchLink('https://rideme.app/#become-a-rider'),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.height(context, 0.017),
          vertical: Sizes.height(context, 0.014),
        ),
        decoration: BoxDecoration(
          color: AppColors.rideMeBlueLightActive,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //info
            SizedBox(
              width: Sizes.width(context, 0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title

                  Text(
                    '  context.appLocalizations.becomeADriver',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Space.height(context, 0.005),

                  //info
                  Text(
                    '   context.appLocalizations.becomeADriverInfo',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontSize: 13,
                      color: AppColors.rideMeGreyDarker,
                    ),
                  ),
                ],
              ),
            ),

            //image
            SizedBox(
              height: Sizes.height(context, 0.06),
              child: Image.asset(
                ImageNameConstants.driverIMG,
              ),
            )
          ],
        ),
      ),
    );
  }
}
