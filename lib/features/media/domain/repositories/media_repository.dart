import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class MediaRepository {
  ///takePictureWithCamera
  Future<Either<String, File>> takePictureWithCamera();

  ///selectPhotoFromGallery
  Future<Either<String, File>> selectPhotoFromGallery();

  ///convert image to base64
  Future<Either<String, String>> convertImageToBase64(File image);
}
