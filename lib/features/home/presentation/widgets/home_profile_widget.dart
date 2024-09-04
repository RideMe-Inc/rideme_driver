import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:rideme_driver/features/user/presentation/widgets/user_initials.dart';

import '../../../../core/theme/app_colors.dart';

class HomeUserProfileWidget extends StatelessWidget {
  final User? user;

  const HomeUserProfileWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    bool isOffline = (user?.availability ?? 'offline') == 'offline';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: Sizes.height(context, 0.024),
              backgroundColor: AppColors.rideMeBlackNormal,
              backgroundImage: user?.profileUrl == null
                  ? null
                  : CachedNetworkImageProvider(user!.profileUrl!),
              child: user?.profileUrl != null
                  ? null
                  : UserInitials(
                      name:
                          '${user?.firstName ?? 'U'} ${user?.lastName ?? 'U'}'),
            ),
            Space.width(context, 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // number
                Text(
                  '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                  style: context.textTheme.displayLarge
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Space.height(context, 0.004),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: Sizes.height(context, 0.005),
                      backgroundColor: isOffline
                          ? AppColors.rideMeGreyDark
                          : AppColors.rideMeBlueNormal,
                    ),
                    Space.width(context, 0.02),
                    Text(
                      isOffline
                          ? context.appLocalizations.offlineStatus
                          : context.appLocalizations.onlineStatus,
                      style: context.textTheme.displaySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isOffline
                            ? AppColors.rideMeGreyDarkActive
                            : AppColors.rideMeBlueNormal,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Text(
              '${user?.rating ?? 0.0}',
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.rideMeBlackNormal,
              ),
            ),
            Space.width(context, 0.012),
            SvgPicture.asset(
              SvgNameConstants.starSVG,
            ),
          ],
        )
      ],
    );
  }
}
