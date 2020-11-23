import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/cubit/pets/pets_cubit.dart';
import 'package:mobile/cubit/pets/pets_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/pages/pets/widgets/pets_loaded.dart';
import 'package:mobile/services/injection_container.dart';
import 'package:mobile/widgets/shared/empty_widget.dart';

class PetsPage extends StatefulWidget {
  final User userInfo;

  PetsPage({Key key, this.userInfo}) : super(key: key);

  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  final AppConfig config = AppConfig();

  final _petsCubit = getIt.get<PetsCubit>();

  @override
  void initState() {
    super.initState();
    _petsCubit.getPets();
  }

  @override
  void dispose() {
    super.dispose();
    _petsCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade400,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pets App"),
        actions: [
          MaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                config.baseUrl + widget.userInfo.profilePicture.picture,
              ),
            ),
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
              print(state.error);
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
