import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/media/domain/repositories/media_repository.dart';

class TakePictureWithCamera extends UseCases<File, NoParams> {
  final MediaRepository repository;

  TakePictureWithCamera({required this.repository});

  @override
  Future<Either<String, File>> call(NoParams params) async {
    return await repository.takePictureWithCamera();
  }
}
