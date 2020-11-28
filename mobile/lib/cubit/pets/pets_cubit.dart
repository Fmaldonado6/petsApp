import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:PetRoulette/cubit/pets/pets_state.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/services/api/auth/auth_service.dart';
import 'package:PetRoulette/services/api/pets/pets_service.dart';
import 'package:PetRoulette/services/api/pictures/pictures_service.dart';
import 'package:PetRoulette/services/api/reports/reports_service.dart';
import 'package:PetRoulette/services/api/users/user_service.dart';
import 'package:PetRoulette/services/exceptions/exceptions.dart';

@injectable
class PetsCubit extends Cubit<PetsState> {
  final PetsService petsService;
  final PicturesService picturesService;
  final ReportsService reportsService;
  PetsCubit(this.petsService, this.picturesService, this.reportsService)
      : super(PetsLoading());

  Future<void> getPets() async {
    try {
      emit(PetsLoading());

      List<Pet> pets = await this.petsService.getPets();

      if (pets.length == 0) return emit(PetsEmpty());

      emit(PetsList(pets));
    } catch (e) {
      print(e);
      emit(PetsError(e.toString()));
    }
  }

  void initForm() {
    emit(PetsForm());
  }

  bool isOwner(Pet pet) {
    return UsersService.loggedUserInfo.id == pet.ownerId;
  }

  Future<bool> updatePet(Pet pet) async {
    try {
      await this.petsService.updatePet(pet);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addReport(Report report) async {
    try {
      await this.reportsService.addReport(report);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addPet(PickedFile file, Pet pet) async {
    var newPet;

    try {
      emit(PetsLoading());

      newPet = await petsService.addPets(pet);

      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: file.path.split("/").last),
        "petId": newPet.id,
        "extension": file.path.split(".").last
      });

      final savedPicture = await picturesService.addPicture(formData);

      newPet.profilePictureId = savedPicture.id;

      final updatedPet = await petsService.updatePet(newPet);

      emit(PetsCompleted(updatedPet));
    } on DioError catch (e) {
      if (newPet != null) petsService.deletePet(newPet);

      if (e.error is BadInput)
        return emit(PetsError("The maximum size of an image is 5mb"));

      return emit(PetsError("Couldn´t add pet!"));
    } catch (e) {
      return emit(PetsError("Couldn´t add pet!"));
    }
  }
}
