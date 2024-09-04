import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/mixins/network_image_to_file_mixin.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/core/widgets/textfield/date_form_field.dart';
import 'package:rideme_driver/core/widgets/textfield/text_form_field.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/authentication/presentation/widgets/information_upload_widget.dart';
import 'package:rideme_driver/features/media/presentation/bloc/media_bloc.dart';
import 'package:rideme_driver/features/media/presentation/widgets/media_selection_modal.dart';
import 'package:rideme_driver/features/user/domain/entities/license_info.dart';
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:rideme_driver/injection_container.dart';

class LicenseInformationPage extends StatefulWidget {
  final String? from;
  const LicenseInformationPage({
    super.key,
    this.from,
  });

  @override
  State<LicenseInformationPage> createState() => _LicenseInformationPageState();
}

class _LicenseInformationPageState extends State<LicenseInformationPage>
    with NewtworkImageToFileMixin {
  final licenseNumber = TextEditingController();
  final expiry = TextEditingController();

  final userBloc = sl<UserBloc>();
  final mediaBloc = sl<MediaBloc>();

  File? imageFront, imageBack;
  String? frontBase64, backBase64, expiryDate;
  num? licenseId;

  final formKey = GlobalKey<FormBuilderState>();

  uploadOnTap(String type) {
    buildMediaSelectionModal(
      context: context,
      cameraOnTap: () => cameraOnTap(context, type),
      galleryOnTap: () => galleryOnTap(context, type),
    );
  }

//gallery On Tap
  galleryOnTap(BuildContext context, String type) {
    context.pop();
    mediaBloc.add(SelectImageFromGalleryEvent(type: type));
  }

  //camera On Tap
  cameraOnTap(BuildContext context, String type) {
    context.pop();
    mediaBloc.add(TakePictureWithCameraEvent(type: type));
  }

  //update values
  updateValues(LicenseInfo licenseInfo) async {
    setState(() {
      licenseNumber.text = licenseInfo.licenseDetails?.number ?? '';
      expiry.text = licenseInfo.licenseDetails?.expiry ?? '';
      expiryDate = licenseInfo.licenseDetails?.expiry ?? '';
      licenseId = licenseInfo.licenseDetails?.id;
    });

    imageFront = await convertImageToFile(
        image: licenseInfo.licenseDetails?.fontImage ?? '');

    imageBack = await convertImageToFile(
        image: licenseInfo.licenseDetails?.backImage ?? '');

    frontBase64 = await convertImageToBase64(imageFront!);
    backBase64 = await convertImageToBase64(imageBack!);

    setState(() {});
  }

  //UPLOAD LICENSE

  uploadLicenseInformation() {
    final validated = formKey.currentState?.saveAndValidate();
    if (validated == false) return;
    final params = {
      "locale": context.appLocalizations.localeName,
      "bearer": context.read<AuthenticationProvider>().token,
      "urlParameters": {
        "licenseId": licenseId,
      },
      "body": {
        "license_number": licenseNumber.text,
        "front_image": frontBase64,
        "back_image": backBase64,
        "date_of_expiry": expiryDate,
      }
    };

    userBloc.add(widget.from != null
        ? EditDriverLicenseEvent(params: params)
        : CreateDriverLicenseEvent(params: params));
  }

  //get license info
  getLicenseInformation() {
    final params = {
      "locale": context.appLocalizations.localeName,
      "bearer": context.read<AuthenticationProvider>().token,
    };

    userBloc.add(GetAllRidersLicenseEvent(params: params));
  }

  initPage() {
    if (widget.from == null) return;
    getLicenseInformation();
  }

  @override
  void initState() {
    initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;

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
                if (state.type == 'front') {
                  imageFront = state.image;
                } else {
                  imageBack = state.image;
                }

                mediaBloc.add(
                  ConvertImageToBase64Event(
                      image: state.image, type: state.type),
                );

                setState(() {});
              }

              //set base64
              if (state is ConvertImageToBase64Loaded) {
                if (state.type == 'front') {
                  frontBase64 = state.base64Image;
                } else {
                  backBase64 = state.base64Image;
                }

                setState(() {});
              }
            },
          ),
          BlocListener(
            bloc: userBloc,
            listener: (context, state) {
              if (state is GenericUserError) {
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is CreateDriverLicenseLoaded) {
                context.goNamed('photoCheck');
              }

              if (state is EditDriverLicenseLoaded) {
                // showSuccessPopUp('License information updated', context);
                context.pop();
              }

              if (state is GetAllRidersLicenseLoaded) {
                updateValues(state.licenseInfo);
              }

              if (state is GetAllRiderLicenseError) {
                showErrorPopUp(state.errorMessage, context);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(Sizes.height(context, 0.02)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.appLocalizations.driverLicenseInformation,
                    style: context.textTheme.displayLarge?.copyWith(
                      color: AppColors.rideMeBlackNormalActive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Space.height(context, 0.012),
                  Text(
                    context.appLocalizations.addDriverLicense,
                    style: context.textTheme.displaySmall,
                  ),
                  Space.height(context, 0.031),
                  // first name
                  TextFormBuilderField(
                    name: 'license_number',
                    initialValue: licenseNumber.text,
                    label: appLocalizations.licenseNumber,
                    onChanged: (p0) {},
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return appLocalizations.fieldIsRequired;
                      }

                      if (value!.length < 2) {
                        return appLocalizations.mustBeAtLeast(2);
                      }

                      return null;
                    },
                    hint: appLocalizations.licenseNumberHint,
                    controller: licenseNumber,
                    suffixOnTap: () {},
                  ),

                  //expiry

                  DateFormBuilderField(
                    fieldName: 'expiry',
                    initialValue:
                        expiryDate != null ? DateTime.parse(expiryDate!) : null,
                    label: appLocalizations.expiryDate,
                    validator: (p0) {
                      if (p0 == null) {
                        return appLocalizations.fieldIsRequired;
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      if (p0 != null) {
                        setState(
                          () => expiryDate = p0.toIso8601String(),
                        );
                      }
                    },
                    controller: expiry,
                  ),

                  //license front
                  TakePhotoContainer(
                    onTap: () => uploadOnTap('front'),
                    image: imageFront,
                    label: appLocalizations.front,
                  ),
                  //license back
                  TakePhotoContainer(
                    onTap: () => uploadOnTap('back'),
                    image: imageBack,
                    label: appLocalizations.back,
                  ),

                  Space.height(context, 0.1),

                  BlocBuilder(
                    bloc: userBloc,
                    builder: (context, state) {
                      //LOADING INDICATOR FOR SIGN UP LOADING
                      if (state is CreateDriverLicenseLoading) {
                        return Container(
                          color: theme.scaffoldBackgroundColor,
                          height: Sizes.height(context, 0.1),
                          child: const LoadingIndicator(),
                        );
                      }
                      return GenericButton(
                        onTap: () {
                          final validated =
                              formKey.currentState?.saveAndValidate();
                          if (validated == false) return;

                          if (frontBase64 == null || backBase64 == null) {
                            showErrorPopUp('Upload all images', context);
                            return;
                          }

                          uploadLicenseInformation();
                          //call convert to base64 event
                        },
                        label: appLocalizations.continues,
                        isActive: true,
                      );
                    },
                  ),

                  Space.height(context, 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
