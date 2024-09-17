import 'package:flutter/material.dart';

import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class TrackingInfoTileWidget extends StatelessWidget {
  final String label;
  final String? value;
  const TrackingInfoTileWidget(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizes.height(context, 0.012)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.rideMeGreyDarker,
            ),
          ),
          Text(
            value ?? '---',
            style: context.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
