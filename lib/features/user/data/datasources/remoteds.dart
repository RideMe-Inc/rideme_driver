import 'package:rideme_driver/core/enums/endpoints.dart';
import 'package:rideme_driver/core/mixins/remote_request_mixin.dart';
import 'package:rideme_driver/core/urls/urls.dart';
import 'package:rideme_driver/features/user/data/models/all_license_info_model.dart';
import 'package:rideme_driver/features/user/data/models/profile_info_model.dart';
import 'package:rideme_driver/features/user/data/models/rider_vehicleinfo_model.dart';
import 'package:rideme_driver/features/user/data/models/support_data_model.dart';
import 'package:rideme_driver/features/user/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:rideme_driver/features/user/domain/entities/license_info.dart';

abstract class UserRemoteDatasource {
  //get user profile
  Future<UserModel> getUserProfile(Map<String, dynamic> params);

  //delete account
  Future<String> deleteAccount(Map<String, dynamic> params);

  //edit  profile
  Future<UserModel> editProfile(Map<String, dynamic> params);

  //create or edit driver's license
  Future<LicenseInfo> createDriverLicense(
    Map<String, dynamic> params,
  );
  //create or edit driver's license
  Future<LicenseInfo> editDriverLicense(
    Map<String, dynamic> params,
  );

  //get all rider license
  Future<LicenseInfo> getAllLicense(Map<String, dynamic> params);

  /// Change availability
  Future<UserModel> changeAvailability(Map<String, dynamic> params);

  ///Photo check
  Future<ProfileInfoModel> riderPhotoCheck(Map<String, dynamic> params);

  //Create vehicle
  Future<RiderVehicleInfoModel> createVehicle(Map<String, dynamic> params);
  //Create vehicle
  Future<RiderVehicleInfoModel> editVehicle(Map<String, dynamic> params);

  //get all vehicles
  Future<RiderVehicleInfoModel> getAllVehicles(Map<String, dynamic> params);

  //get support contacts
  Future<SupportDataModel> getSupportContacts(Map<String, dynamic> params);
}

class UserRemoteDatasourceImpl
    with RemoteRequestMixin
    implements UserRemoteDatasource {
  final http.Client client;
  final URLS urls;

  UserRemoteDatasourceImpl({
    required this.client,
    required this.urls,
  });
  @override
  Future<UserModel> getUserProfile(Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      endpoint: Endpoints.profile,
      params: params,
    );

    print(decodedResponse);

    return UserModel.fromJson(decodedResponse['profile']);
  }

  //DELETE ACCOUNT

  @override
  Future<String> deleteAccount(Map<String, dynamic> params) async {
    final decodedResponse = await delete(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.profile,
    );

    return decodedResponse['message'];
  }

  //EDIT PROFILE

  @override
  Future<UserModel> editProfile(Map<String, dynamic> params) async {
    final decodedResponse = await patch(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.profile,
    );

    return UserModel.fromJson(decodedResponse['profile']);
  }

  //! Get All Riders License
  @override
  Future<LicenseInfoModel> getAllLicense(Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.licenses,
    );

    return LicenseInfoModel.fromJson(decodedResponse);
  }

  //! CHANGE AVAILABILITY
  @override
  Future<UserModel> changeAvailability(Map<String, dynamic> params) async {
    final decodedResponse = await post(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.availability,
    );

    return UserModel.fromJson(decodedResponse['profile']);
  }

  //photo check
  @override
  Future<ProfileInfoModel> riderPhotoCheck(Map<String, dynamic> params) async {
    final decodedResponse = await post(
      endpoint: Endpoints.photoCheck,
      urls: urls,
      params: params,
      client: client,
    );

    return ProfileInfoModel.fromJson(decodedResponse);
  }

  @override
  Future<LicenseInfo> editDriverLicense(Map<String, dynamic> params) async {
    final decodedResponse = await patch(
      endpoint: Endpoints.editLicense,
      urls: urls,
      params: params,
      client: client,
    );

    return LicenseInfoModel.fromJson(decodedResponse);
  }

  //! CREATE OR EDIT RIDER VEHICLE
  @override
  Future<RiderVehicleInfoModel> createVehicle(
    Map<String, dynamic> params,
  ) async {
    final decodedResponse = await post(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.vehicles,
    );
    return RiderVehicleInfoModel.fromJson(decodedResponse);
  }

  //! GET ALL VEHICLES
  @override
  Future<RiderVehicleInfoModel> getAllVehicles(
    Map<String, dynamic> params,
  ) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.vehicles,
    );

    return RiderVehicleInfoModel.fromJson(decodedResponse);
  }

  @override
  Future<RiderVehicleInfoModel> editVehicle(Map<String, dynamic> params) async {
    final decodedResponse = await patch(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.editVehicles,
    );
    return RiderVehicleInfoModel.fromJson(decodedResponse);
  }

  @override
  Future<SupportDataModel> getSupportContacts(
      Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.getSupportContacts,
    );

    return SupportDataModel.fromJson(decodedResponse['data']);
  }

  //! Create or Edit Rider license
  @override
  Future<LicenseInfoModel> createDriverLicense(
      Map<String, dynamic> params) async {
    final decodedResponse = await post(
      endpoint: Endpoints.licenses,
      urls: urls,
      params: params,
      client: client,
    );

    return LicenseInfoModel.fromJson(decodedResponse);
  }
}
