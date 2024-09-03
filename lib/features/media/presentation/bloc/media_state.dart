part of 'media_bloc.dart';

sealed class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object> get props => [];
}

class MediaInitial extends MediaState {}

//!SELECT IMAGE FROM GALLERY
//loading
final class SelectImageFromGalleryLoading extends MediaState {}

//loaded
final class SelectImageFromGalleryLoaded extends MediaState {
  final File image;
  final String? type;

  const SelectImageFromGalleryLoaded({required this.image, this.type});
}

//!TAKE PICTURE WITH CAMERA
//loading
final class TakePictureWithCameraLoading extends MediaState {}

//loaded
final class TakePictureWithCameraLoaded extends MediaState {
  final File image;
  final String? type;

  const TakePictureWithCameraLoaded({required this.image, this.type});
}

//!CONVERT IMAGE TO BASE64
//loaded
final class ConvertImageToBase64Loaded extends MediaState {
  final String base64Image;
  final String? type;

  const ConvertImageToBase64Loaded({required this.base64Image, this.type});
}

//! IMAGE SELECTION
//loaded
final class ImageSelectionLoaded extends MediaState {
  final File image;
  final String? type;

  const ImageSelectionLoaded({required this.image, this.type});
}

class ImageSelectionError extends MediaState {
  final String errorMessage;

  const ImageSelectionError({required this.errorMessage});
}

final class ConvertImageToBase64Error extends MediaState {
  final String errorMessage;

  const ConvertImageToBase64Error({required this.errorMessage});
}
