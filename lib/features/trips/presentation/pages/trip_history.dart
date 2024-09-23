import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rideme_driver/core/extensions/context_extensions.dart';

import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/trips/domain/entities/all_trips_details.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';

import 'package:rideme_driver/features/trips/presentation/widgets/history_sections.dart';
import 'package:rideme_driver/injection_container.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  final tripsBloc = sl<TripsBloc>();

  ScrollController historyListingController = ScrollController();

  fetchDetails({
    required List<AllTripDetails> currentList,
    required int page,
  }) {
    final params = {
      'locale': context.read<LocaleProvider>().locale,
      'bearer': context.read<AuthenticationProvider>().token!,
      'queryParameters': {
        'page': page.toString(),
      },
    };

    tripsBloc.add(GetAllTripsEvent(params: params, currentList: currentList));
  }

  @override
  void initState() {
    fetchDetails(
      currentList: [],
      page: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          context.appLocalizations.tripHistory,
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.height(context, 0.02)),
        child: Column(
          children: [
            Space.height(context, 0.035),
            BlocConsumer(
              listener: (context, state) {},
              bloc: tripsBloc,
              buildWhen: (previous, current) =>
                  previous != current && current is GetAllTripLoaded,
              builder: (context, state) {
                if (state is GenericTripsError) {
                  return Expanded(
                      child: Column(
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
                          fetchDetails(currentList: [], page: 1);
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
                  ));
                }

                if (state is GetAllTripLoaded) {
                  final tripHistory =
                      tripsBloc.getCategorizedTripsHistory(state.tripDetails);

                  final currentPage = state
                          .allTripsInfo.allTripsData?.pagination?.currentPage ??
                      0;
                  final lastPage =
                      state.allTripsInfo.allTripsData?.pagination?.lastPage ??
                          0;

                  historyListingController.addListener(
                    () {
                      //check if scrolled to the end

                      if (historyListingController.position.pixels ==
                              historyListingController
                                  .position.maxScrollExtent &&
                          (currentPage < lastPage)) {
                        fetchDetails(
                          currentList: state.tripDetails,
                          page: currentPage + 1,
                        );
                      }
                    },
                  );

                  return state.tripDetails.isEmpty
                      ? const Expanded(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.asset(
                                //   ImageNameConstants.noTripsImagePinIMG,
                                //   width: Sizes.width(context, 0.3),
                                //   height: Sizes.height(context, 0.145),
                                // ),
                                // Space.height(context, 0.038),
                                // Text(
                                //   context.appLocalizations.noTripHistoryYet,
                                //   style:
                                //       context.textTheme.displayMedium?.copyWith(
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                                // Space.height(context, 0.008),
                                // Text(
                                //   context.appLocalizations.noTripHistoryYetInfo,
                                //   style: context.textTheme.displaySmall
                                //       ?.copyWith(),
                                //   textAlign: TextAlign.center,
                                // ),
                                // Space.height(context, 0.18),
                                // GenericButton(
                                //   onTap: () {
                                //     context.pop();
                                //     context.pop();
                                //     Map locations = {
                                //       "pickUp": [
                                //         {
                                //           "name": locationProvider
                                //               .geoDataInfo?.address,
                                //           "id":
                                //               locationProvider.geoDataInfo?.id,
                                //           "lat":
                                //               locationProvider.geoDataInfo?.lat,
                                //           "lng":
                                //               locationProvider.geoDataInfo?.lng,
                                //         }
                                //       ],
                                //       "dropOff": [{}],
                                //     };

                                //     buildWhereToBottomSheet(
                                //       context: context,
                                //       locations: locations,
                                //     );
                                //   },
                                //   label: context.appLocalizations.bookARide,
                                //   isActive: true,
                                // )
                              ],
                            ),
                          ),
                        )
                      //history sections
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: tripHistory.length + 1,
                            controller: historyListingController,
                            itemBuilder: (context, index) {
                              if (index < tripHistory.length) {
                                return HistorySections(
                                  label: tripHistory[index].key,
                                  items: tripHistory[index].value,
                                );
                              } else {
                                if (currentPage != lastPage) {
                                  return const LoadingIndicator();
                                } else {
                                  return const SizedBox();
                                }
                              }
                            },
                          ),
                        );
                }

                return const LoadingIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
