import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:PetRoulette/cubit/pets/pets_cubit.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetAddForm extends StatefulWidget {
  User owner;
  PetAddForm({Key key, this.owner}) : super(key: key);

  @override
  _PetAddFormState createState() => _PetAddFormState();
}

class _PetAddFormState extends State<PetAddForm> {
  PickedFile file;
  Pet petForm = Pet();
  bool _isDisabled = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          file == null
              ? Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.5),
                        offset: Offset(0, 2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: FlatButton(
                    onPressed: chooseFile,
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.pets,
                      size: 70,
                      color: Colors.grey.shade700,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.5),
                        offset: Offset(0, 2),
                        blurRadius: 5.0,
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(file.path),
                      ),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: chooseFile,
                    shape: CircleBorder(),
                    child: Container(),
                  ),
                ),
          Divider(),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            onChanged: (String val) {
              petForm.name = val;
              isDisabled();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              suffixIcon: Icon(Icons.pets),
              labelText: "Pet name *",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            onChanged: (String val) {
              petForm.type = val;
              isDisabled();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              suffixIcon: Icon(Icons.pets),
              labelText: "Pet species *",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            onChanged: (String val) {
              petForm.age = int.parse(val);
              isDisabled();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              suffixIcon: Icon(Icons.pets),
              labelText: "Age *",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          DropdownButtonFormField(
            onChanged: (value) {
              petForm.gender = value;
              isDisabled();
            },
            hint: Text("Gender *"),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.pets),
            ),
            items: <DropdownMenuItem>[
              DropdownMenuItem(
                child: Text("Male"),
                value: 0,
              ),
              DropdownMenuItem(
                child: Text("Female"),
                value: 1,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            onChanged: (String val) {
              petForm.breed = val;
              isDisabled();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              suffixIcon: Icon(Icons.pets),
              labelText: "Pet breed",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            onChanged: (String val) {
              petForm.description = val;
              isDisabled();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description",
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 40,
            width: double.infinity,
            child: RaisedButton(
              onPressed: _isDisabled ? null : submit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              color: Colors.red,
              child: Text(
                "NEXT",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void submit() async {
    petForm.ownerId = widget.owner.id;
    context.read<PetsCubit>().addPet(file, petForm);
  }

  void isDisabled() {
    setState(() {
      _isDisabled = petForm.name == null ||
          petForm.type == null ||
          petForm.age == null ||
          petForm.gender == null ||
          file == null;
    });
  }

  void chooseFile() async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
    isDisabled();
  }
}
