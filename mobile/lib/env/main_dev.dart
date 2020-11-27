import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/services/injection_container.dart';

import '../app_config.dart';
import '../main.dart';

void main() {
  var configuredApp =
      new AppConfig(production: false, baseUrl: "http://192.168.1.84:8080/");

  configureInjection();

  runApp(new MyApp());
}
