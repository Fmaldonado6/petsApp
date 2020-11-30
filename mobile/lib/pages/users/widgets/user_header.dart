import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/pages/pet_add/pet_add.dart';
import 'package:PetRoulette/services/api/users/user_service.dart';
import 'package:PetRoulette/shared_widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final User user;
  final config = AppConfig();
  final Function getUserInfo;
  final Function changeProfilePicture;

  UserHeader(
      {Key key,
      @required this.user,
      @required this.getUserInfo,
      @required this.changeProfilePicture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    border: Border.all(color: Colors.blue.shade300, width: 1.5),
                  ),
                  child: Text(
                    "PETS: ${user.pets.length}",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                user.id == UsersService.loggedUserInfo.id
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
    );
  }
}
