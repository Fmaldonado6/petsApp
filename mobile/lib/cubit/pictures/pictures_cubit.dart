import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/cubit/pictures/pictures_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/api/pictures/pictures_service.dart';

@injectable
class PicturesCubit extends Cubit<PicturesState> {
  final PicturesService picturesService;

  PicturesCubit(this.picturesService) : super(PicturesLoading());

  Future<void> getPetPictures(String id) async {
    try {
      emit(PicturesLoading());

      List<Picture> pictures = await this.picturesService.getPetPictures(id);

      if (pictures.length == 0) return emit(PicturesEmpty());

      emit(PicturesList(pictures));
    } catch (e) {
      print(e);
      emit(PicturesError(e.toString()));
    }
  }

  Future<bool> addPicture(Picture picture, PickedFile file) async {
    try {
      emit(PicturesLoading());

        FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: file.path.split("/").last),
        "petId": picture.petId,
        "extension": file.path.split(".").last
      });

      Picture newPicture =
          await this.picturesService.addPicture(formData);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePicture(Picture picture) async {
    try {
      emit(PicturesLoading());

      await this.picturesService.deletePicture(picture);

      return true;
    } catch (e) {
      return false;
    }
  }
}
