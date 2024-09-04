import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';

import 'package:rideme_driver/core/theme/app_colors.dart';

class TripPickUpDestinationWidget extends StatelessWidget {
  final String pickup, dropoff;
  final String? pickupTime, dropoffTime;
  const TripPickUpDestinationWidget({
    super.key,
    required this.pickup,
    required this.dropoff,
    this.pickupTime,
    this.dropoffTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LocationTile(
          isStart: true,
          address: pickup,
          time: pickupTime,
        ),
        Padding(
          padding: EdgeInsets.only(left: Sizes.height(context, 0.005)),
          child: const DottedLine(
            direction: Axis.vertical,
            dashColor: AppColors.rideMeBlackNormal,
            lineLength: 35,
            lineThickness: 2,
            dashLength: 35,
          ),
        ),
        _LocationTile(
          isStart: false,
          address: dropoff,
          time: dropoffTime,
        )
      ],
    );
  }
}

class _LocationTile extends StatelessWidget {
  final bool isStart;
  final String address;
  final String? time;
  const _LocationTile({
    required this.isStart,
    required this.address,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(isStart
                ? SvgNameConstants.dropOffPointActiveSVG
                : SvgNameConstants.destinationSVG),
            Space.width(context, 0.032),
            SizedBox(
              width: Sizes.width(context, 0.5),
              child: Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        if (time != null)
          Text(
            DateFormat('h:mm a').format(
              DateTime.parse(time!),
            ),
            style: context.textTheme.displaySmall?.copyWith(
              color: AppColors.rideMeGreyNormalActive,
              fontWeight: FontWeight.w500,
            ),
          )
      ],
    );
  }
}
