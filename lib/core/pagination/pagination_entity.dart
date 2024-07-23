import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int? count, total, currentPage, lastPage, perPage;

  const Pagination(
      {required this.count,
      required this.total,
      required this.currentPage,
      required this.lastPage,
      required this.perPage});

  @override
  List<Object?> get props => [count, total, currentPage, lastPage, perPage];
}
