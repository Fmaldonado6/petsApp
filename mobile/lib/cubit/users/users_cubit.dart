import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/cubit/users/users_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/api/pets/pets_service.dart';
import 'package:mobile/services/api/pictures/pictures_service.dart';
import 'package:mobile/services/api/users/user_service.dart';

@injectable
class UsersCubit extends Cubit<UsersState> {
  final UsersService _usersService;
  final PetsService _petsService;
  final PicturesService _picturesService;
  UsersCubit(this._usersService, this._petsService, this._picturesService)
      : super(UsersLoading());

  Future<void> getUserInfo(String id) async {
    try {
      emit(UsersLoading());

      User users = await this._usersService.getUserInfo(id);

      emit(UsersCompleted(users));
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  Future<bool> deleteUserPet(Pet pet) async {
    try {
      emit(UsersLoading());

      await this._petsService.deletePet(pet);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeProfilePicture(PickedFile file, User user) async {
    try {
      emit(UsersLoading());
      user.pets = null;
      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: file.path.split("/").last),
        "petId": "",
        "extension": file.path.split(".").last
      });

      Picture addedPicture = await _picturesService.addPicture(formData);
      user.profilePictureId = addedPicture.id;

      await _usersService.updateUser(user);

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }
}
