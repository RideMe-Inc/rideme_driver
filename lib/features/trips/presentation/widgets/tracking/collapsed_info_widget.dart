import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/trips/domain/entities/trip_tracking_details.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/injection_container.dart';

class CollapseInfoWidget extends StatelessWidget {
  final RiderInfo? user;
  final String? status, arrivedAt, endTime, totalMin;
  final int? completedStopsCount, totalStops;
  final String? totalDistanceLeft;
  final VoidCallback? onCallTap;

  const CollapseInfoWidget(
      {super.key,
      required this.status,
      required this.arrivedAt,
      required this.completedStopsCount,
      required this.totalStops,
      required this.user,
      required this.endTime,
      required this.totalMin,
      required this.totalDistanceLeft,
      required this.onCallTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.rideMeGreyNormal,
              radius: Sizes.height(context, 0.025),
              child: SvgPicture.asset(
                SvgNameConstants.userSVG,
                height: Sizes.height(context, 0.03),
              ),
            ),
            status == 'assigned' && arrivedAt != null
                ? _WaitingInfoWidget(
                    endWaitTime: endTime!,
                    userName: user?.name ?? '',
                    rating: user?.rating?.toString() ?? '0')
                : _OngoingInfoWidget(
                    min: totalMin,
                    distance: totalDistanceLeft?.toString() ?? '---',
                    totalStops: totalStops ?? 1,
                    completedStopsCount: completedStopsCount ?? 0,
                    userName: user?.name ?? '',
                    rating: user?.rating?.toString() ?? '0',
                    status: status ?? 'assigned',
                    arrivedAt: arrivedAt,
                  ),
            GestureDetector(
              onTap: onCallTap,
              child: Container(
                height: Sizes.height(context, 0.04),
                width: Sizes.height(context, 0.04),
                decoration: const BoxDecoration(
                  color: AppColors.rideMeGreyNormal,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    SvgNameConstants.phoneSVG,
                  ),
                ),
              ),
            )
          ],
        ),
        Space.height(context, 0.02),
        const Divider(
          color: AppColors.rideMeGreyNormal,
        ),
      ],
    );
  }
}

class _OngoingInfoWidget extends StatelessWidget {
  final String? min, distance, userName, rating, status;
  final String? arrivedAt;

  final int totalStops, completedStopsCount;
  const _OngoingInfoWidget({
    required this.min,
    required this.distance,
    required this.totalStops,
    required this.completedStopsCount,
    required this.userName,
    required this.status,
    required this.arrivedAt,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final tripBloc = sl<TripsBloc>();
    return SizedBox(
      width: Sizes.width(context, 0.6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgNameConstants.trackingLocationPin,
              ),
              Space.width(context, 0.024),
              Text(
                context.appLocalizations
                    .minAndDistanceLeft(min ?? '---', distance ?? '---'),
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Space.height(context, 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                status == 'assigned' && arrivedAt == null
                    ? 'Picking up '
                    : tripBloc.dropOffString(
                        totalStops: totalStops,
                        completedStopsCount: completedStopsCount),
                style: context.textTheme.displaySmall,
              ),
              if (totalStops - completedStopsCount == 1)
                Row(
                  children: [
                    Text(
                      userName ?? '---',
                      style: context.textTheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Space.width(context, 0.012),
                    Text(
                      rating ?? '0',
                      style: context.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rideMeGreyDarker,
                      ),
                    ),
                    SvgPicture.asset(
                      SvgNameConstants.starSVG,
                    )
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}

class _WaitingInfoWidget extends StatelessWidget {
  final String endWaitTime;
  final String userName, rating;
  const _WaitingInfoWidget({
    required this.endWaitTime,
    required this.userName,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.width(context, 0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: RichText(
              text: TextSpan(
                  text: 'Waiting time ending ~ ',
                  style: context.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: endWaitTime,
                      style: context.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.rideMeBlueNormal,
                      ),
                    )
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: context.textTheme.displayMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Space.width(context, 0.016),
              Text(
                rating,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.rideMeGreyDarker,
                ),
              ),
              SvgPicture.asset(
                SvgNameConstants.starSVG,
              )
            ],
          )
        ],
      ),
    );
  }
}
