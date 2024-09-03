import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class MediaLocalDatasource {
// takePictureWithCamera
  Future<File> takePictureWithCamera();

// selectPhotoFromGallery
  Future<File> selectPhotoFromGallery();

// convert image to base64
  Future<String> convertImageToBase64(File image);
}

class MediaLocalDatasourceImpl implements MediaLocalDatasource {
  final ImagePicker imagePicker;

  const MediaLocalDatasourceImpl({
    required this.imagePicker,
  });

  //! SELECT PHOTO FROM GALLERY
  @override
  Future<File> selectPhotoFromGallery() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 90,
    );

    if (image == null) throw Exception('No image selected');

    return File(image.path);
  }

  //! TAKE PICTURE WITH CAMERA
  @override
  Future<File> takePictureWithCamera() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 90,
    );

    if (image == null) throw Exception('No image selected');

    return File(image.path);
  }

  //! CONVERT IMAGE TO BASE64
  @override
  Future<String> convertImageToBase64(File image) async {
    return base64Encode(await image.readAsBytes());
  }
}
