import 'package:rideme_driver/features/informationResources/domain/entity/information_resource.dart';

class InformationResourceModel extends InformationResource {
  const InformationResourceModel({
    required super.name,
    required super.code,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.id,
  });

  factory InformationResourceModel.fromJson(Map<String, dynamic> json) {
    return InformationResourceModel(
      name: json['name'],
      code: json['code'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id: json['id'],
    );
  }
}
