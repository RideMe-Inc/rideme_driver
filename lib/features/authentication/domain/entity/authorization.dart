import 'package:equatable/equatable.dart';

class Authorization extends Equatable {
  final String? token, type, refreshTtl, ttl;

  const Authorization({
    required this.token,
    required this.type,
    required this.refreshTtl,
    required this.ttl,
  });

  Map<String, dynamic> toMap() => {
        'token': token,
        'type': type,
        'refresh_ttl': refreshTtl,
        'ttl': ttl,
      };

  @override
  List<Object?> get props => [
        token,
        type,
        refreshTtl,
        ttl,
      ];
}
