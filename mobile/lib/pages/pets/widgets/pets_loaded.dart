import 'package:flutter/material.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/models.dart';

import 'pet_image.dart';

class PetsLoaded extends StatefulWidget {
  final List<Pet> pets;

  PetsLoaded({Key key, this.pets}) : super(key: key);

  @override
  _PetsLoadedState createState() => _PetsLoadedState();
}

class _PetsLoadedState extends State<PetsLoaded> {
  final AppConfig config = AppConfig();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Draggable(
                onDragCompleted: () {},
                child: PetImage(
                  url: config.baseUrl + widget.pets[0].profilePicture.picture,
                ),
                feedback: PetImage(
                  url: config.baseUrl + widget.pets[0].profilePicture.picture,
                ),
                childWhenDragging: Container(),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
