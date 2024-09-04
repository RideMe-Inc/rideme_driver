import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/enums/profile_item_type.dart';
import 'package:rideme_driver/core/mixins/url_launcher_mixin.dart';

import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/user/presentation/provider/user_provider.dart';
import 'package:rideme_driver/features/user/presentation/widgets/confirm_logout.dart';
import 'package:rideme_driver/features/user/presentation/widgets/profile_item_listing_widget.dart';
import 'package:rideme_driver/features/user/presentation/widgets/user_profile_widget.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> with UrlLauncherMixin {
  late UserProvider provider;

  final List<ProfileItemType> profileItemType = [
    ProfileItemType.editProfile,
    ProfileItemType.trips,
    ProfileItemType.earnings,
    ProfileItemType.safety,
  ];
  @override
  Widget build(BuildContext context) {
    provider = context.watch<UserProvider>();
    return Drawer(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.height(context, 0.02),
            ),
            child: Column(
              children: [
                Space.height(context, 0.028),
                UserProfileWidget(
                  name:
                      '${provider.user?.firstName ?? ''} ${provider.user?.lastName ?? ''}',
                  phoneNumber: provider.user?.phone ?? '',
                  profileUrl: provider.user?.profileUrl,
                  rating: provider.user?.rating,
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
                  type: ProfileItemType.aboutRideMe,
                  name: ProfileItemType.aboutRideMe.name,
                  showTrailing: false,
                  trailing: null,
                  onTap: () => launchLink('https://rideme.app'),
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
                  onTap: () => showAdaptiveDialog(
                    context: context,
                    builder: (context) => const ConfirmLogoutDialog(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
