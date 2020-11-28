import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:PetRoulette/app_config.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;
@injectableInit
void configureInjection() => $initGetIt(getIt);

@module
abstract class RegisterModule {
  @singleton
  http.Client get client => http.Client();

  @singleton
  AppConfig get config => AppConfig();

  @singleton
  FlutterSecureStorage get flutterSecureStorage;
}
