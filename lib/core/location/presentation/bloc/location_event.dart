part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

//!SEARCH PLACES
final class SearchPlacesEvent extends LocationEvent {
  final Map<String, dynamic> params;

  const SearchPlacesEvent({required this.params});
}

//!GET GEO ID
final class GetGeoIDEvent extends LocationEvent {
  final Map<String, dynamic> params;

  const GetGeoIDEvent({
    required this.params,
  });
}

//!CLEAR SEARCH RESULTS
final class ClearSearchResultsEvent extends LocationEvent {}
