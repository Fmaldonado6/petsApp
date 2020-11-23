import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_config.dart';
import 'api/auth/auth_service.dart';
import 'exceptions/exceptions.dart';

class DataService {
  AppConfig config;

  String apiUrl;
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${AuthService.token}',
  };
  DataService(this.config) {
    this.apiUrl = this.config.baseUrl + "api/v1";
  }

  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      final response = await http.get(
        apiUrl + url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              AuthService.token != null ? 'Bearer ${AuthService.token}' : null,
        },
      );
      print(apiUrl + url);

      responseJson = _returnResponse(response);
      print("JSON " + responseJson.toString());
    } catch (e) {
      AppError(e.toString());
    }

    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;

    try {
      final response = await http.delete(
        apiUrl + url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              AuthService.token != null ? 'Bearer ${AuthService.token}' : null,
        },
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      AppError(e.toString());
    }

    return responseJson;
  }

  Future<dynamic> post(String url, dynamic object) async {
    var responseJson;
    try {
      final response = await http.post(
        apiUrl + url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              AuthService.token != null ? 'Bearer ${AuthService.token}' : null,
        },
        body: jsonEncode(object),
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      throw AppError(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic object) async {
    var responseJson;

    try {
      final response = await http.put(
        apiUrl + url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              AuthService.token != null ? 'Bearer ${AuthService.token}' : null,
        },
        body: jsonEncode(object),
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      AppError(e.toString());
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadInput(response.body.toString());
      case 404:
        throw NotFound(response.body.toString());
      default:
        throw AppError(response.body.toString());
    }
  }
}
