import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/src/client.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/api/users/user_service.dart';
import 'package:mobile/services/data_service.dart';

@injectable
class AuthService extends DataService {
  final FlutterSecureStorage _secureStorage;

  static String token;

  AuthService(AppConfig config, this._secureStorage) : super(config);

  Future<dynamic> login(User user) async {
    Response response = await dio.post(apiUrl + "/auth", data: user);


    return jsonDecode(response.data);
  }

  Future<User> getTokenInfo(String token) async {
    final parts = token.split('.');
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));
    final map = json.decode(resp)["sub"];
    final user = User.fromJson(jsonDecode(map));
    return user;
  }

  Future<void> signOut() async {
    await _secureStorage.delete(key: "refresh_token");
    UsersService.loggedUserInfo = null;
  }

  Future<void> saveToken(String token) async {
    AuthService.token = token;
    await _secureStorage.write(key: "refresh_token", value: token);
  }

  Future<String> getToken() async {
    return await _secureStorage.read(key: "refresh_token");
  }
}
