import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';

import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/destination_pickup_widget.dart';

class MyLocationSectionWidget extends StatelessWidget {
  final String pickUp, dropOff;
  final VoidCallback? onCancelTap;

  const MyLocationSectionWidget({
    super.key,
    required this.pickUp,
    required this.dropOff,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TripPickUpDestinationWidget(
              pickup: pickUp,
              dropoff: dropOff,
            ),
            SizedBox(
              width: Sizes.width(context, 0.3),
              child: _CancelTripButton(
                onTap: onCancelTap,
              ),
            ),
          ],
        ),
        Space.height(context, 0.016),
        Space.height(context, 0.014),
        const Divider(
          color: AppColors.rideMeGreyLightActive,
        ),
      ],
    );
  }
}

class _CancelTripButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _CancelTripButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: Sizes.height(context, 0.015),
          backgroundColor: AppColors.rideMeGreyNormal,
          child: SvgPicture.asset(SvgNameConstants.cancelTrip),
        ),
        title: Text(
          context.appLocalizations.cancelTrip,
          style: context.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.rideMeErrorDarkActive,
          ),
        ));
  }
}
