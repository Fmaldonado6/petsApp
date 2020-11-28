import 'package:flutter/cupertino.dart';
import 'package:PetRoulette/models/models.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthInitialError extends AuthState {
  final String message;
  const AuthInitialError(this.message);
}

class AuthCompleted extends AuthState {
  final User user;
  const AuthCompleted(this.user);
}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);
}
