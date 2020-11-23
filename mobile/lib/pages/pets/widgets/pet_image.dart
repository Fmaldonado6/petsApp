import 'package:flutter/material.dart';

class PetImage extends StatelessWidget {
  final url;

  const PetImage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .95,
      height: size.height * .7,
      child: Image.network(url),
    );
  }
}
