import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/media/domain/repositories/media_repository.dart';

class SelectImageFromGallery extends UseCases<File, NoParams> {
  final MediaRepository repository;

  SelectImageFromGallery({required this.repository});

  @override
  Future<Either<String, File>> call(NoParams params) async {
    return await repository.selectPhotoFromGallery();
  }
}
