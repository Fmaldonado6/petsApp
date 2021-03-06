import 'package:PetRoulette/pages/image_detail/image_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/cubit/pictures/pictures_cubit.dart';
import 'package:PetRoulette/cubit/pictures/pictures_state.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:PetRoulette/services/injection_container.dart';
import 'package:PetRoulette/shared_widgets/confirm_daialog.dart';
import 'package:PetRoulette/shared_widgets/error_widget.dart';
import 'package:PetRoulette/cubit/pictures/pictures_cubit.dart';

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

        widget.pet.pictures = (state as PicturesList).pictures;

        return Container(
          height: 175,
          child: Stack(
            children: [
              ListView(
                scrollDirection: Axis.horizontal,
                children: widget.pet.pictures
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
            pictures: widget.pet.pictures,
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
  final List<Picture> pictures;

  PetPicture({Key key, @required this.picture, @required this.pictures})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (_) => ImageDetailPage(
                pictures: pictures,
                initial: this.pictures.indexOf(picture),
              ),
            ),
          );
        },
        child: Container(
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
        ),
      ),
    );
  }
}
