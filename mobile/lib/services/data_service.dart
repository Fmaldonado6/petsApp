import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../app_config.dart';
import 'api/auth/auth_service.dart';
import 'exceptions/exceptions.dart';

class DataService {
  AppConfig config;

  String apiUrl;

  final dio = Dio();

  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${AuthService.token}',
  };
  DataService(this.config) {
    this.apiUrl = this.config.baseUrl + "api/v1";

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) {
        options.headers[HttpHeaders.authorizationHeader] =
            AuthService.token != null ? 'Bearer ${AuthService.token}' : null;
        return options;
      },
      onError: (e) {
        print("Error: " + e.response.statusCode.toString());
        switch (e.response.statusCode) {
          case 400:
            throw BadInput(e.message);
          case 403:
            throw Forbidden(e.message);
          case 404:
            throw NotFound(e.message);
          case 409:
            throw Conflict(e.message);
          default:
            throw AppError(e.message);
        }
      },
    ));
  }
}
