import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/destination_pickup_widget.dart';

class MyLocationSectionWidget extends StatelessWidget {
  final String pickUp, dropOff;
  final bool? editable;
  const MyLocationSectionWidget({
    super.key,
    required this.pickUp,
    required this.dropOff,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TripPickUpDestinationWidget(
          pickup: pickUp,
          dropoff: dropOff,
        ),
        Space.height(context, 0.016),
        if (editable!)
          Row(
            children: [
              SvgPicture.asset(SvgNameConstants.addDestinationSVG),
              Space.width(context, 0.032),
              Text(
                context.appLocalizations.addDestination,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.rideMeBlueNormal,
                ),
              )
            ],
          ),
        Space.height(context, 0.014),
        const Divider(
          color: AppColors.rideMeGreyLightActive,
        ),
      ],
    );
  }
}
