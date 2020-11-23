import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/cubit/pets/pets_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/api/pets/pets_service.dart';

@injectable
class PetsCubit extends Cubit<PetsState> {
  final PetsService petsService;

  PetsCubit(this.petsService) : super(PetsLoading());

  Future<void> getPets() async {
    try {
      emit(PetsLoading());

      List<Pet> pets = await this.petsService.getPets();

      if (pets.length == 0) return emit(PetsEmpty());

      emit(PetsList(pets));
    } catch (e) {
      emit(PetsError(e.toString()));
    }
  }
}
