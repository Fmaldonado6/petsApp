import 'package:flutter/material.dart';

class PetInfoItem extends StatelessWidget {
  final String title;
  final Widget widget;
  const PetInfoItem({
    Key key,
    @required this.title,
    @required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          widget,
        ],
      ),
    );
  }
}
