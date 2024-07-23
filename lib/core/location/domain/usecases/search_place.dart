import 'package:dartz/dartz.dart';
import 'package:rideme_driver/core/location/domain/entity/places_info.dart';
import 'package:rideme_driver/core/location/domain/repositories/location_repository.dart';
import 'package:rideme_driver/core/usecase/usecase.dart';

class SearchPlace extends UseCases<Places, Map<String, dynamic>> {
  final LocationRepository repository;

  SearchPlace({required this.repository});
  @override
  Future<Either<String, Places>> call(Map<String, dynamic> params) async {
    return repository.searchPlace(params);
  }
}
