import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/mixins/location_mixin.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/destination_pickup_widget.dart';
import 'package:rideme_driver/features/trips/presentation/widgets/payment/payment_type_selection.dart';
import 'package:rideme_driver/injection_container.dart';

class TripHistoryDetailsPage extends StatefulWidget {
  final String tripId;
  const TripHistoryDetailsPage({
    super.key,
    required this.tripId,
  });

  @override
  State<TripHistoryDetailsPage> createState() => _TripHistoryDetailsPageState();
}

class _TripHistoryDetailsPageState extends State<TripHistoryDetailsPage>
    with LocationMixin {
  final tripsBloc = sl<TripsBloc>();

  fetchTripDetails() {
    final params = {
      'locale': context.read<LocaleProvider>().locale,
      'bearer': context.read<AuthenticationProvider>().token!,
      'urlParameters': {
        'id': widget.tripId,
      },
    };

    tripsBloc.add(GetTripInfoEvent(params: params));
  }

  @override
  void initState() {
    fetchTripDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.appLocalizations.tripDetails,
          style: context.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer(
        bloc: tripsBloc,
        listener: (context, state) {
          if (state is GenericTripsError) {
            showErrorPopUp(state.errorMessage, context);
          }
        },
        builder: (context, state) {
          if (state is GetTripLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is GenericTripsError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'An error occured',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: AppColors.rideMeErrorNormal,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    fetchTripDetails();
                  },
                  child: Text(
                    context.appLocalizations.retry,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: AppColors.rideMeBlueNormal,
                      decorationColor: AppColors.rideMeBlueNormal,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            );
          }

          if (state is GetTripLoaded) {
            final tripDetails = state.tripDetailsInfo.tripDestinationData;

            final mapImageUrl = staticMapUrl(
              lat: tripDetails?.pickupLat?.toDouble() ?? 0,
              lng: tripDetails?.pickupLng?.toDouble() ?? 0,
              polyline: tripDetails?.polyline,
              dropOffLlat: tripDetails?.destinations?.last.lat?.toDouble() ?? 0,
              dropOffLng: tripDetails?.destinations?.last.lng?.toDouble() ?? 0,
            );
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //rider info and date
                  Padding(
                    padding: EdgeInsets.all(Sizes.height(context, 0.02)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.appLocalizations.tripRiderIs('N/A'),
                              style: context.textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Space.height(context, 0.004),
                            Text(DateFormat('dd-mm-yyy/h:mm a').format(
                              DateTime.parse(tripDetails!.createdAt!),
                            ))
                          ],
                        ),

                        //profile
                        Container(
                          height: Sizes.height(context, 0.05),
                          width: Sizes.height(context, 0.05),
                          decoration: BoxDecoration(
                            color: AppColors.rideMeGreyNormal,
                            borderRadius: BorderRadius.circular(9),
                            // image: tripDetails.driver?.profileURL == null
                            //     ? null
                            //     : DecorationImage(
                            //         image: CachedNetworkImageProvider(
                            //             tripDetails.driver!.profileURL!),
                            //       ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Space.height(context, 0.024),

                  //static map url
                  Container(
                    alignment: Alignment.center,
                    height: Sizes.height(context, 0.13),
                    decoration: BoxDecoration(
                      color: AppColors.rideMeGreyNormal,
                      borderRadius: BorderRadius.circular(
                        Sizes.height(context, 0.008),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          mapImageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Space.height(context, 0.024),

                  Padding(
                    padding: EdgeInsets.all(Sizes.height(context, 0.02)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TRIP DETAILS
                        Text(
                          context.appLocalizations.tripDetails,
                          style: context.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Space.height(context, 0.02),

                        TripPickUpDestinationWidget(
                          pickup: tripDetails.pickupAddress ?? '',
                          dropoff: tripDetails.destinations?.last.address ?? '',
                          pickupTime: tripDetails.createdAt,
                          dropoffTime: tripDetails.completedAt,
                        ),

                        _TripDetailsListingWidget(
                            label: context.appLocalizations.tripDistance,
                            value: '0km'),
                        Space.height(context, 0.026),

                        //PAYMENT DETAILS

                        Text(
                          context.appLocalizations.paymentDetails,
                          style: context.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        _TripDetailsListingWidget(
                          label: context.appLocalizations.initialAmount,
                          value: context.appLocalizations.amountAndCurrency(
                              tripDetails.amountCharged?.toString() ?? '0'),
                        ),
                        _TripDetailsListingWidget(
                          label: context.appLocalizations.discount,
                          valueColor: AppColors.rideMeBlueNormal,
                          value: context.appLocalizations.amountAndCurrency(
                              tripDetails.discountAmount?.toString() ?? '0'),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    color: AppColors.rideMeBackgroundLight,
                    margin: EdgeInsets.only(top: Sizes.height(context, 0.027)),
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.height(context, 0.02)),
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.appLocalizations.total,
                          style: context.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Space.height(context, 0.016),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //indicator
                            Row(
                              children: [
                                Image.asset(
                                  PaymentTypes.values
                                      .where(
                                        (element) =>
                                            element.name ==
                                            tripDetails.paymentMethod,
                                      )
                                      .first
                                      .imagePath,
                                  height: Sizes.height(context, 0.028),
                                ),
                                Space.width(context, 0.032),
                                Text(
                                  PaymentTypes.values
                                      .where(
                                        (element) =>
                                            element.name ==
                                            tripDetails.paymentMethod,
                                      )
                                      .first
                                      .type,
                                  style:
                                      context.textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),

                            //amount

                            Text(
                              context.appLocalizations.amountAndCurrency(
                                  tripDetails.totalAmount.toString()),
                              style: context.textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Space.height(context, 0.04),
                        GenericButton(
                          onTap: () {},
                          label: context.appLocalizations.reportTrip,
                          isActive: true,
                          buttonColor: AppColors.rideMeErrorNormal,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Space.height(context, 0);
        },
      ),
    );
  }
}

class _TripDetailsListingWidget extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  const _TripDetailsListingWidget({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.height(context, 0.016)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.displaySmall?.copyWith(
              color: AppColors.rideMeGreyNormalActive,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: context.textTheme.displaySmall?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
