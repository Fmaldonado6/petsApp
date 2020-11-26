import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/pages/pet_detail/pet_detail.dart';
import 'package:mobile/pages/users/user_page.dart';

class PetName extends StatelessWidget {
  final Pet pet;

  const PetName({Key key, this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      height: size.height * .15,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return PetDetails(
                  pet: pet,
                );
              },
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.pets,
              size: 35,
              color: Colors.grey.shade800,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 270),
                  child: Text(
                    pet.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(
                    width: 10,
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
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
