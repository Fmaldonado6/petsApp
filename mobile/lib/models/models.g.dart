// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..profilePictureId = json['profilePictureId'] as String
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..age = json['age'] as int
    ..gender = json['gender'] as int
    ..profilePicture = json['profilePicture'] == null
        ? null
        : Picture.fromJson(json['profilePicture'] as Map<String, dynamic>)
    ..pets = (json['pets'] as List)
        ?.map((e) => e == null ? null : Pet.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'profilePictureId': instance.profilePictureId,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'age': instance.age,
      'gender': instance.gender,
      'profilePicture': instance.profilePicture?.toJson(),
      'pets': instance.pets?.map((e) => e?.toJson())?.toList(),
    };

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report()
    ..id = json['id'] as String
    ..petId = json['petId'] as String
    ..username = json['username'] as String
    ..petname = json['petname'] as String
    ..pictureId = json['pictureId'] as String
    ..picture = json['picture'] as String;
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'username': instance.username,
      'petname': instance.petname,
      'pictureId': instance.pictureId,
      'picture': instance.picture,
    };

Picture _$PictureFromJson(Map<String, dynamic> json) {
  return Picture()
    ..id = json['id'] as String
    ..ownerId = json['ownerId'] as String
    ..petId = json['petId'] as String
    ..picture = json['picture'] as String
    ..owner = json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'petId': instance.petId,
      'picture': instance.picture,
      'owner': instance.owner?.toJson(),
    };

Pet _$PetFromJson(Map<String, dynamic> json) {
  return Pet()
    ..id = json['id'] as String
    ..ownerId = json['ownerId'] as String
    ..name = json['name'] as String
    ..profilePictureId = json['profilePictureId'] as String
    ..breed = json['breed'] as String
    ..description = json['description'] as String
    ..type = json['type'] as String
    ..age = json['age'] as int
    ..likes = json['likes'] as int
    ..dislikes = json['dislikes'] as int
    ..gender = json['gender'] as int
    ..pictures = (json['pictures'] as List)
        ?.map((e) =>
            e == null ? null : Picture.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..profilePicture = json['profilePicture'] == null
        ? null
        : Picture.fromJson(json['profilePicture'] as Map<String, dynamic>)
    ..owner = json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'profilePictureId': instance.profilePictureId,
      'breed': instance.breed,
      'description': instance.description,
      'type': instance.type,
      'age': instance.age,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'gender': instance.gender,
      'pictures': instance.pictures?.map((e) => e?.toJson())?.toList(),
      'profilePicture': instance.profilePicture?.toJson(),
      'owner': instance.owner?.toJson(),
    };
