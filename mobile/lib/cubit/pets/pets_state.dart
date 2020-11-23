import 'package:flutter/cupertino.dart';
import 'package:mobile/models/models.dart';

@immutable
abstract class PetsState {
  const PetsState();
}

class PetsLoading extends PetsState {
  const PetsLoading();
}

class PetsList extends PetsState {
  final List<Pet> pets;
  const PetsList(this.pets);
}

class PetsCompleted extends PetsState {
  final Pet pet;
  const PetsCompleted(this.pet);
}

class PetsError extends PetsState {
  final String error;

  const PetsError(this.error);
}

class PetsEmpty extends PetsState {
  const PetsEmpty();
}
