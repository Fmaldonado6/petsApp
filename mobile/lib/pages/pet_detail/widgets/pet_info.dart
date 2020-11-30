import 'package:PetRoulette/pages/users/user_page.dart';
import 'package:PetRoulette/shared_widgets/ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/pages/pet_detail/widgets/pet_info_item.dart';
import 'package:PetRoulette/pages/pet_detail/widgets/pet_pictures.dart';
import 'package:PetRoulette/shared_widgets/rounded_image.dart';

class PetInfo extends StatefulWidget {
  final Pet pet;
  final bool isOwner;
  final NativeAdmobController controller = NativeAdmobController();
  PetInfo({
    Key key,
    @required this.pet,
    @required this.isOwner,
  }) : super(key: key);

  @override
  _PetInfoState createState() => _PetInfoState();
}

class _PetInfoState extends State<PetInfo> {
  final AppConfig config = AppConfig();



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.pet.profilePicture != null
            ? RoundedImage(
                imageUrl: config.baseUrl + widget.pet.profilePicture.picture,
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
              widget.pet.name,
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
                Text(widget.pet.likes.toString()),
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
                Text(widget.pet.dislikes.toString()),
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
                  widget.pet.type,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              widget.pet.breed != null && widget.pet.breed.isNotEmpty
                  ? PetInfoItem(
                      title: "Breed",
                      widget: Text(
                        widget.pet.breed,
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
                          id: widget.pet.ownerId,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    widget.pet.owner.name,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              widget.pet.age != null
                  ? PetInfoItem(
                      title: "Age",
                      widget: Text(
                        "${widget.pet.age.toString()} ${widget.pet.age > 1 && widget.pet.age != 0 ? 'years' : 'year'}",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )
                  : Container(),
              AdWidget(
                  controller: widget.controller,
                  adHeight: 150,
                  adWidth: double.infinity,
                  loadingSize: 20),
              widget.pet.description != null
                  ? PetInfoItem(
                      title: "Description",
                      widget: Text(
                        "${widget.pet.description}",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )
                  : Container(),
              PetInfoItem(
                title: "Pictures",
                widget: PetPictures(pet: widget.pet, isOwner: widget.isOwner),
              )
            ],
          ),
        )
      ],
    );
  }
}
