import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/information_resource.dart';
import 'package:rideme_driver/features/informationResources/domain/usecases/get_all_vehicle_makes.dart';

import 'package:rideme_driver/features/informationResources/domain/usecases/get_all_vehicle_models.dart';

part 'information_resources_event.dart';
part 'information_resources_state.dart';

class InformationResourcesBloc
    extends Bloc<InformationResourcesEvent, InformationResourcesState> {
  final GetAllVehicleMakes getAllVehicleMakes;
  final GetAllVehicleModels getAllVehicleModels;
  InformationResourcesBloc({
    required this.getAllVehicleMakes,
    required this.getAllVehicleModels,
  }) : super(InformationResourcesInitial()) {
    //! GET COMPANIES
    on<GetAllVehiclesMakesEvent>(
      (event, emit) async {
        final response = await getAllVehicleMakes(event.params);

        emit(
          response.fold(
            (errorMessage) => GenericDataError(errorMessage: errorMessage),
            (response) => GetAllVehicleMakesLoaded(makes: response),
          ),
        );
      },
    );

    //! GET ALL VEHICLE BRANDS
    on<GetAllVehiclesModelsEvent>(
      (event, emit) async {
        final response = await getAllVehicleModels(event.params);

        emit(
          response.fold(
            (errorMessage) => GenericDataError(errorMessage: errorMessage),
            (response) => GetAllVehicleModelsLoaded(models: response),
          ),
        );
      },
    );
  }
}
