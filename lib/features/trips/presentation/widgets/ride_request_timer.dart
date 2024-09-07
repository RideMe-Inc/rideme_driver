import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';

import 'package:rideme_driver/core/theme/app_colors.dart';

class RideRequestTimer extends StatefulWidget {
  final int seconds;
  final Timer? timer;
  const RideRequestTimer({
    super.key,
    required this.timer,
    required this.seconds,
  });

  @override
  State<RideRequestTimer> createState() => _RideRequestTimerState();
}

class _RideRequestTimerState extends State<RideRequestTimer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.rideMeBlackDark,
          ),
          child: Center(
            child: Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.rideMeBlueNormal,
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      value: (widget.seconds / 15) * 1,
                      color: AppColors.rideMeBackgroundLight,
                      strokeWidth: 6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: SvgPicture.asset(
                        SvgNameConstants.timerObjectSVG,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
