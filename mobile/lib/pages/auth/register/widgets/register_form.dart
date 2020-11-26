import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/cubit/register/register_cubit.dart';
import 'package:mobile/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final User user = User();

  bool _isDisabled = true;
  bool _passwordMatches = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            "Create user",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (String val) {
              user.name = val;
              isDisabled();
            },
            decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: Icon(Icons.account_circle),
              labelText: "Username *",
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            onChanged: (String val) {
              user.email = val;
              isDisabled();
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: Icon(Icons.email),
              labelText: "E-mail *",
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            onChanged: (String val) {
              user.age = int.parse(val);
              isDisabled();
            },
            decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              labelText: "Age *",
            ),
          ),
          SizedBox(height: 30),
          DropdownButtonFormField(
            onChanged: (value) {
              user.gender = value;
              isDisabled();
            },
            hint: Text("Gender *"),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 17, bottom: 17),
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: Icon(Icons.face),
            ),
            items: <DropdownMenuItem>[
              DropdownMenuItem(
                child: Text("Male"),
                value: 0,
              ),
              DropdownMenuItem(
                child: Text("Female"),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("Other"),
                value: 2,
              ),
            ],
          ),
          SizedBox(height: 30),
          TextFormField(
            onChanged: (String val) {
              user.password = val;
              isDisabled();
            },
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: Icon(Icons.vpn_key),
              labelText: "Password *",
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            onChanged: (String val) {
              if (val == user.password)
                this._passwordMatches = true;
              else
                this._passwordMatches = false;

              isDisabled();
            },
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: Icon(Icons.vpn_key),
              labelText: "Confirm Password",
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 40,
            width: double.infinity,
            child: RaisedButton(
              onPressed: _isDisabled ? null : submit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              color: Colors.red,
              child: Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void isDisabled() {
    print(user.name.isNotEmpty);
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(user.email);
    if (user.name != null &&
        user.name.isNotEmpty &&
        emailValid &&
        user.age != null &&
        user.gender != null &&
        user.password != null &&
        user.password.isNotEmpty &&
        _passwordMatches)
      setState(() => this._isDisabled = false);
    else
      setState(() => this._isDisabled = true);
  }

  void submit() {
    context.read<RegisterCubit>().register(user);
  }
}
