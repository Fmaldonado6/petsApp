import 'package:flutter/material.dart';
import 'package:PetRoulette/cubit/pets/pets_cubit.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/pages/pet_detail/widgets/pet_info.dart';
import 'package:PetRoulette/services/injection_container.dart';

class PetDetails extends StatefulWidget {
  final Pet pet;

  PetDetails({Key key, @required this.pet}) : super(key: key);

  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  bool isOwner = false;
  final _petsCubit = getIt.get<PetsCubit>();
  @override
  void initState() {
    super.initState();
    isOwner = _petsCubit.isOwner(widget.pet);
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
        child: PetInfo(
          isOwner: isOwner,
          pet: widget.pet,
        ),
      ),
    );
  }
}
