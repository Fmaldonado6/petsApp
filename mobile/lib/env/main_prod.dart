import 'package:flutter/material.dart';
import 'package:mobile/services/injection_container.dart';

import '../app_config.dart';
import '../main.dart';

void main() {
  var configuredApp =
      new AppConfig(production: true, baseUrl: "https://petsapp.cloudns.cl:8080/");

  configureInjection();

  runApp(new MyApp());
}
