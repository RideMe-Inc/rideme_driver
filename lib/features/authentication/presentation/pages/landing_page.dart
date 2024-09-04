import 'package:flutter/material.dart';
import 'package:rideme_driver/assets/images/image_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          ImageNameConstants.onboardingIMG1,
          fit: BoxFit.cover,
        ),
      ),
      bottomSheet: Container(
        constraints: BoxConstraints(minHeight: Sizes.height(context, 0.28)),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: Sizes.height(context, 0.01),
            right: Sizes.height(context, 0.01),
            top: Sizes.height(context, 0.009),
            bottom: Sizes.height(context, 0.017),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Space.height(context, 0.02),

              //TITLE
              Text(
                context.appLocalizations.earnWithRideMe,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Space.height(context, 0.016),

              //BODY
              Text(
                context.appLocalizations.earnWithRideMeInfo,
                style: context.textTheme.displayMedium?.copyWith(
                  color: AppColors.rideMeBlackLightActive,
                ),
                textAlign: TextAlign.center,
              ),

              Space.height(context, 0.03),

              //BUTTONS

              //NEW TO RIDE ME

              GenericButton(
                onTap: () {},
                label: context.appLocalizations.signUp,
                isActive: true,
                borderRadius: 0.026,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
