import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/user/presentation/widgets/user_initials.dart';

class UserProfileWidget extends StatelessWidget {
  final String? profileUrl;
  final String phoneNumber, name;

  const UserProfileWidget({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: Sizes.height(context, 0.028),
          backgroundColor: AppColors.rideMeBlackNormal,
          backgroundImage: profileUrl == null
              ? null
              : CachedNetworkImageProvider(profileUrl!),
          child: profileUrl != null ? null : UserInitials(name: name),
        ),
        Space.width(context, 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // number
            Text(
              name,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Space.height(context, 0.004),
            Text(
              phoneNumber,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.rideMeGreyDarkHover,
              ),
            ),
          ],
        )
      ],
    );
  }
}
