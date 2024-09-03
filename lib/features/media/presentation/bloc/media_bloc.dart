import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/media/domain/usecases/convert_image_to_base64.dart';
import 'package:rideme_driver/features/media/domain/usecases/select_image_from_gallery.dart';
import 'package:rideme_driver/features/media/domain/usecases/take_picture_with_camera.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final TakePictureWithCamera takePictureWithCamera;
  final SelectImageFromGallery selectImageFromGallery;
  final ConvertImageToBase64 convertImageToBase64;
  MediaBloc({
    required this.takePictureWithCamera,
    required this.selectImageFromGallery,
    required this.convertImageToBase64,
  }) : super(MediaInitial()) {
    //!SELECT IMAGE FROM GALLERY
    on<SelectImageFromGalleryEvent>((event, emit) async {
      emit(SelectImageFromGalleryLoading());
      final response = await selectImageFromGallery(NoParams());

      emit(
        response.fold(
          (errorMessage) => ImageSelectionError(errorMessage: errorMessage),
          (response) => ImageSelectionLoaded(image: response, type: event.type),
        ),
      );
    });

    //!TAKE PICTURE WITH CAMERA
    on<TakePictureWithCameraEvent>((event, emit) async {
      emit(TakePictureWithCameraLoading());
      final response = await takePictureWithCamera(NoParams());

      emit(
        response.fold(
          (errorMessage) => ImageSelectionError(errorMessage: errorMessage),
          (response) => ImageSelectionLoaded(
            image: response,
            type: event.type,
          ),
        ),
      );
    });

    //!CONVERT IMAGE TO BASE64
    on<ConvertImageToBase64Event>((event, emit) async {
      final response = await convertImageToBase64(event.image);

      emit(
        response.fold(
          (errorMessage) =>
              ConvertImageToBase64Error(errorMessage: errorMessage),
          (response) => ConvertImageToBase64Loaded(
              base64Image: response, type: event.type),
        ),
      );
    });
  }
}
