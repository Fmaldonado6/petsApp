import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/pages/pet_detail/widgets/pet_info_item.dart';
import 'package:mobile/pages/pet_detail/widgets/pet_pictures.dart';
import 'package:mobile/shared_widgets/rounded_image.dart';

class PetInfo extends StatelessWidget {
  final Pet pet;
  final AppConfig config = AppConfig();
  final bool isOwner;
  PetInfo({
    Key key,
    @required this.pet,
    @required this.isOwner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedImage(
          imageUrl: config.baseUrl + pet.profilePicture.picture,
          width: 125,
          height: 125,
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              pet.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                ),
                Text(pet.likes.toString()),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.thumb_down,
                  color: Colors.red,
                ),
                Text(pet.dislikes.toString()),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              PetInfoItem(
                title: "Species",
                widget: Text(
                  pet.type,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              pet.breed != null && pet.breed.isNotEmpty
                  ? PetInfoItem(
                      title: "Breed",
                      widget: Text(
                        pet.breed,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )
                  : Container(),
              PetInfoItem(
                title: "Owner",
                widget: Text(
                  pet.owner.name,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              pet.age != null
                  ? PetInfoItem(
                      title: "Age",
                      widget: Text(
                        "${pet.age.toString()} year",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )
                  : Container(),
              PetInfoItem(
                title: "Pictures",
                widget: PetPictures(pet: pet, isOwner: isOwner),
              )
            ],
          ),
        )
      ],
    );
  }
}
