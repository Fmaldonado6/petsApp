import 'package:flutter/material.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/cubit/pets/pets_cubit.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/pages/pets/widgets/pet_name.dart';
import 'package:PetRoulette/provider/feedback_position_provider.dart';
import 'package:PetRoulette/shared_widgets/empty_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'pet_image.dart';

class PetsLoaded extends StatefulWidget {
  final List<Pet> pets;
  final bool showToast;
  PetsLoaded({Key key, this.pets, this.showToast = false}) : super(key: key);

  @override
  _PetsLoadedState createState() => _PetsLoadedState();
}

class _PetsLoadedState extends State<PetsLoaded> {
  final AppConfig config = AppConfig();
  var lastPetIndex;
  var inFocus;

  @override
  void initState() {
    super.initState();
    lastPetIndex = widget.pets.length - 1;
    inFocus = lastPetIndex == widget.pets.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showToast)
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Swipe right to like, left to dislike"),
          ),
        );
      });
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.pets.length != 0
              ? Padding(
                  padding: EdgeInsets.all(8),
                  child: Stack(
                    children: widget.pets.map(buildPetCards).toList(),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
          widget.pets.length != 0
              ? PetName(
                  pet: widget.pets.last,
                )
              : Container()
        ],
      ),
    );
  }

  Widget buildPetCards(Pet pet) {
    final size = MediaQuery.of(context).size;

    return Listener(
        onPointerMove: (pointerEvent) {
          final provider =
              Provider.of<FeedbackPositionProvider>(context, listen: false);
          provider.updatePosition(pointerEvent.localDelta.dx);
        },
        onPointerCancel: (_) {
          final provider =
              Provider.of<FeedbackPositionProvider>(context, listen: false);
          provider.resetPosition();
        },
        onPointerUp: (_) {
          final provider =
              Provider.of<FeedbackPositionProvider>(context, listen: false);
          provider.resetPosition();
        },
        child: PetImageDraggable(
          url: pet.profilePicture != null
              ? config.baseUrl + pet.profilePicture.picture
              : null,
          focus: pet == widget.pets.last,
          onDragEnd: (details) => onDragEnd(details, pet),
        ));
  }

  void onDragEnd(DraggableDetails details, Pet pet) async {
    final minimumDrag = 200;

    if (details.offset.distance > minimumDrag) {
      if (details.offset.dx > 0)
        pet.likes++;
      else
        pet.dislikes++;
      setState(() => widget.pets.remove(pet));
      await this.context.read<PetsCubit>().updatePet(pet);
    }
    if (this.widget.pets.length == 0) this.context.read<PetsCubit>().getPets();
  }
}
