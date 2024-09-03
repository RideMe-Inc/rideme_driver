import 'package:http/http.dart' as http;
import 'package:rideme_driver/core/enums/endpoints.dart';
import 'package:rideme_driver/core/mixins/remote_request_mixin.dart';
import 'package:rideme_driver/core/urls/urls.dart';
import 'package:rideme_driver/features/informationResources/data/model/information_resource_model.dart';

abstract class InformationResourcesRemoteDatastore {
  ///GET COMPANIES
  Future<List<InformationResourceModel>> getAllVehicleMakes(
    Map<String, dynamic> params,
  );

  ///GET ALL VEHICLE BRANDS
  Future<List<InformationResourceModel>> getAllVehicleModels(
    Map<String, dynamic> params,
  );
}

class InformationResourcesRemoteDatastoreImpl
    with RemoteRequestMixin
    implements InformationResourcesRemoteDatastore {
  final URLS urls;
  final http.Client client;

  InformationResourcesRemoteDatastoreImpl(
      {required this.urls, required this.client});

  @override
  Future<List<InformationResourceModel>> getAllVehicleModels(
      Map<String, dynamic> params) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.vehicleModels,
    );

    return decodedResponse['data']
        .map<InformationResourceModel>(
          (e) => InformationResourceModel.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<InformationResourceModel>> getAllVehicleMakes(
    Map<String, dynamic> params,
  ) async {
    final decodedResponse = await get(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.vehicleMakes,
    );

    return decodedResponse['data']
        .map<InformationResourceModel>(
          (e) => InformationResourceModel.fromJson(e),
        )
        .toList();
  }
}
