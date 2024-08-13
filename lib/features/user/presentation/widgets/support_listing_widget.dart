import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';

import 'package:rideme_driver/core/theme/app_colors.dart';

class SupportListingWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String? trailing, svgPath, subTitle;
  final bool? isImage;

  const SupportListingWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.subTitle,
    this.svgPath,
    this.trailing,
    this.isImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading: svgPath != null
              ? (isImage!
                  ? Image.asset(
                      svgPath!,
                      height: Sizes.height(context, 0.04),
                    )
                  : SvgPicture.asset(
                      svgPath!,
                    ))
              : null,
          title: Text(
            title,
            style: context.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subTitle != null
              ? Text(
                  subTitle!,
                  style: context.textTheme.displaySmall?.copyWith(
                    fontSize: 12,
                    color: AppColors.rideMeGreyDarkHover,
                  ),
                )
              : null,
          trailing: SvgPicture.asset(
            SvgNameConstants.forwardArrowSVG,
          ),
        ),
        const Divider(
          color: AppColors.rideMeGreyLightActive,
        )
      ],
    );
  }
}
