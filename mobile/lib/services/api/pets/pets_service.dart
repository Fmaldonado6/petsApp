import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/data_service.dart';

@injectable
class PetsService extends DataService {
  PetsService(AppConfig config) : super(config);

  Future<List<Pet>> getPets() async {
    List<dynamic> response = await this.get("/pets");
    print("Response " + response.toString());

    List<Pet> pets = response.map((e) => Pet.fromJson(e)).toList();

    return pets;
  }
}
