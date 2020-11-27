import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final Color color;
  const EmptyWidget({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.help_outline,
            size: 50,
            color: color,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No pets available",
            style: TextStyle(
              color: color,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
