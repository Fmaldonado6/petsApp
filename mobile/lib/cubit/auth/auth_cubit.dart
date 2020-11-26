import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/cubit/auth/auth_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/api/auth/auth_service.dart';
import 'package:mobile/services/api/users/user_service.dart';
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
    } catch (e) {
      emit(AuthError("Error $e"));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    await this._authService.signOut();
    emit(AuthInitial());
  }

  Future<void> login(User user) async {
      emit(AuthLoading());

      final token = (await _authService.login(user))["token"];

      print(token);

      await _authService.saveToken(token);

      final tokenInfo = await _authService.getTokenInfo(token);

      final userInfo = await _usersService.getUserInfo(tokenInfo.id);

      UsersService.loggedUserInfo = userInfo;

      emit(AuthCompleted(userInfo));
  
  }
}
