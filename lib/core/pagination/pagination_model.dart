import 'package:rideme_driver/core/pagination/pagination_entity.dart';

class PaginationModel extends Pagination {
  const PaginationModel({
    required super.count,
    required super.total,
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
  });

  //fromJson
  factory PaginationModel.fromJson(Map<String, dynamic>? json) {
    return PaginationModel(
      count: json?['count'],
      total: json?['total'],
      currentPage: json?['current_page'],
      lastPage: json?['last_page'],
      perPage: json?['per_page'],
    );
  }
}
