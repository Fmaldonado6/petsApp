import 'dart:io';

import 'package:flutter/material.dart';
import 'package:PetRoulette/services/injection_container.dart';

import '../app_config.dart';
import '../main.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  var configuredApp = new AppConfig(
      production: false,
      baseUrl: "http://192.168.1.84:8080/",
      adId: "ca-app-pub-3940256099942544/2247696110");

  configureInjection();

  runApp(new MyApp());
}
