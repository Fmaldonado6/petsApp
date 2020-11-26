import 'package:flutter/material.dart';
import 'package:mobile/pages/auth/widgets/login_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade400,
      body: Center(
        child: LoginWidget(),
      ),
    );
  }
}
