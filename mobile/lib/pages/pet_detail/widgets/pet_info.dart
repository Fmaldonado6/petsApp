import 'package:PetRoulette/pages/users/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/pages/pet_detail/widgets/pet_info_item.dart';
import 'package:PetRoulette/pages/pet_detail/widgets/pet_pictures.dart';
import 'package:PetRoulette/shared_widgets/rounded_image.dart';

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
        pet.profilePicture != null
            ? RoundedImage(
                imageUrl: config.baseUrl + pet.profilePicture.picture,
                width: 125,
                height: 125,
              )
            : Container(
                width: 125,
                height: 125,
                child: Icon(
                  Icons.pets,
                  size: 50,
                ),
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
                widget: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (context) => UserPage(
                          id: pet.ownerId,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    pet.owner.name,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              pet.age != null
                  ? PetInfoItem(
                      title: "Age",
                      widget: Text(
                        "${pet.age.toString()} ${pet.age > 1 && pet.age != 0 ? 'years' : 'year'}",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )
                  : Container(),
              pet.description != null
                  ? PetInfoItem(
                      title: "Description",
                      widget: Text(
                        "${pet.description}",
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
