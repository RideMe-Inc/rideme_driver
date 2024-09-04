import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/core/widgets/popups/success_popup.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:rideme_driver/features/user/presentation/provider/user_provider.dart';
import 'package:rideme_driver/features/user/presentation/widgets/confirm_delete.dart';
import 'package:rideme_driver/features/user/presentation/widgets/note_tile.dart';
import 'package:rideme_driver/injection_container.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final userBloc = sl<UserBloc>();

  confirmDeleteOnTap() {
    context.pop();
    final params = {
      'locale': context.appLocalizations.localeName,
      'bearer': context.read<AuthenticationProvider>().token!,
    };

    userBloc.add(DeleteAccountEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    final notes = [
      context.appLocalizations.note_1,
      context.appLocalizations.note_2,
      context.appLocalizations.note_3
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.appLocalizations.deleteAccount,
          style: context.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.height(context, 0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.appLocalizations.deleteAccountHeader,
              style: context.textTheme.headlineSmall,
            ),
            Space.height(context, 0.032),
            _AccountAssociationCard(
              email: 'youremail.com',
              appLocalizations: context.appLocalizations,
            ),
            Space.height(context, 0.032),
            Text(
              context.appLocalizations.pleaseTakeNote,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Space.height(context, 0.024),
            ...List.generate(
              notes.length,
              (index) => NoteTile(note: notes[index], number: index + 1),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocConsumer(
                    bloc: userBloc,
                    listener: (context, state) {
                      if (state is DeleteAccountError) {
                        showErrorPopUp(state.message, context);
                      }

                      if (state is DeleteAccountLoaded) {
                        showSuccessPopUp(state.message, context);
                      }
                    },
                    builder: (context, state) {
                      if (state is DeleteAccountLoading) {
                        return const LoadingIndicator();
                      }
                      return GenericButton(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => ConfirmDeleteDialog(
                            confirmDeleteOnTap: confirmDeleteOnTap,
                          ),
                        ),
                        label: context.appLocalizations.deleteAccount,
                        isActive: true,
                      );
                    },
                  ),
                  Space.height(context, 0.036),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//ACCOUNT ASSOCIATION CARD

class _AccountAssociationCard extends StatelessWidget {
  final String email;
  final AppLocalizations appLocalizations;
  const _AccountAssociationCard({
    required this.email,
    required this.appLocalizations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.height(context, 0.018),
        vertical: Sizes.height(context, 0.016),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.rideMeErrorNormal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            SvgNameConstants.alertCircle,
          ),
          Space.width(context, 0.02),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: context.appLocalizations.acountAssociatedWith,
                style: context.textTheme.displaySmall,
                children: [
                  TextSpan(
                    text: ' ${context.read<UserProvider>().user?.email} ',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text:
                        context.appLocalizations.accountAssociatedContinuation,
                    style: context.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
