import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';

import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:rideme_driver/features/user/presentation/provider/user_provider.dart';
import 'package:rideme_driver/injection_container.dart';

class OnOffWidget extends StatefulWidget {
  const OnOffWidget({
    super.key,
  });

  @override
  State<OnOffWidget> createState() => _OnOffWidgetState();
}

class _OnOffWidgetState extends State<OnOffWidget> {
  late UserProvider provider;
  final userBloc = sl<UserBloc>();
  bool isLoading = false;

  changeAvailability(bool status) async {
    final location = await Geolocator.getCurrentPosition();

    if (!mounted) return;

    final params = {
      "locale": context.appLocalizations.localeName,
      "bearer": context.read<AuthenticationProvider>().token,
      "body": {
        "status": status ? 'online' : 'offline',
        "lat": location.latitude,
        "lng": location.longitude,
      }
    };

    userBloc.add(ChangeAvailabilityEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    provider = context.watch<UserProvider>();
    bool isOffline = (provider.user?.availability ?? 'offline') == 'offline';
    return BlocListener(
      bloc: userBloc,
      listener: (context, state) {
        if (state is ChangeAvailabilityError) {
          setState(() {
            isLoading = false;
          });
          showErrorPopUp(state.errorMessage, context);
        }
        if (state is ChangeAvailabilityLoaded) {
          setState(() {
            isLoading = false;
          });

          provider.updateUserInfo = state.user;
        }
        if (state is ChangeAvailabilityLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => changeAvailability(isOffline),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: Sizes.height(context, 0.06),
          width: Sizes.width(context, 0.12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOffline
                ? AppColors.rideMeBlueNormal
                : AppColors.rideMeBlackLightActive,
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: Sizes.height(context, 0.02),
                    width: Sizes.height(context, 0.02),
                    child: CircularProgressIndicator(
                      color: isOffline
                          ? AppColors.rideMeWhite400
                          : AppColors.rideMeBlackDark,
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    isOffline
                        ? context.appLocalizations.go
                        : context.appLocalizations.off,
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isOffline ? AppColors.rideMeWhite400 : null,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
