import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/enums/profile_item_type.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/features/user/presentation/widgets/profile_item_listing_widget.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final List<ProfileItemType> profileItemType = [
    ProfileItemType.faq,
    ProfileItemType.safety,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          context.appLocalizations.support,
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.height(context, 0.02),
        ),
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}
