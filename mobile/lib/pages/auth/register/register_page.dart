import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubit/register/register_cubit.dart';
import 'package:mobile/cubit/register/register_state.dart';
import 'package:mobile/pages/auth/register/widgets/register_form.dart';
import 'package:mobile/services/injection_container.dart';
import 'package:mobile/shared_widgets/info_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerCubit = getIt.get<RegisterCubit>();

  @override
  void initState() {
    super.initState();
    _registerCubit.initForm();
  }

  @override
  void dispose() {
    super.dispose();
    _registerCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: BlocProvider(
          create: (context) => _registerCubit,
          child: BlocBuilder<RegisterCubit, RegisterState>(
            cubit: _registerCubit,
            builder: (context, state) {
              if (state is RegisterLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (state is RegisterCompleted) {
                return Center(
                  child: InfoWidget(
                    function: () {
                      Navigator.pop(context);
                    },
                    text: "User succesfully registered!",
                  ),
                );
              }

               if (state is RegisterRepeated) {
                return Center(
                  child: InfoWidget(
                    function: () {
                      _registerCubit.initForm();
                    },
                    color: Colors.red,
                    icon: Icons.close,
                    buttontext: "RETRY",
                    text: "E-mail already registered!",
                  ),
                );
              }


              if (state is RegisterError) {
                return Center(
                  child: InfoWidget(
                    function: () {
                      _registerCubit.initForm();
                    },
                    color: Colors.red,
                    icon: Icons.close,
                    buttontext: "RETRY",
                    text: "Couldn´t register user!",
                  ),
                );
              }

              return SingleChildScrollView(
                child: RegisterForm(),
              );
            },
          ),
        ),
      ),
    );
  }
}
