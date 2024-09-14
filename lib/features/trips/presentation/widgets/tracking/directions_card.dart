import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

class DirectionsCard extends StatelessWidget {
  final String maneuverIcon, direction, endLocation, distance;
  const DirectionsCard(
      {super.key,
      required this.maneuverIcon,
      required this.direction,
      required this.endLocation,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: Sizes.height(context, 0.012),
        horizontal: Sizes.height(context, 0.018),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.rideMeBlueDarker,
      ),
      child: Row(
        children: [
          //manuever and distance
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                maneuverIcon,
                height: Sizes.height(context, 0.04),
              ),
              Space.height(context, 0.004),
              Text(
                distance,
                style: context.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.rideMeBackgroundLight),
              )
            ],
          ),

          Space.width(context, 0.048),

          //direction and end location
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Sizes.width(context, 0.6),
                child: Text(
                  direction,
                  style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.rideMeBackgroundLight),
                ),
              ),
              Space.height(context, 0.01),
              Row(
                children: [
                  SvgPicture.asset(
                    SvgNameConstants.locationPin,
                  ),
                  Space.width(context, 0.016),
                  SizedBox(
                    width: Sizes.width(context, 0.55),
                    child: Text(
                      endLocation,
                      style: context.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rideMeGreyNormalHover,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
