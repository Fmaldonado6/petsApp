import 'package:flutter/material.dart';
import 'package:mobile/services/injection_container.dart';

import '../app_config.dart';
import '../main.dart';

void main() {
  var configuredApp =
      new AppConfig(production: true, baseUrl: "http://187.162.139.211:8080/");

  configureInjection();

  runApp(new MyApp());
}
