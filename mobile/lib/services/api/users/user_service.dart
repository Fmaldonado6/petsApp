import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/data_service.dart';

@injectable
class UsersService extends DataService {
  UsersService(AppConfig config) : super(config);

  Future<User> getUserInfo(String id) async {
    final info = await this.get("/users/$id");
    print(info);

    User user = User.fromJson(info);

    return user;
  }
}
