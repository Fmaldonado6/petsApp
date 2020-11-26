import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/cubit/register/register_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/api/users/user_service.dart';
import 'package:mobile/services/exceptions/exceptions.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final UsersService _usersService;

  RegisterCubit(this._usersService) : super(RegisterInitial());

  void initForm() {
    emit(RegisterInitial());
  }

  Future<void> register(User user) async {
    try {
      emit(RegisterLoading());

      final newUser = await this._usersService.addUser(user);

      emit(RegisterCompleted());
    } on DioError catch (e) {

      print(e);

      if (e.error is Conflict) return emit(RegisterRepeated(e.message));

      emit(RegisterError(e.message));
    } on Exception catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
