import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/mixins/url_launcher_mixin.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/core/widgets/textfield/phone_number_textfield_widget.dart';
import 'package:rideme_driver/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/injection_container.dart';

class PhoneEntryPage extends StatefulWidget {
  const PhoneEntryPage({super.key});

  @override
  State<PhoneEntryPage> createState() => _PhoneEntryPageState();
}

class _PhoneEntryPageState extends State<PhoneEntryPage> with UrlLauncherMixin {
  String number = '';
  bool isButtonActive = false;

  PhoneNumber phoneNumber = PhoneNumber();
  final authBloc = sl<AuthenticationBloc>();

  initAuth() {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "body": {
        "phone": number,
      }
    };

    authBloc.add(InitAuthenticationEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.height(context, 0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.appLocalizations.enterYourPhoneNumber,
              style: context.textTheme.displayLarge?.copyWith(
                color: AppColors.rideMeBlackNormalActive,
                fontWeight: FontWeight.w600,
              ),
            ),
            Space.height(context, 0.012),
            Text(
              context.appLocalizations.enterYourPhoneNumberInfo,
              style: context.textTheme.displaySmall,
            ),
            Space.height(context, 0.034),
            PhoneNumberTextField(
              number: phoneNumber,
              onInputChanged: (p0) =>
                  setState(() => number = p0.phoneNumber ?? ''),
              onInputValidated: (p0) => setState(
                () => isButtonActive = p0,
              ),
            ),
            Space.height(context, 0.028),

            //BUTTON
            BlocConsumer(
              bloc: authBloc,
              listener: (context, state) {
                if (state is InitAuthenticationLoaded) {
                  context.pushNamed('otpVerification', queryParameters: {
                    "phone": number,
                    "token": state.initAuth.authData?.token,
                    "user_exist":
                        state.initAuth.userExists?.toString() ?? 'false'
                  });
                }
                if (state is GenericAuthenticationError) {
                  showErrorPopUp(state.errorMessage, context);
                }
              },
              builder: (context, state) {
                if (state is InitAuthenticationLoading) {
                  return const LoadingIndicator();
                }

                return GenericButton(
                  onTap: initAuth,
                  label: context.appLocalizations.continues,
                  isActive: isButtonActive,
                );
              },
            ),
            Space.height(context, 0.036),

            //TERMS AND CONDITIONS

            Expanded(
              child: Wrap(
                children: [
                  Text(
                    context.appLocalizations.byContinuing,
                    style: context.textTheme.displaySmall?.copyWith(),
                  ),
                  GestureDetector(
                    onTap: () => launchLink('https://rideme.app'),
                    child: Text(
                      " ${context.appLocalizations.termsOfService}",
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.rideMeBlueNormal,
                      ),
                    ),
                  ),
                  Text(
                    ",",
                    style: context.textTheme.displaySmall,
                  ),
                  GestureDetector(
                    onTap: () => launchLink('https://rideme.app'),
                    child: Text(
                      " ${context.appLocalizations.privacyPolicy}",
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.rideMeBlueNormal,
                      ),
                    ),
                  ),
                  Text(
                    " and",
                    style: context.textTheme.displaySmall,
                  ),
                  GestureDetector(
                    onTap: () => launchLink('https://rideme.app'),
                    child: Text(
                      " ${context.appLocalizations.conditions}.",
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.rideMeBlueNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
