import 'package:flutter/cupertino.dart';
import 'package:mobile/models/models.dart';

@immutable
abstract class PicturesState {
  const PicturesState();
}

class PicturesLoading extends PicturesState {
  const PicturesLoading();
}

class PicturesList extends PicturesState {
  final List<Picture> pictures;
  const PicturesList(this.pictures);
}

class PicturesError extends PicturesState {
  final String error;

  const PicturesError(this.error);
}

class PicturesEmpty extends PicturesState {
  const PicturesEmpty();
}
