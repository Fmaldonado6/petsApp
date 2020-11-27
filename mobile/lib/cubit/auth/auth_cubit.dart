import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/cubit/auth/auth_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/api/auth/auth_service.dart';
import 'package:mobile/services/api/users/user_service.dart';
import 'package:mobile/services/exceptions/exceptions.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final UsersService _usersService;

  AuthCubit(this._authService, this._usersService) : super(AuthInitial());

  Future<void> init() async {
    try {
      emit(AuthLoading());

      final token = await _authService.getToken();

      if (token == null) return emit(AuthInitial());

      await _authService.saveToken(token);

      final tokenInfo = await _authService.getTokenInfo(token);

      final userInfo = await _usersService.getUserInfo(tokenInfo.id);

      UsersService.loggedUserInfo = userInfo;

      emit(AuthCompleted(userInfo));
    } on DioError catch (e) {
      if (e.error is AppError) return emit(AuthInitialError("Couldn´t login please try again"));
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    await this._authService.signOut();
    emit(AuthInitial());
  }

  Future<void> login(User user) async {
    try {
      emit(AuthLoading());

      final token = (await _authService.login(user))["token"];

      print(token);

      await _authService.saveToken(token);

      final tokenInfo = await _authService.getTokenInfo(token);

      final userInfo = await _usersService.getUserInfo(tokenInfo.id);

      UsersService.loggedUserInfo = userInfo;

      emit(AuthCompleted(userInfo));
    }on DioError catch (e) {

      if(e.error is NotFound ||e.error is Forbidden) emit(AuthInitialError("Wrong username or password"));

      emit(AuthInitialError("Couldn´t login, please try again"));
    }
  }
}
