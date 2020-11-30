import 'dart:io';

import 'package:flutter/material.dart';
import 'package:PetRoulette/services/injection_container.dart';

import '../app_config.dart';
import '../main.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  var configuredApp =
      new AppConfig(production: true, baseUrl: "https://petsapp.cloudns.cl/", adId: "ca-app-pub-4382391968703736/4403451736");

  configureInjection();

  runApp(new MyApp());
}
