part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

//!SEARCH PLACES
//loading
final class SearchPlacesLoading extends LocationState {}

//loaded
final class SearchPlacesLoaded extends LocationState {
  final Places places;

  const SearchPlacesLoaded({
    required this.places,
  });
}

//!GET GEO ID
//loading
final class GetGeoIDLoading extends LocationState {}

//loaded
final class GetGeoIDLoaded extends LocationState {
  final GeoData geoDataInfo;

  const GetGeoIDLoaded({
    required this.geoDataInfo,
  });
}

//error
final class GetGeoIDError extends LocationState {
  final String message;

  const GetGeoIDError({required this.message});
}

//error
final class SearchPlacesError extends LocationState {
  final String message;

  const SearchPlacesError({required this.message});
}
