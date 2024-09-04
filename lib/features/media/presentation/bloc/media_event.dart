part of 'media_bloc.dart';

sealed class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object> get props => [];
}

//! CONVERT TO BASE64
final class ConvertImageToBase64Event extends MediaEvent {
  final File image;
  final String? type;

  const ConvertImageToBase64Event({required this.image, this.type});
}

//!TAKE PICTURE WITH CAMERA
final class TakePictureWithCameraEvent extends MediaEvent {
  final String? type;

  const TakePictureWithCameraEvent({this.type});
}

//!SELECT IMAGE FROM GALLERY
final class SelectImageFromGalleryEvent extends MediaEvent {
  final String? type;

  const SelectImageFromGalleryEvent({this.type});
}
