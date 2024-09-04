import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/trips/presentation/bloc/trips_bloc.dart';
import 'package:rideme_driver/injection_container.dart';

class CancelTripReasonsPage extends StatefulWidget {
  final String tripId;
  const CancelTripReasonsPage({
    super.key,
    required this.tripId,
  });

  @override
  State<CancelTripReasonsPage> createState() => _CancelTripReasonsPageState();
}

class _CancelTripReasonsPageState extends State<CancelTripReasonsPage> {
  final tripBloc = sl<TripsBloc>();

  cancelTrip() {
    final params = {
      'locale': context.appLocalizations.localeName,
      'bearer': context.read<AuthenticationProvider>().token,
      'urlParameters': {
        'id': widget.tripId,
      }
    };

    tripBloc.add(CancelTripEvent(params: params));
  }

  int? indexSelected;

  @override
  Widget build(BuildContext context) {
    List<String> cancelReasons = [
      'To be decided',
      'To be decided',
      'To be decided',
      'To be decided',
    ];
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.width(context, 0.04),
      ),
      decoration: BoxDecoration(
        color: AppColors.rideMeBackgroundLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Sizes.height(context, 0.02)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Space.height(context, 0.007),
          Center(
            child: Container(
              width: Sizes.width(context, 0.08),
              height: Sizes.height(context, 0.005),
              decoration: BoxDecoration(
                color: AppColors.rideMeGreyNormal,
                borderRadius: BorderRadius.circular(
                  Sizes.height(context, 0.005),
                ),
              ),
            ),
          ),
          Space.height(context, 0.011),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Center(
                child: Text(
                  context.appLocalizations.cancelTrip,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Space.height(context, 0.028),

              Text(
                context.appLocalizations.tripCancelInfo,
                style: context.textTheme.displaySmall,
              ),
              Space.height(context, 0.023),

              //payment types

              ...List.generate(
                cancelReasons.length,
                (index) => _CancelReasonTile(
                  label: cancelReasons[index],
                  isSelected: indexSelected == index,
                  onTap: () {
                    indexSelected = index;
                    setState(() {});
                  },
                ),
              ),

              Space.height(context, 0.044),
              BlocConsumer(
                bloc: tripBloc,
                listener: (context, state) {
                  if (state is CancelTripLoaded) {
                    context.pop();
                    context.goNamed('home');
                  }

                  if (state is GenericTripsError) {
                    showErrorPopUp(state.errorMessage, context);
                    if (kDebugMode) print(state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is CancelTripLoading) {
                    return const LoadingIndicator();
                  }
                  return GenericButton(
                    onTap: cancelTrip,
                    label: context.appLocalizations.cancel,
                    buttonColor: AppColors.rideMeErrorNormal,
                    isActive: indexSelected != null,
                  );
                },
              ),
              Space.height(context, 0.03),
            ],
          ),
        ],
      ),
    );
  }
}

class _CancelReasonTile extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String label;
  const _CancelReasonTile({
    required this.onTap,
    required this.isSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: Sizes.width(context, 0.05),
        height: Sizes.height(context, 0.1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? AppColors.rideMeBlueNormal
                : AppColors.rideMeGreyNormalActive,
          ),
        ),
        child: isSelected
            ? Center(
                child: SizedBox(
                  height: Sizes.height(context, 0.015),
                  child: const CircleAvatar(
                    backgroundColor: AppColors.rideMeBlueNormal,
                  ),
                ),
              )
            : null,
      ),
      title: Text(
        label,
        style: context.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
