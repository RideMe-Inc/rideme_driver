import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/mixins/network_image_to_file_mixin.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/core/widgets/dropdowns/dropdown_form_builder_field.dart';
import 'package:rideme_driver/core/widgets/loaders/loading_indicator.dart';
import 'package:rideme_driver/core/widgets/popups/error_popup.dart';
import 'package:rideme_driver/core/widgets/textfield/date_form_field.dart';
import 'package:rideme_driver/core/widgets/textfield/generic_textfield_widget.dart';
import 'package:rideme_driver/core/widgets/textfield/text_form_field.dart';
import 'package:rideme_driver/features/authentication/presentation/provider/authentication_provider.dart';
import 'package:rideme_driver/features/authentication/presentation/widgets/information_upload_widget.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/information_resource.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/vehicle_makes.dart';
import 'package:rideme_driver/features/informationResources/presentation/bloc/information_resources_bloc.dart';
import 'package:rideme_driver/features/localization/presentation/providers/locale_provider.dart';
import 'package:rideme_driver/features/media/presentation/bloc/media_bloc.dart';
import 'package:rideme_driver/features/media/presentation/widgets/media_selection_modal.dart';
import 'package:rideme_driver/features/user/domain/entities/vehicle_details.dart';
import 'package:rideme_driver/features/user/presentation/bloc/user_bloc.dart';
import 'package:rideme_driver/injection_container.dart';

class VehicleDocumentPage extends StatefulWidget {
  final String? from;
  const VehicleDocumentPage({
    super.key,
    this.from,
  });

  @override
  State<VehicleDocumentPage> createState() => _VehicleDocumentPageState();
}

