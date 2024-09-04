import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rideme_driver/features/media/data/datasources/localds.dart';
import 'package:rideme_driver/features/media/domain/repositories/media_repository.dart';

class MediaRepositoryImpl extends MediaRepository {
  final MediaLocalDatasource localDatasource;

  MediaRepositoryImpl({required this.localDatasource});
  @override
  Future<Either<String, File>> selectPhotoFromGallery() async {
    try {
      final response = await localDatasource.selectPhotoFromGallery();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, File>> takePictureWithCamera() async {
    try {
      final response = await localDatasource.takePictureWithCamera();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> convertImageToBase64(File image) async {
    try {
      final response = await localDatasource.convertImageToBase64(image);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
