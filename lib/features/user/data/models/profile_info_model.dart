import 'package:rideme_driver/features/user/data/models/user_model.dart';
import 'package:rideme_driver/features/user/domain/entities/profile_info.dart';

class ProfileInfoModel extends ProfileInfo {
  const ProfileInfoModel({required super.message, required super.rider});

// fromJson

  factory ProfileInfoModel.fromJson(Map<String, dynamic>? json) {
    return ProfileInfoModel(
      message: json?['message'],
      rider: UserModel.fromJson(json?['driver']),
    );
  }
}
