import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_details.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/destination_pickup_widget.dart';

class TripHistoryCard extends StatelessWidget {
  final AllTripDetails tripDetails;
  final VoidCallback onTap;
  const TripHistoryCard({
    super.key,
    required this.tripDetails,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(top: Sizes.height(context, 0.016)),
          width: double.infinity,
          padding: EdgeInsets.only(
            top: Sizes.height(context, 0.008),
            bottom: Sizes.height(context, 0.015),
            left: Sizes.height(context, 0.012),
            right: Sizes.height(context, 0.01),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.rideMeGreyLightActive,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //date created
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  DateFormat('dd MMMM y, h:mm a').format(
                    DateTime.parse(tripDetails.createdAt!),
                  ),
                  style: context.textTheme.displaySmall?.copyWith(
                    color: AppColors.rideMeGreyDark,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),

              Space.height(context, 0.007),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //car type and destinations
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: Sizes.height(context, 0.025),
                        backgroundColor: AppColors.rideMeBlack20,
                        child: SvgPicture.asset(
                          SvgNameConstants.carTypeSVG,
                        ),
                      ),
                      Space.width(context, 0.034),
                      TripPickUpDestinationWidget(
                        pickup: tripDetails.pickupAddress ?? '',
                        dropoff: tripDetails.dropOffAddress ?? '',
                      ),
                    ],
                  ),

                  //amount
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.appLocalizations.amountAndCurrency(
                            tripDetails.totalAmount?.toString() ?? '0'),
                        style: context.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if ((tripDetails.status ?? 'completed') == 'cancelled')
                        Text(
                          context.appLocalizations.cancelled,
                          style: context.textTheme.displaySmall?.copyWith(
                            color: AppColors.rideMeErrorNormal,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.rideMeErrorNormal,
                          ),
                        )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
