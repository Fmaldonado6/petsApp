import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/pages/pet_detail/pet_detail.dart';
import 'package:PetRoulette/services/api/users/user_service.dart';
import 'package:PetRoulette/shared_widgets/confirm_daialog.dart';
import 'package:flutter/material.dart';

class PetPreview extends StatelessWidget {
  final Pet pet;
  final String userId;
  final config = AppConfig();
  final Function deletePet;
  PetPreview(
      {Key key,
      @required this.pet,
      @required this.userId,
      @required this.deletePet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PetDetails(
                  pet: pet,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.75),
                      blurRadius: 5.0,
                    ),
                  ],
                  color: Colors.white,
                  image: pet.profilePicture != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            config.baseUrl + pet.profilePicture.picture,
                          ),
                        )
                      : null,
                ),
                child: pet.profilePicture == null
                    ? Icon(
                        Icons.pets,
                        size: 50,
                      )
                    : null,
              ),
              userId == UsersService.loggedUserInfo.id
                  ? Positioned(
                      top: 5,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(.5),
                        ),
                        child: IconButton(
                          onPressed: () => ConfirmDialog().show(
                            context: context,
                            title: "Delete pet",
                            text: "Are you sure you want to delete this pet?",
                            confirm: "Delete",
                            callback: () {
                              Navigator.pop(context);
                              deletePet(pet);
                            },
                          ),
                          iconSize: 20,
                          color: Colors.white,
                          icon: Icon(Icons.close),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Text(
          pet.name,
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }
}
