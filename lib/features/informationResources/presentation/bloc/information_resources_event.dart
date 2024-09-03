part of 'information_resources_bloc.dart';

sealed class InformationResourcesEvent extends Equatable {
  const InformationResourcesEvent();

  @override
  List<Object> get props => [];
}

//!GET VEHICLE MAKES
final class GetAllVehiclesMakesEvent extends InformationResourcesEvent {
  final Map<String, dynamic> params;

  const GetAllVehiclesMakesEvent({required this.params});
}

//! GET ALL VEHICLE MODELS
final class GetAllVehiclesModelsEvent extends InformationResourcesEvent {
  final Map<String, dynamic> params;

  const GetAllVehiclesModelsEvent({required this.params});
}
