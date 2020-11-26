import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String text;
  final Function function;
  final Color color;

  const AppErrorWidget(
      {Key key,
      this.text = "RETRY",
      @required this.function,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 60,
          color: color,
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          onPressed: function,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(text.toUpperCase()),
        )
      ],
    );
  }
}
