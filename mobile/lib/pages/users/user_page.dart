import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/cubit/pets/pets_cubit.dart';
import 'package:mobile/cubit/users/users_cubit.dart';
import 'package:mobile/cubit/users/users_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/pages/users/widgets/user_information.dart';
import 'package:mobile/services/injection_container.dart';
import 'package:mobile/shared_widgets/empty_widget.dart';
import 'package:mobile/shared_widgets/error_widget.dart';

class UserPage extends StatefulWidget {
  final String id;

  UserPage({Key key, this.id}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _usersCubit = getIt.get<UsersCubit>();
  User loadedUser;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _usersCubit.close();
  }

  void getUserInfo() {
    _usersCubit.getUserInfo(widget.id);
  }

  void chanegeProfilePicture() async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: ImageSource.gallery);

    if (file == null) return;

    await _usersCubit.changeProfilePicture(file, loadedUser);

    await _usersCubit.getUserInfo(widget.id);
  }

  void deletePet(Pet pet) async {
    await this._usersCubit.deleteUserPet(pet);

    await _usersCubit.getUserInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: BlocBuilder<UsersCubit, UsersState>(
          cubit: _usersCubit,
          builder: (context, state) {
            if (state is UsersLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            if (state is UsersCompleted) {
              loadedUser = state.user;
              return UserInformation(
                user: state.user,
                getUserInfo: getUserInfo,
                changeProfilePicture: chanegeProfilePicture,
                deletePet: deletePet,
              );
            }

            if (state is UsersError) {
              return Center(
                child: AppErrorWidget(
                  function: getUserInfo,
                  color: Colors.grey,
                ),
              );
            }

            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
