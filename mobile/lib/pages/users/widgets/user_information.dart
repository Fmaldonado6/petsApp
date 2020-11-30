import 'package:PetRoulette/pages/users/widgets/pet_preview.dart';
import 'package:PetRoulette/pages/users/widgets/user_header.dart';
import 'package:PetRoulette/shared_widgets/ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';

import 'package:PetRoulette/shared_widgets/empty_widget.dart';

class UserInformation extends StatefulWidget {
  final User user;
  final Function getUserInfo;
  final Function deletePet;
  final Function changeProfilePicture;
  UserInformation(
      {Key key,
      @required this.user,
      @required this.getUserInfo,
      @required this.changeProfilePicture,
      @required this.deletePet})
      : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  final AppConfig config = AppConfig();
  final NativeAdmobController controller = NativeAdmobController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        UserHeader(
          user: widget.user,
          getUserInfo: widget.getUserInfo,
          changeProfilePicture: widget.changeProfilePicture,
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        widget.user.pets.length != 0
            ? GridView.count(
                shrinkWrap: true,
                crossAxisCount: size.width < 700 ? 2 : 5,
                crossAxisSpacing: 20,
                children: widget.user.pets
                    .map((pet) => getImages(pet, context))
                    .toList(),
              )
            : EmptyWidget(
                color: Colors.grey,
              ),
        AdWidget(
          controller: controller,
          adHeight: 150,
          adWidth: double.infinity,
          loadingSize: 20,
        ),
      ],
    );
  }

  PetPreview getImages(Pet pet, BuildContext context) {
    pet.owner = this.widget.user;
    return PetPreview(
      pet: pet,
      userId: widget.user.id,
      deletePet: widget.deletePet,
    );
  }
}
