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

//!GET VEHICL COLORS
final class GetAllVehicleColorsEvent extends InformationResourcesEvent {
  final Map<String, dynamic> params;

  const GetAllVehicleColorsEvent({required this.params});
}
