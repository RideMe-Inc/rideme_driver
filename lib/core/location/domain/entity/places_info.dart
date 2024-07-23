import 'package:equatable/equatable.dart';

class Places extends Equatable {
  final List<PlaceInfo>? places;

  const Places({required this.places});

  @override
  List<Object?> get props => [
        places,
      ];
}

class PlaceInfo extends Equatable {
  final String id, name;
  final DisplayName structuredFormatting;

  const PlaceInfo({
    required this.id,
    required this.name,
    required this.structuredFormatting,
  });

  @override
  List<Object?> get props => [id, name];
}

class DisplayName extends Equatable {
  final String? mainText;

  const DisplayName({required this.mainText});

  @override
  List<Object?> get props => [mainText];
}
