import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uiprojects/constant/constants.dart';

class APIService {
  APIService._();

  static final APIService instance = APIService._();

  Future<Map<String, dynamic>> makeRequest({
    required APIMethods apiMethod,
    String? codedPath,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      http.Response response = await _handelResponse(
        apiMethod: apiMethod,
        body: body,
        headers: headers,
        queryParameters: queryParameters,
        codedPath: codedPath,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> _handelResponse({
    required APIMethods apiMethod,
    String? codedPath,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    Uri uri = _getUri(codedPath: codedPath, queryParameters: queryParameters);
    http.Response response;
    try {
      switch (apiMethod) {
        case APIMethods.get:
          response = await http.get(
            uri,
            headers: headers,
          );
          break;
        case APIMethods.post:
          response = await http.post(
            uri,
            headers: headers,
            body: json.encode(body),
          );
          break;
        case APIMethods.put:
          response = await http.put(
            uri,
            headers: headers,
            body: json.encode(body),
          );
          break;
        case APIMethods.delete:
          response = await http.delete(
            uri,
            headers: headers,
            body: json.encode(body),
          );
          break;
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Uri _getUri({
    String? codedPath,
    Map<String, dynamic>? queryParameters,
  }) {
    Uri uri;
    if (codedPath != null && queryParameters != null) {
      uri = Uri.https(Constants.baseUrl, codedPath, queryParameters);
    }
    else if (codedPath != null) {
      uri = Uri.https(Constants.baseUrl,codedPath);
    }
    else {
      uri = Uri.https(Constants.baseUrl);
    }
    return uri;
  }
}

enum APIMethods {
  get,
  post,
  put,
  delete,
}
