import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideme_driver/core/location/domain/entity/geo_hash.dart';
import 'package:rideme_driver/core/location/domain/entity/places_info.dart';
import 'package:rideme_driver/core/location/domain/usecases/get_geo_id.dart';
import 'package:rideme_driver/core/location/domain/usecases/search_place.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final SearchPlace searchPlace;
  final GetGeoID getGeoID;

  LocationBloc({
    required this.searchPlace,
    required this.getGeoID,
  }) : super(LocationInitial()) {
    //!SEARCH PLACES

    on<SearchPlacesEvent>(
      (event, emit) async {
        emit(SearchPlacesLoading());

        final response = await searchPlace(event.params['body']);

        emit(
          response.fold(
            (error) => SearchPlacesError(message: error),
            (response) => SearchPlacesLoaded(
              places: response,
            ),
          ),
        );
      },
      transformer: restartable(),
    );
    //clear results

    on<ClearSearchResultsEvent>((event, emit) async {
      emit(SearchPlacesLoading());
    });

    //!GET GEO ID
    on<GetGeoIDEvent>(
      (event, emit) async {
        emit(
          GetGeoIDLoading(),
        );

        final response = await getGeoID(event.params);

        emit(
          response.fold(
            (error) => GetGeoIDError(message: error),
            (response) => GetGeoIDLoaded(
              geoDataInfo: response,
            ),
          ),
        );
      },
      transformer: restartable(),
    );
  }
}
