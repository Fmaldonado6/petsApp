import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/cubit/auth/auth_cubit.dart';
import 'package:mobile/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/pages/auth/register/register_page.dart';

class FormData {
  String email = "";
  String password = "";
}

class LoginWidget extends StatelessWidget {
  final bool showSnackBar;
  final String message;
  final FormData form = FormData();

  LoginWidget({Key key, this.showSnackBar, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showSnackBar)
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      });

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                prefixIcon: Icon(Icons.account_circle),
                filled: true,
                labelText: "E-mail",
              ),
              onChanged: (String val) {
                form.email = val;
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              onChanged: (String val) {
                form.password = val;
              },
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                prefixIcon: Icon(Icons.vpn_key),
                labelText: "Password",
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              height: 50,
              child: RaisedButton(
                color: Colors.red,
                onPressed: () => submit(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  "Login".toUpperCase(),
                  style: TextStyle(color: Colors.white, letterSpacing: 1),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: Text(
                "Create Account",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    final user = User();

    user.email = form.email;
    user.password = form.password;
    context.read<AuthCubit>().login(user);
  }
}
