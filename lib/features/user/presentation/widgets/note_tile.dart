//NOTE TILE
import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class NoteTile extends StatelessWidget {
  final String note;
  final int number;
  const NoteTile({
    required this.note,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Sizes.height(context, 0.03),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //circle avatar
          CircleAvatar(
            radius: Sizes.height(context, 0.014),
            backgroundColor: AppColors.rideMeBlack80,
            child: Text(
              number.toString(),
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.rideMeBackgroundLight,
              ),
            ),
          ),

          Space.width(context, 0.02),

          //note
          Expanded(
            child: Text(
              note,
              style: context.textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
}
