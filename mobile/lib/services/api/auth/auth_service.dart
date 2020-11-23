import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/src/client.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/data_service.dart';

@injectable
class AuthService extends DataService {
  final FlutterSecureStorage _secureStorage;

  static String token;

  AuthService(AppConfig config, this._secureStorage) : super(config);

  Future<dynamic> login(User user) {
    return this.post("/auth", user);
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

  Future<void> saveToken(String token) async {
    AuthService.token = token;
    await _secureStorage.write(key: "refresh_token", value: token);
  }

  Future<String> getToken() async {
    return await _secureStorage.read(key: "refresh_token");
  }
}
