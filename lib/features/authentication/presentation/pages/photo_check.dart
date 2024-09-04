import 'dart:io';

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
import 'package:rideme_driver/features/media/presentation/bloc/media_bloc.dart';
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:rideme_driver/injection_container.dart';

class PhotoCheckPage extends StatefulWidget {
  final String? from;
  const PhotoCheckPage({super.key, this.from});

  @override
  State<PhotoCheckPage> createState() => _PhotoCheckPageState();
}

class _PhotoCheckPageState extends State<PhotoCheckPage> {
  final mediaBloc = sl<MediaBloc>();
  final userBloc = sl<UserBloc>();
  File? photoCheckImage;
  String? imageBase64;

  //camera On Tap
  cameraOnTap(BuildContext context) {
    mediaBloc.add(const TakePictureWithCameraEvent());
  }

  updatePhotoCheck() {
    final params = {
      "locale": context.appLocalizations.localeName,
      "bearer": context.read<AuthenticationProvider>().token,
      "body": {
        "profile_image": imageBase64,
      }
    };

    userBloc.add(EditProfileEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: mediaBloc,
            listener: (context, state) {
              //error
              if (state is ImageSelectionError) {
                showErrorPopUp(state.errorMessage, context);
              }

              //error
              if (state is ConvertImageToBase64Error) {
                showErrorPopUp(state.errorMessage, context);
              }
              //set image
              if (state is ImageSelectionLoaded) {
                photoCheckImage = state.image;
                mediaBloc.add(
                  ConvertImageToBase64Event(image: state.image),
                );

                setState(() {});
              }

              //set base64
              if (state is ConvertImageToBase64Loaded) {
                imageBase64 = state.base64Image;

                setState(() {});
              }
            },
          ),
          BlocListener(
            bloc: userBloc,
            listener: (context, state) {
              if (state is EditProfileLoaded) {
                widget.from != null
                    ? context.goNamed('home')
                    : context.goNamed('pledge');
              }

              if (state is EditProfileError) {
                showErrorPopUp(state.message, context);
              }
            },
          ),
        ],
        child: Padding(
          padding: EdgeInsets.all(Sizes.height(context, 0.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.appLocalizations.photoCheck,
                style: context.textTheme.displayLarge?.copyWith(
                  color: AppColors.rideMeBlackNormalActive,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Space.height(context, 0.012),
              Text(
                context.appLocalizations.photoCheckInfo,
                style: context.textTheme.displaySmall,
              ),
              Space.height(context, 0.05),
              Center(
                child: GestureDetector(
                  onTap: () => cameraOnTap(context),
                  child: Badge(
                    backgroundColor: AppColors.rideMeBlueNormal,
                    offset: const Offset(-20, 10),
                    padding: const EdgeInsets.all(7),
                    label: Icon(
                      Icons.camera_alt,
                      size: Sizes.height(context, 0.03),
                      color: AppColors.rideMeBackgroundLight,
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppColors.rideMeGreyNormal,
                      radius: Sizes.height(context, 0.08),
                      backgroundImage: photoCheckImage != null
                          ? FileImage(
                              photoCheckImage!,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder(
                        bloc: userBloc,
                        builder: (context, state) {
                          if (state is EditProfileLoading) {
                            return const LoadingIndicator();
                          }
                          return GenericButton(
                            onTap: updatePhotoCheck,
                            label: context.appLocalizations.continues,
                            isActive: imageBase64 != null,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