class _VehicleDocumentPageState extends State<VehicleDocumentPage>
    with NewtworkImageToFileMixin {
  TextEditingController vehicleBrand = TextEditingController();
  TextEditingController registrationNumber = TextEditingController();
  TextEditingController vehicleInsuranceExpiry = TextEditingController();
  TextEditingController insuranceName = TextEditingController();
  TextEditingController insuranceNumber = TextEditingController();
  TextEditingController vehicleColor = TextEditingController();

  final mediaBloc = sl<MediaBloc>();
  final userBloc = sl<UserBloc>();
  final informationResourcesBloc = sl<InformationResourcesBloc>();
  final informationResourcesBloc2 = sl<InformationResourcesBloc>();

  List<VehicleMakes> vehicleMakes = [];
  List<VehicleMakes> vehicleModels = [];
  List<InformationResource> vehicleColors = [];

  File? vehicleInsuranceImage;
  String? vehichleInsuranceBase64, vehicleType, viExpiry;
  num? makeId, modelId;
  int? vehicleId;
  bool modelEnabled = false;

  final List<String> vehicleTypes = [
    'I C E',
    'Electric',
    'Hybrid',
  ];

  final formKey = GlobalKey<FormBuilderState>();
  VehicleMakes? vehicleMake;

  //get all vehicle brands event function
  getAllVehicleMakes(Map<String, dynamic> params) {
    informationResourcesBloc.add(GetAllVehiclesMakesEvent(params: params));
    informationResourcesBloc2.add(GetAllVehicleColorsEvent(params: params));
  }

  getVehicles() {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "bearer": context.read<AuthenticationProvider>().token,
    };

    userBloc.add(GetAllRiderVehiclesEvent(params: params));
  }

  //update values
  updateValues(VehicleDetails vehicleDetails) async {
    setState(() {
      vehicleBrand.text = vehicleDetails.vehicleBrand ?? '';
      vehicleType = vehicleDetails.vehicleType;
      registrationNumber.text = vehicleDetails.registerNumber ?? '';

      vehicleInsuranceExpiry.text = vehicleDetails.vehicleInsuranceExpiry ?? '';
      viExpiry = vehicleDetails.vehicleInsuranceExpiry;
      vehicleId = vehicleDetails.id;
    });

    vehicleInsuranceImage =
        await convertImageToFile(image: vehicleDetails.insuranceImage ?? '');

    vehichleInsuranceBase64 =
        await convertImageToBase64(vehicleInsuranceImage!);

    setState(() {});
  }

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

  uploadVehicleDocument() {
    final params = {
      "locale": context.read<LocaleProvider>().locale,
      "bearer": context.read<AuthenticationProvider>().token,
      "urlParameters": {
        "vehicleId": vehicleId,
      },
      'body': {
        'registration_number': registrationNumber.text,
        'insurance_issuer': insuranceName.text,
        'insurance_number': insuranceNumber.text,
        'date_of_expiry': viExpiry,
        'vehicle_type': vehicleType?.replaceAll(' ', '').toLowerCase() ?? 'ice',
        'vehicle_model_id': modelId,
        'proof_of_insurance': vehichleInsuranceBase64,
        'vehicle_color': vehicleColor.text,
      }
    };

    userBloc.add(widget.from != null
        ? EditVehicleEvent(params: params)
        : CreateVehicleEvent(params: params));
  }

  initPage() {
    if (widget.from == null) return;
    getVehicles();
  }

  @override
  void initState() {
    initPage();
    getAllVehicleMakes({'locale': 'en'});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MultiBlocListener(
        listeners: [
          //!MEDIA
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
                vehicleInsuranceImage = state.image;

                mediaBloc.add(
                  ConvertImageToBase64Event(
                      image: state.image, type: state.type),
                );

                setState(() {});
              }

              //set base64
              if (state is ConvertImageToBase64Loaded) {
                vehichleInsuranceBase64 = state.base64Image;

                setState(() {});
              }
            },
          ),

          //!USER
          BlocListener(
            bloc: userBloc,
            listener: (context, state) {
              if (state is GenericUserError) {
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is GenericVehicleError) {
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is CreateVehicleLoaded) {
                context.goNamed('licenseInformation');
              }

              if (state is EditVehicleLoaded) {
                context.pop();
              }

              if (state is GetAllRiderVehiclesLoaded) {
                updateValues(state.riderVehicleInfo.vehicleDetails!);
              }

              if (state is GetAllRiderVehiclesError) {
                showErrorPopUp(state.errorMessage, context);
              }
            },
          ),

          //!INFO RESO
          BlocListener(
            bloc: informationResourcesBloc,
            listener: (context, state) {
              //GET ALL VEHICLE BRANDS FAILS
              if (state is GenericDataError) {
                showErrorPopUp(state.errorMessage, context);
              }

              //GET ALL VEHICLE BRANDS SUCCESS
              if (state is GetAllVehicleMakesLoaded) {
                setState(() {
                  vehicleMakes = state.makes;
                });
              }
            },
          ),
          //!INFO RESO 2
          BlocListener(
            bloc: informationResourcesBloc2,
            listener: (context, state) {
              //GET ALL VEHICLE BRANDS FAILS
              if (state is GenericDataError) {
                showErrorPopUp(state.errorMessage, context);
              }

              //GET ALL VEHICLE BRANDS SUCCESS
              if (state is GetAllVehicleColorsLoaded) {
                setState(() {
                  vehicleColors = state.colors;
                });
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
                    context.appLocalizations.vehicleInformation,
                    style: context.textTheme.displayLarge?.copyWith(
                      color: AppColors.rideMeBlackNormalActive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Space.height(context, 0.012),
                  Text(
                    context.appLocalizations.vehicleInformationInfo,
                    style: context.textTheme.displaySmall,
                  ),
                  Space.height(context, 0.031),

                  // registration number
                  TextFormBuilderField(
                    name: 'registration_number',
                    label: context.appLocalizations.registrationNumber,
                    onChanged: (p0) {},
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return context.appLocalizations.fieldIsRequired;
                      }

                      if (value!.length < 4) {
                        return context.appLocalizations.mustBeAtLeast(4);
                      }

                      return null;
                    },
                    hint: context.appLocalizations.registrationNumberHint,
                    controller: registrationNumber,
                    suffixOnTap: () {},
                  ),
                  // registration number
                  TextFormBuilderField(
                    name: 'insurance-name',
                    label: context.appLocalizations.insuranceName,
                    onChanged: (p0) {},
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return context.appLocalizations.fieldIsRequired;
                      }

                      if (value!.length < 2) {
                        return context.appLocalizations.mustBeAtLeast(2);
                      }

                      return null;
                    },
                    hint: context.appLocalizations.insuranceNameHint,
                    controller: insuranceName,
                    suffixOnTap: () {},
                  ),
                  TextFormBuilderField(
                    name: 'insurance-number',
                    label: context.appLocalizations.insuranceNumber,
                    onChanged: (p0) {},
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return context.appLocalizations.fieldIsRequired;
                      }

                      return null;
                    },
                    hint: context.appLocalizations.insuranceNumberHint,
                    controller: insuranceNumber,
                    suffixOnTap: () {},
                  ),

                  //expiry

                  DateFormBuilderField(
                    fieldName: 'vehicle-insurance-expiry',
                    label: context.appLocalizations.expiryDate,
                    validator: (p0) {
                      if (p0 == null) {
                        return context.appLocalizations.fieldIsRequired;
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      if (p0 != null) {
                        setState(
                          () => viExpiry = p0.toIso8601String(),
                        );
                      }
                    },
                    controller: vehicleInsuranceExpiry,
                  ),

                  //license back
                  TakePhotoContainer(
                    onTap: () => uploadOnTap('vehicle-insurance'),
                    image: vehicleInsuranceImage,
                    label: context.appLocalizations.insurancePicture,
                  ),

                  //vehicle type
                  DropdownFormBuilderField(
                    fieldName: 'vehicle-type',
                    hint: context.appLocalizations.vehicleTypeHint,
                    label: context.appLocalizations.vehicleType,
                    onChanged: (p0) {
                      setState(() {
                        vehicleType = p0;
                      });
                    },
                    items: vehicleTypes
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return context.appLocalizations.fieldIsRequired;
                      }
                      return null;
                    },
                  ),

                  //VEHICLE BRAND
                  FormBuilderField<VehicleMakes>(
                    name: 'vehicle_brand',
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose a brand';
                      }
                      return null;
                    },
                    builder: (field) => Autocomplete<VehicleMakes>(
                      displayStringForOption: (option) => option.name,
                      fieldViewBuilder: (context, controller, focus, callback) {
                        return // vehicle brand
                            GenericTextField(
                          focus: focus,
                          label: context.appLocalizations.vehicleBrand,
                          errorText: field.errorText,
                          onChanged: (value) {
                            final index = vehicleMakes.indexWhere(
                              (element) => element.name.toLowerCase().contains(
                                    value.toLowerCase(),
                                  ),
                            );

                            if (index != -1) {
                              field.didChange(vehicleMakes[index]);
                            }
                          },
                          hint: context.appLocalizations.vehicleBrandHint,
                          controller: controller,
                        );
                      },
                      optionsViewBuilder: (context, selection, brands) {
                        return Container(
                          alignment: Alignment.topLeft,
                          child: Material(
                            color: context.theme.scaffoldBackgroundColor,
                            elevation: 3.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: SizedBox(
                              width: Sizes.width(context, 0.9),
                              height: Sizes.height(context, 0.15),
                              child: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: brands.length,
                                itemBuilder: (context, i) {
                                  final brand = brands.elementAt(i);
                                  return InkWell(
                                    onTap: () => selection(brand),
                                    child: ListTile(
                                      title: Text(brand.name),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },

                      //!
                      onSelected: (value) {
                        field.didChange(value);

                        setState(() {
                          if (value.models != null) {
                            vehicleModels.retainWhere(
                              (element) => element == vehicleMake,
                            );
                            vehicleModels.addAll(value.models!);
                          } else {
                            vehicleModels.add(value);
                          }
                        });
                      },
                      optionsBuilder: (value) {
                        if (value.text.isEmpty) {
                          return [];
                        }
                        return vehicleMakes.where(
                          (vehicle) => vehicle.name
                              .toLowerCase()
                              .contains(value.text.toLowerCase()),
                        );
                      },
                    ),
                  ),

                  //VEHICLE MODEL

                  DropdownFormBuilderField(
                    fieldName: 'vehicle_model',
                    hint: context.appLocalizations.vehicleModel,
                    label: context.appLocalizations.vehicleModelHint,
                    onChanged: (p0) {
                      if (p0 != null) {
                        setState(() {
                          modelId = p0.id.toInt();
                          vehicleMake = p0;
                        });
                      }
                    },
                    items: vehicleModels
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return context.appLocalizations.fieldIsRequired;
                      }
                      return null;
                    },
                  ),

                  //vehicle color

                  DropdownFormBuilderField(
                    fieldName: 'vehicle-color',
                    hint: context.appLocalizations.vehicleColor,
                    label: context.appLocalizations.vehicleColorHint,
                    onChanged: (p0) {
                      if (p0 != null) {
                        setState(() {
                          vehicleColor.text = p0.name ?? 'white';
                        });
                      }
                    },
                    items: vehicleColors
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name ?? ''),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return context.appLocalizations.fieldIsRequired;
                      }
                      return null;
                    },
                  ),

                  Space.height(context, 0.07),

                  BlocBuilder(
                    bloc: userBloc,
                    builder: (context, state) {
                      //LOADING INDICATOR FOR SIGN UP LOADING
                      if (state is CreateVehicleLoading) {
                        return Container(
                          color: context.theme.scaffoldBackgroundColor,
                          height: Sizes.height(context, 0.1),
                          child: const LoadingIndicator(),
                        );
                      }
                      return GenericButton(
                        onTap: () {
                          final validated =
                              formKey.currentState?.saveAndValidate();
                          if (validated == false) return;

                          //call convert to base64 event
                          uploadVehicleDocument();
                        },
                        label: context.appLocalizations.continues,
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
