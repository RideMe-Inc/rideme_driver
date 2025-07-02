import 'package:rideme_driver/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.rating,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.email,
    required super.profileUrl,
    required super.status,
    required super.requestedDeletion,
    required super.hasLicense,
    required super.hasVehicle,
    required super.photoCheckRequired,
    required super.availability,
    required super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
      id: json?['id'],
      rating: json?['rating'],
      firstName: json?['first_name'],
      lastName: json?['last_name'],
      phone: json?['phone'],
      email: json?['email'],
      profileUrl: json?['profile_image_url'],
      availability: json?['availability'],
      status: json?['status'],
      hasLicense: json?['has_license'],
      address: json?['address'],
      hasVehicle: json?['has_vehicle'],
      photoCheckRequired: json?['photo_check_required'],
      requestedDeletion: json?['requested_deletion'],
    );
  }
}
