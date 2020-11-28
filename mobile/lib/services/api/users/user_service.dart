import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/services/data_service.dart';

@injectable
class UsersService extends DataService {
  static User loggedUserInfo;

  UsersService(AppConfig config) : super(config);

  Future<User> getUserInfo(String id) async {
    final info = await dio.get(apiUrl + "/users/$id");

    return User.fromJson(info.data);
  }

  Future<User> addUser(User user) async {
    Response response = await dio.post(apiUrl + "/users", data: user);

    return User.fromJson(response.data);
  }

  Future<User> updateUser(User user) async {
    final info = await dio.put(apiUrl + "/users/${user.id}", data: user);

    return User.fromJson(info.data);
  }
}
