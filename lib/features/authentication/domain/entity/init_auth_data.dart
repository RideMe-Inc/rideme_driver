import 'package:equatable/equatable.dart';

class InitAuthData extends Equatable {
  final String? token;

  const InitAuthData({required this.token});

  @override
  List<Object?> get props => [token];
}
