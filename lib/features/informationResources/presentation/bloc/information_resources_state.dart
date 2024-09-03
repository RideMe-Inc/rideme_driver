part of 'information_resources_bloc.dart';

sealed class InformationResourcesState extends Equatable {
  const InformationResourcesState();

  @override
  List<Object> get props => [];
}

final class InformationResourcesInitial extends InformationResourcesState {}

//!COMPANIES
//loaded
final class GetAllVehicleModelsLoaded extends InformationResourcesState {
  final List<InformationResource> models;

  const GetAllVehicleModelsLoaded({required this.models});
}

//!Vehicle brands
//loaded
final class GetAllVehicleMakesLoaded extends InformationResourcesState {
  final List<InformationResource> makes;

  const GetAllVehicleMakesLoaded({required this.makes});
}

//Errors
//!GENERIC DATA ERRORS
final class GenericDataError extends InformationResourcesState {
  final String errorMessage;

  const GenericDataError({required this.errorMessage});
}
