import 'package:flutter/material.dart';
import 'package:PetRoulette/cubit/pets/pets_cubit.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/pages/pet_detail/pet_detail.dart';
import 'package:PetRoulette/pages/users/user_page.dart';
import 'package:PetRoulette/shared_widgets/confirm_daialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetName extends StatelessWidget {
  final Pet pet;

  const PetName({Key key, this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void addReport() async {
      Navigator.of(context).pop();

      Report report = new Report();
      report.petId = pet.id;
      report.petname = pet.name;
      report.username = pet.owner.name;
      report.picture = pet.profilePicture.picture;
      report.pictureId = pet.profilePictureId;
      final response = await context.read<PetsCubit>().addReport(report);
      if (!response)
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Couldn´t add report!"),
          ),
        );

      context.read<PetsCubit>().getPets();
    }

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
                  IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      ConfirmDialog().show(
                        title: "Report pet",
                        text: "Would you like to report this pet?",
                        confirm: "Report",
                        context: context,
                        callback: addReport,
                      );
                    },
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
