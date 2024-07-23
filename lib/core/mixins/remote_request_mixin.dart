import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rideme_driver/core/enums/endpoints.dart';
import 'package:rideme_driver/core/exceptions/generic_exception_class.dart';
import 'package:rideme_driver/core/urls/urls.dart';

mixin RemoteRequestMixin {
  //GET
  Future<Map<String, dynamic>> get({
    required Endpoints endpoint,
    required URLS urls,
    required Map<String, dynamic> params,
    required http.Client client,
  }) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: endpoint,
      queryParameters: params['queryParameters'],
      urlParameters: params['urlParameters'],
    );

    final headers = urls.headers;

    if (params['bearer'] != null) {
      headers.addAll({'Authorization': "Bearer ${params['bearer']}"});
    }

    final response = await client.get(
      uri,
      headers: headers,
    );

    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      switch (response.statusCode) {
        case 422 || 404 || 401 || 400 || 500:
          throw ErrorException(decodedResponse['message']);

        default:
          throw ErrorException('An error occured');
      }
    }

    return decodedResponse;
  }

  //POST
  Future<Map<String, dynamic>> post({
    required Endpoints endpoint,
    required URLS urls,
    required Map<String, dynamic> params,
    required http.Client client,
  }) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: endpoint,
      queryParameters: params['queryParameters'],
      urlParameters: params['urlParameters'],
    );

    final headers = urls.headers;
    if (params['bearer'] != null) {
      headers.addAll({'Authorization': "Bearer ${params['bearer']}"});
    }

    final response = await client.post(
      uri,
      headers: headers,
      body: jsonEncode(
        params['body'],
      ),
    );

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      switch (response.statusCode) {
        case 422 || 404 || 401 || 400 || 500:
          throw ErrorException(decodedResponse['message']);

        default:
          throw ErrorException('An error occured');
      }
    }

    return decodedResponse;
  }

  //DELETE
  Future<Map<String, dynamic>> delete({
    required Endpoints endpoint,
    required URLS urls,
    required Map<String, dynamic> params,
    required http.Client client,
  }) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: endpoint,
      queryParameters: params['queryParameters'],
      urlParameters: params['urlParameters'],
    );

    final headers = urls.headers;
    headers.addAll({'Authorization': "Bearer ${params['bearer']}"});

    final response = await client.delete(
      uri,
      headers: headers,
      body: jsonEncode(
        params['body'],
      ),
    );

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      switch (response.statusCode) {
        case 422 || 404 || 401 || 400 || 500:
          throw ErrorException(decodedResponse['message']);

        default:
          throw ErrorException('An error occured');
      }
    }

    return decodedResponse;
  }

  //PATCH
  Future<Map<String, dynamic>> patch({
    required Endpoints endpoint,
    required URLS urls,
    required Map<String, dynamic> params,
    required http.Client client,
  }) async {
    final uri = urls.returnUri(
      locale: params['locale'],
      endpoint: endpoint,
      queryParameters: params['queryParameters'],
      urlParameters: params['urlParameters'],
    );

    final headers = urls.headers;
    headers.addAll({'Authorization': "Bearer ${params['bearer']}"});

    final response = await client.patch(
      uri,
      headers: headers,
      body: jsonEncode(
        params['body'],
      ),
    );

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      switch (response.statusCode) {
        case 422 || 404 || 401 || 400 || 500:
          throw ErrorException(decodedResponse['message']);

        default:
          throw ErrorException('An error occured');
      }
    }

    return decodedResponse;
  }
}
