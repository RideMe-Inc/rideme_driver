import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/injection_container.dart';

class ConfirmLogoutDialog extends StatefulWidget {
  const ConfirmLogoutDialog({super.key});

  @override
  State<ConfirmLogoutDialog> createState() => _ConfirmLogoutDialogState();
}

class _ConfirmLogoutDialogState extends State<ConfirmLogoutDialog> {
  final authenticationBloc = sl<AuthenticationBloc>();

  logoutOnTap() {
    final params = {
      'locale': context.appLocalizations.localeName,
      'bearer': context.read<AuthenticationProvider>().token!,
    };

    authenticationBloc.add(LogOutEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(Sizes.height(context, 0.015)),
        // height: Sizes.height(context, 0.3),
        width: Sizes.height(context, 0.343),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.close,
                ),
              ),
            ),
            Text(
              context.appLocalizations.logout,
              style: context.textTheme.displayLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Space.height(context, 0.016),
            Text(
              context.appLocalizations.logoutDesc,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Space.height(context, 0.024),
            GenericButton(
              onTap: () => context.pop(),
              label: context.appLocalizations.cancel,
              isActive: true,
            ),
            Space.height(context, 0.02),
            BlocConsumer(
              bloc: authenticationBloc,
              listener: (context, state) {
                if (state is LogOutLoaded) {
                  context.pop();
                  context.read<AuthenticationProvider>().updateToken = null;
                  context.goNamed('login');
                }
                if (state is GenericAuthenticationError) {
                  showErrorPopUp(state.errorMessage, context);
                }
              },
              builder: (context, state) {
                if (state is LogOutLoading) {
                  return LoadingIndicator(
                    height: Sizes.height(context, 0.053),
                    width: Sizes.height(context, 0.053),
                  );
                }
                return TextButton(
                  onPressed: logoutOnTap,
                  child: Text(
                    context.appLocalizations.confirmLogout,
                    style: context.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
