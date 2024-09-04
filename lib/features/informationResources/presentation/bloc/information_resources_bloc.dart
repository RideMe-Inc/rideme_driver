import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/information_resource.dart';
import 'package:rideme_driver/features/informationResources/domain/entity/vehicle_makes.dart';
import 'package:rideme_driver/features/informationResources/domain/usecases/get_all_vehicle_colors.dart';
import 'package:rideme_driver/features/informationResources/domain/usecases/get_all_vehicle_makes.dart';

part 'information_resources_event.dart';
part 'information_resources_state.dart';

class InformationResourcesBloc
    extends Bloc<InformationResourcesEvent, InformationResourcesState> {
  final GetAllVehicleMakes getAllVehicleMakes;
  final GetAllVehicleColors getAllVehicleColors;

  InformationResourcesBloc({
    required this.getAllVehicleMakes,
    required this.getAllVehicleColors,
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
    //! GET colors
    on<GetAllVehicleColorsEvent>(
      (event, emit) async {
        final response = await getAllVehicleColors(event.params);

        emit(
          response.fold(
            (errorMessage) => GenericDataError(errorMessage: errorMessage),
            (response) => GetAllVehicleColorsLoaded(colors: response),
          ),
        );
      },
    );
  }
}
