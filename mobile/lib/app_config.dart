import 'package:flutter/material.dart';

class AppConfig {
  final bool production;
  final String baseUrl;

  static AppConfig _instance;

  factory AppConfig({bool production, String baseUrl}) {
    return _instance ??=
        AppConfig._internal(production: production, baseUrl: baseUrl);
  }

  AppConfig._internal({
    @required this.production,
    @required this.baseUrl,
  });
}
