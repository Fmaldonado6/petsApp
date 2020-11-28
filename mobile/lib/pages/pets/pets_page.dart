import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/cubit/auth/auth_cubit.dart';
import 'package:mobile/cubit/pets/pets_cubit.dart';
import 'package:mobile/cubit/pets/pets_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/pages/pets/widgets/pets_loaded.dart';
import 'package:mobile/pages/users/user_page.dart';
import 'package:mobile/services/injection_container.dart';
import 'package:mobile/shared_widgets/empty_widget.dart';
import 'package:mobile/shared_widgets/error_widget.dart';

class PetsPage extends StatefulWidget {
  final User userInfo;

  PetsPage({Key key, this.userInfo}) : super(key: key);

  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  final AppConfig config = AppConfig();

  final _petsCubit = getIt.get<PetsCubit>();
  final _authCubit = getIt.get<AuthCubit>();

  @override
  void initState() {
    super.initState();
    _petsCubit.getPets();
  }

  @override
  void dispose() {
    super.dispose();
    _petsCubit.close();
    _authCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("PetRoulette"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {},
            child: widget.userInfo.profilePicture != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      config.baseUrl + widget.userInfo.profilePicture.picture,
                    ),
                  )
                : Icon(Icons.perm_identity),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPage(
                          id: widget.userInfo.id,
                        ),
                      ),
                    );
                  },
                  leading: Icon(Icons.person_outline),
                  title: Text("Profile"),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: ListTile(
                  onTap: () {
                    context.read<AuthCubit>().signOut();
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.power_settings_new),
                  title: Text("Sign out"),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _petsCubit,
        child: BlocBuilder<PetsCubit, PetsState>(
          cubit: _petsCubit,
          builder: (context, state) {
            print(state);
            if (state is PetsLoading)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );

            if (state is PetsError) {
              return Center(
                child: AppErrorWidget(
                  function: _petsCubit.getPets,
                  color: Colors.grey,
                ),
              );
            }

            if (state is PetsList)
              return PetsLoaded(
                pets: state.pets,
              );

            return Center(
              child: EmptyWidget(),
            );
          },
        ),
      ),
    );
  }
}
