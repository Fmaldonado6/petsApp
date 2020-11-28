import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/services/data_service.dart';

@injectable
class PetsService extends DataService {
  PetsService(AppConfig config) : super(config);

  Future<List<Pet>> getPets() async {
    Response response = await dio.get(apiUrl + "/pets");
    final json = response.data as List<Object>;

    return json.map((e) => Pet.fromJson(e)).toList();
  }

  Future<Pet> addPets(Pet pet) async {
    Response response = await dio.post(apiUrl + "/pets", data: pet);

    return Pet.fromJson(response.data);
  }

  Future<Pet> updatePet(Pet pet) async {
    Response response = await dio.put(apiUrl + "/pets/${pet.id}", data: pet);

    return Pet.fromJson(response.data);
  }

  Future<void> deletePet(Pet pet) async {
    await dio.delete(apiUrl + "/pets/${pet.id}");
  }
}
