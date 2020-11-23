// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../app_config.dart';
import '../cubit/auth/auth_cubit.dart';
import 'api/auth/auth_service.dart';
import '../cubit/pets/pets_cubit.dart';
import 'api/pets/pets_service.dart';
import 'injection_container.dart';
import 'api/users/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<PetsService>(() => PetsService(get<AppConfig>()));
  gh.factory<UsersService>(() => UsersService(get<AppConfig>()));
  gh.factory<AuthService>(
      () => AuthService(get<AppConfig>(), get<FlutterSecureStorage>()));
  gh.factory<PetsCubit>(() => PetsCubit(get<PetsService>()));
  gh.factory<AuthCubit>(
      () => AuthCubit(get<AuthService>(), get<UsersService>()));

  // Eager singletons must be registered in the right order
  gh.singleton<AppConfig>(registerModule.config);
  gh.singleton<Client>(registerModule.client);
  gh.singleton<FlutterSecureStorage>(registerModule.flutterSecureStorage);
  return get;
}

class _$RegisterModule extends RegisterModule {
  @override
  FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage();
}
