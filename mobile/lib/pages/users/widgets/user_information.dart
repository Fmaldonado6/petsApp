import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/pages/pet_add/pet_add.dart';
import 'package:mobile/pages/pet_detail/pet_detail.dart';
import 'package:mobile/pages/pets/pets_page.dart';
import 'package:mobile/services/api/users/user_service.dart';
import 'package:mobile/shared_widgets/confirm_daialog.dart';
import 'package:mobile/shared_widgets/rounded_image.dart';

class UserInformation extends StatelessWidget {
  final User user;
  final AppConfig config = AppConfig();
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Ink(
              child: InkWell(
                onTap: changeProfilePicture,
                child: user.profilePicture != null
                    ? RoundedImage(
                        imageUrl: config.baseUrl + user.profilePicture.picture,
                        width: 100,
                        height: 100,
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.perm_identity,
                          size: 50,
                        ),
                      ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 2,
                        bottom: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border:
                            Border.all(color: Colors.blue.shade300, width: 1.5),
                      ),
                      child: Text(
                        "PETS: ${user.pets.length}",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                    this.user.id == UsersService.loggedUserInfo.id
                        ? IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetAdd(
                                    getPets: getUserInfo,
                                    owner: user,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: size.width < 700 ? 2 : 5,
          crossAxisSpacing: 20,
          children: user.pets.map((pet) => getImages(pet, context)).toList(),
        ),
      ],
    );
  }

  Column getImages(Pet pet, BuildContext context) {
    pet.owner = this.user;
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
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.75),
                      blurRadius: 5.0,
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      config.baseUrl + pet.profilePicture.picture,
                    ),
                  ),
                ),
              ),
              this.user.id == UsersService.loggedUserInfo.id
                  ? Positioned(
                      top: 5,
                      right: 30,
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
