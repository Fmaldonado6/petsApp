import 'package:flutter/cupertino.dart';
import 'package:PetRoulette/models/models.dart';

@immutable
abstract class UsersState {
  const UsersState();
}

class UsersLoading extends UsersState {
  const UsersLoading();
}

class UsersList extends UsersState {
  final List<User> users;
  const UsersList(this.users);
}

class UsersCompleted extends UsersState {
  final User user;
  const UsersCompleted(this.user);
}

class UsersError extends UsersState {
  final String error;

  const UsersError(this.error);
}
