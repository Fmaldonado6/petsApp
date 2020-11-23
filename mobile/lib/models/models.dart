import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class User {
  String id;
  String profilePictureId;
  String name;
  String email;
  String password;
  int age;
  int gender;
  Picture profilePicture;
  List<Pet> pets;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Picture {
  String id;
  String ownerId;
  String petId;
  String picture;
  User owner;

  Picture();

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}

@JsonSerializable()
class Pet {
  String id;
  String ownerId;
  String name;
  String profilePictureId;
  String breed;
  String description;
  int age;
  int likes;
  int dislikes;
  int gender;
  List<Picture> pictures;
  Picture profilePicture;
  User owner;

  Pet();

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);
}
