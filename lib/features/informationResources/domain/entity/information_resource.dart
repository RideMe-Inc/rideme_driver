import 'package:equatable/equatable.dart';

class InformationResource extends Equatable {
  final String? name, code, status, createdAt, updatedAt;
  final num? id;

  const InformationResource({
    required this.name,
    required this.code,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        code,
        status,
        createdAt,
        updatedAt,
        id,
      ];
}
