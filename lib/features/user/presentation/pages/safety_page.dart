import 'package:flutter/material.dart';
import 'package:rideme_driver/assets/images/image_name_constants.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/mixins/url_launcher_mixin.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/features/user/presentation/widgets/alert_box.dart';
import 'package:rideme_driver/features/user/presentation/widgets/support_listing_widget.dart';

class SafetyPage extends StatelessWidget with UrlLauncherMixin {
  const SafetyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.appLocalizations.safety,
          style: context.textTheme.headlineSmall?.copyWith(
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.height(context, 0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.height(context, 0.04),
            AlertBox(
              message: context.appLocalizations.safetyNotice,
            ),
            Space.height(context, 0.024),
            Text(
              context.appLocalizations.contactSupport,
              style: context.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Space.height(context, 0.01),
            SupportListingWidget(
              onTap: () => launchCallUrl('82832873838'),
              title: context.appLocalizations.callCustomerService,
              subTitle: '17384738384',
              svgPath: SvgNameConstants.phoneSVG,
              isImage: false,
            ),
            Space.height(context, 0.028),
            Text(
              context.appLocalizations.emergencyServices,
              style: context.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Space.height(context, 0.01),
            SupportListingWidget(
              onTap: () => launchCallUrl('911'),
              title: context.appLocalizations.fire,
              subTitle: '911',
              svgPath: ImageNameConstants.fireServiceIMG,
            ),
            SupportListingWidget(
              onTap: () => launchCallUrl('911'),
              title: context.appLocalizations.ambulance,
              subTitle: '911',
              svgPath: ImageNameConstants.ambulanceIMG,
            ),
            SupportListingWidget(
              onTap: () => launchCallUrl('911'),
              title: context.appLocalizations.police,
              subTitle: '911',
              svgPath: ImageNameConstants.policeIMG,
            ),
          ],
        ),
      ),
    );
  }
}
