import 'package:flutter/material.dart';

class AppConfig {
  final bool production;
  final String baseUrl;
  final String adId;
  static AppConfig _instance;

  factory AppConfig({bool production, String baseUrl, String adId}) {
    return _instance ??= AppConfig._internal(
        production: production, baseUrl: baseUrl, adId: adId);
  }

  AppConfig._internal({
    @required this.production,
    @required this.baseUrl,
    @required this.adId
  });
}
