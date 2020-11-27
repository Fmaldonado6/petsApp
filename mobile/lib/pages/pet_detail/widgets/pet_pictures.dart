import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/cubit/pictures/pictures_cubit.dart';
import 'package:mobile/cubit/pictures/pictures_state.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/services/injection_container.dart';
import 'package:mobile/shared_widgets/confirm_daialog.dart';
import 'package:mobile/shared_widgets/error_widget.dart';

class PetPictures extends StatefulWidget {
  final Pet pet;
  final bool isOwner;
  PetPictures({Key key, @required this.pet, this.isOwner}) : super(key: key);

  @override
  _PetPicturesState createState() => _PetPicturesState();
}

class _PetPicturesState extends State<PetPictures> {
  final _picturesCubit = getIt.get<PicturesCubit>();

  @override
  void initState() {
    super.initState();
    this._picturesCubit.getPetPictures(widget.pet.id);
  }

  @override
  void dispose() {
    super.dispose();
    this._picturesCubit.close();
  }

  void uploadPicture() async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: ImageSource.gallery);

    if (file == null) return;

    Picture picture = Picture();
    picture.petId = widget.pet.id;
    await this._picturesCubit.addPicture(picture, file);

    this._picturesCubit.getPetPictures(widget.pet.id);
  }

  void deletePicture(Picture picture) async {
    await this._picturesCubit.deletePicture(picture);

    this._picturesCubit.getPetPictures(widget.pet.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicturesCubit, PicturesState>(
      cubit: _picturesCubit,
      builder: (context, state) {
        if (state is PicturesLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is PicturesError) {
          return Center(
            child: AppErrorWidget(
              function: () {
                this._picturesCubit.getPetPictures(widget.pet.id);
              },
              color: Colors.grey,
            ),
          );
        }
        return Container(
          height: 175,
          child: Stack(
            children: [
              ListView(
                scrollDirection: Axis.horizontal,
                children: (state as PicturesList)
                    .pictures
                    .map((e) => e.picture != null ? getPicture(e) : Container())
                    .toList(),
              ),
              widget.isOwner
                  ? Positioned(
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(.5)),
                        child: IconButton(
                          iconSize: 20,
                          color: Colors.white,
                          onPressed: uploadPicture,
                          icon: Icon(Icons.add),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Container getPicture(Picture picture) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          PetPicture(
            picture: picture,
          ),
          widget.isOwner && widget.pet.profilePictureId != picture.id
              ? Positioned(
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(.5)),
                    child: IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () => ConfirmDialog().show(
                        context: context,
                        title: "Delete picture",
                        text: "Are you sure you want to delete this picture?",
                        confirm: "Delete",
                        callback: () {
                          Navigator.pop(context);
                          deletePicture(picture);
                        },
                      ),
                      icon: Icon(Icons.close),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class PetPicture extends StatelessWidget {
  final AppConfig config = AppConfig();
  final Picture picture;
  PetPicture({Key key, @required this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(config.baseUrl + picture.picture),
        ),
      ),
    );
  }
}
