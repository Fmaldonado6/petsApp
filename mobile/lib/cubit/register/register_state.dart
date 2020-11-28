import 'package:flutter/cupertino.dart';
import 'package:PetRoulette/models/models.dart';

@immutable
abstract class RegisterState {
  const RegisterState();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterCompleted extends RegisterState {
  const RegisterCompleted();
}

class RegisterRepeated extends RegisterState {
  final String error;

  const RegisterRepeated(this.error);
}

class RegisterError extends RegisterState {
  final String error;

  const RegisterError(this.error);
}
