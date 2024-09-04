import 'package:flutter/foundation.dart';
import 'package:rideme_driver/core/enums/endpoints.dart';

class URLS {
  final UrlParser urlParser = UrlParser();

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  returnUri({
    required String locale,
    required Endpoints endpoint,
    required Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? urlParameters,
  }) {
    const baseUrl = kDebugMode ? 'dev.rideme.app' : 'dev.rideme.app';
    //  const testBaseUrl = 'testv3.shaqexpress.com';
    String lastRoute = '/v1/$locale/drivers${endpoint.value}';

    String parsedRoute = urlParser.urlPasser(urlParameters, lastRoute);

    return Uri.https(baseUrl, parsedRoute, queryParameters);
  }
}

class UrlParser {
  String urlPasser(Map<String, dynamic>? urlParameters, String lastRoute) {
    // check for any word that starts with :
    final RegExp placeholderRegex = RegExp(r':\w+');

    // Find all placeholders in the URL pattern
    Iterable<Match> matches = placeholderRegex.allMatches(lastRoute);

    if (urlParameters == null || matches.isEmpty) {
      return lastRoute;
    }

    for (Match match in matches) {
      String? key = match.group(0);

      if (key != null) {
        // remove : from key
        String trimmedKey = key.substring(1);
        if (urlParameters.containsKey(trimmedKey)) {
          // replace key with value in map
          lastRoute =
              lastRoute.replaceAll(key, urlParameters[trimmedKey].toString());
        }
      }
    }
    return lastRoute;
  }
}
