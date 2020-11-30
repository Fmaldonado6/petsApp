import 'package:PetRoulette/app_config.dart';
import 'package:PetRoulette/models/models.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetailPage extends StatelessWidget {
  PageController controller;
  final List<Picture> pictures;
  final int initial;
  final config = AppConfig();
  ImageDetailPage({Key key, this.pictures, this.initial}) : super(key: key) {
    this.controller = PageController(initialPage: initial);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: controller,
        children: pictures.map(buildPictures).toList(),
      ),
    );
  }

  Widget buildPictures(Picture picture) {
    return Container(
      width: double.infinity,
      child: PhotoView(
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained,
        imageProvider: NetworkImage(
          config.baseUrl + picture.picture,
        ),
      ),
    );
  }
}
