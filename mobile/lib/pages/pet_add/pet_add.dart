import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubit/pets/pets_cubit.dart';
import 'package:mobile/cubit/pets/pets_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/pages/pet_add/widgets/pet_add_form.dart';
import 'package:mobile/services/injection_container.dart';
import 'package:mobile/shared_widgets/info_widget.dart';

class PetAdd extends StatefulWidget {
  final User owner;
  final Function getPets;
  PetAdd({Key key, @required this.owner, @required this.getPets})
      : super(key: key);

  @override
  _PetAddState createState() => _PetAddState();
}

class _PetAddState extends State<PetAdd> {
  final _petsCubit = getIt.get<PetsCubit>();

  @override
  void initState() {
    super.initState();
    _petsCubit.initForm();
  }

  @override
  void dispose() {
    super.dispose();
    _petsCubit.close();
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
        child: BlocProvider(
          create: (context) => _petsCubit,
          child: BlocBuilder<PetsCubit, PetsState>(
            cubit: _petsCubit,
            builder: (context, state) {
              if (state is PetsLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (state is PetsCompleted) {
                return Center(
                  child: InfoWidget(
                    function: () {
                      Navigator.pop(context);
                      widget.getPets();
                    },
                    text: "Pet succesfully added!",
                  ),
                );
              }

              if (state is PetsError) {
                return Center(
                  child: InfoWidget(
                    function: () {
                      _petsCubit.initForm();
                    },
                    color: Colors.red,
                    icon: Icons.close,
                    buttontext: "RETRY",
                    text: "Couldn´t add pet!",
                  ),
                );
              }

              return SingleChildScrollView(
                child: PetAddForm(
                  owner: widget.owner,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
