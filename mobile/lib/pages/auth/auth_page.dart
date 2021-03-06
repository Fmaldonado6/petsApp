import 'package:flutter/material.dart';
import 'package:PetRoulette/pages/auth/widgets/login_widget.dart';

class AuthPage extends StatelessWidget {
  final bool showSnackBar;
  final String message;
  const AuthPage({Key key, this.showSnackBar = false, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade400,
      body: Center(
        child: LoginWidget(
          showSnackBar: showSnackBar,
          message: message,
        ),
      ),
    );
  }
}
