import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String text;
  final String buttontext;
  final IconData icon;
  final Color color;
  final Function function;
  const InfoWidget(
      {Key key,
      this.text = "Success",
      this.buttontext = "Accept",
      this.icon = Icons.check,
      this.color = Colors.green,
      @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 4)),
          child: Icon(
            icon,
            size: 40,
            color: color,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          onPressed: function,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            buttontext.toUpperCase(),
            style:
                TextStyle(fontSize: 15, color: Colors.white, letterSpacing: 2),
          ),
          color: color,
        ),
      ],
    );
  }
}
