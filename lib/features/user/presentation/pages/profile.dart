import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/enums/profile_item_type.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

import 'package:rideme_driver/features/user/presentation/widgets/profile_item_listing_widget.dart';
import 'package:rideme_driver/features/user/presentation/widgets/user_profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<ProfileItemType> profileItemType = [
    ProfileItemType.editProfile,
    ProfileItemType.accountSettings,
    ProfileItemType.appLanguage,
    ProfileItemType.notification,
    ProfileItemType.privacyAndData,
    // ProfileItemType.payment,
    ProfileItemType.aboutRideMe,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          context.appLocalizations.profile,
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.height(context, 0.02),
        ),
        child: Column(
          children: [
            Space.height(context, 0.028),
            const UserProfileWidget(
              name: 'Simon Williams',
              phoneNumber: '23834848484',
              profileUrl: null,
            ),
            Space.height(context, 0.038),
            ...List.generate(
              profileItemType.length,
              (index) {
                return ProfileItemListingWidget(
                  type: profileItemType[index],
                  name: profileItemType[index].name,
                  showTrailing: true,
                  trailing: null,
                  onTap: () => context.pushNamed(
                    profileItemType[index].name,
                  ),
                );
              },
            ),
            ProfileItemListingWidget(
              type: ProfileItemType.deleteAccount,
              name: ProfileItemType.deleteAccount.name,
              showTrailing: false,
              trailing: null,
              onTap: () => context.pushNamed(
                ProfileItemType.deleteAccount.name,
              ),
            ),
            ProfileItemListingWidget(
              type: ProfileItemType.logout,
              name: ProfileItemType.logout.name,
              showTrailing: false,
              trailing: null,
              textColor: AppColors.rideMeErrorNormal,
              onTap: () => context.pushNamed(
                ProfileItemType.logout.name,
              ),
            ),
            const Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // BecomeADriverCard(),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
