import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:rideme_driver/core/enums/endpoints.dart';
import 'package:rideme_driver/core/exceptions/generic_exception_class.dart';
import 'package:rideme_driver/core/mixins/remote_request_mixin.dart';
import 'package:rideme_driver/core/urls/urls.dart';
import 'package:rideme_driver/features/authentication/data/model/authentication_model.dart';
import 'package:rideme_driver/features/authentication/data/model/authorization_model.dart';
import 'package:rideme_driver/features/authentication/data/model/init_auth_info_model.dart';

abstract class AuthenticationRemoteDatasource {
  // init auth
  Future<InitAuthInfoModel> initAuth(Map<String, dynamic> params);

  // verify token
  Future<AuthenticationModel> verifyOtp(Map<String, dynamic> params);

  // sign up
  Future<AuthenticationModel> signUp(Map<String, dynamic> params);

  //get refresh token

  Future<AuthorizationModel> getRefreshToken(Map<String, dynamic> params);

  //logout

  Future<String> logOut(Map<String, dynamic> params);
}

class AuthenticationRemoteDatasourceImpl
    with RemoteRequestMixin
    implements AuthenticationRemoteDatasource {
  final http.Client client;
  final URLS urls;
  final FirebaseMessaging messaging;

  AuthenticationRemoteDatasourceImpl({
    required this.client,
    required this.urls,
    required this.messaging,
  });

  //! INIT AUTH
  @override
  Future<InitAuthInfoModel> initAuth(Map<String, dynamic> params) async {
    final decodedResponse = await post(
      client: client,
      urls: urls,
      params: params,
      endpoint: Endpoints.initAuth,
    );

    return InitAuthInfoModel.fromJson(decodedResponse);
  }

  //! SIGN UP
  @override
  Future<AuthenticationModel> signUp(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: Endpoints.signUp,
      queryParameters: null,
      urlParameters: null,
    );

    //get device fcm token
    final fcmToken = await messaging.getToken();

    final body = params['body'];

    final finalbody = {'fcm_token': fcmToken};

    finalbody.addAll(body);

    //make request
    final response = await client.post(
      uri,
      headers: urls.headers,
      body: jsonEncode(finalbody),
    );

    final decodedResponse = json.decode(response.body);

    if (response.statusCode != 200) {
      throw ErrorException(decodedResponse['message']);
    }

    return AuthenticationModel.fromJson(decodedResponse);
  }

  //! VERIFY OTP
  @override
  Future<AuthenticationModel> verifyOtp(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: Endpoints.verifyOTP,
      queryParameters: null,
      urlParameters: null,
    );

    //get device fcm token

    final fcmToken = await messaging.getToken();

    final body = params['body'];

    final finalbody = <String, dynamic>{'fcm_token': fcmToken};

    finalbody.addAll(body);

    //make request

    final response = await client.post(
      uri,
      headers: urls.headers,
      body: jsonEncode(finalbody),
    );

    final decodedResponse = json.decode(response.body);

    if (response.statusCode != 200) {
      throw ErrorException(decodedResponse['message']);
    }

    return AuthenticationModel.fromJson(decodedResponse);
  }

  //!GET REFRESH TOKEN

  @override
  Future<AuthorizationModel> getRefreshToken(
      Map<String, dynamic> params) async {
    final decodedResponse = await get(
      endpoint: Endpoints.getRefereshToken,
      client: client,
      urls: urls,
      params: params,
    );

    return AuthorizationModel.fromJson(decodedResponse['authorization']);
  }

  //lOG OUT

  @override
  Future<String> logOut(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: Endpoints.logOut,
      queryParameters: null,
      urlParameters: null,
    );

    Map<String, String> headers = urls.headers;

    headers.addAll(<String, String>{"Authorization": params['bearer']});

    // get device fcm token

    final fcmToken = await messaging.getToken();

    Map<String, dynamic> body = {
      "fcm_token": fcmToken,
    };

    //make request

    final response =
        await client.post(uri, headers: headers, body: jsonEncode(body));

    final decodedResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return decodedResponse['message'];
    } else {
      throw ErrorException(decodedResponse['message']);
    }
  }
}
