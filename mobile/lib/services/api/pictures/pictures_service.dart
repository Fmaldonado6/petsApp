import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/services/data_service.dart';

@injectable
class PicturesService extends DataService {
  PicturesService(AppConfig config) : super(config);

  Future<List<Picture>> getPetPictures(String id) async {
    final response = await dio.get(apiUrl + "/pictures/pet/$id");
    final json = response.data as List<Object>;
    List<Picture> list = json.map((e) => Picture.fromJson(e)).toList();
    return list;
  }

  Future<Picture> addPicture(FormData formData) async {
    Response response = await dio.post(apiUrl + "/pictures", data: formData);

    return Picture.fromJson(response.data);
  }

  Future<void> deletePicture(Picture picture) async {
    await dio.delete(apiUrl + "/pictures/${picture.id}");
  }
}
