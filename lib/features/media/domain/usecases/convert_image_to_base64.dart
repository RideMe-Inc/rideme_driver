import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';
import 'package:rideme_driver/features/media/domain/repositories/media_repository.dart';

class ConvertImageToBase64 extends UseCases<String, File> {
  final MediaRepository repository;

  ConvertImageToBase64({required this.repository});

  @override
  Future<Either<String, String>> call(File params) async {
    return await repository.convertImageToBase64(params);
  }
}
