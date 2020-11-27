import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubit/auth/auth_cubit.dart';
import 'package:mobile/cubit/auth/auth_state.dart';
import 'package:mobile/pages/auth/auth_page.dart';
import 'package:mobile/pages/pets/pets_page.dart';
import 'package:mobile/services/exceptions/exceptions.dart';
import 'package:mobile/services/injection_container.dart';
import 'package:mobile/shared_widgets/error_widget.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _authCubit = getIt.get<AuthCubit>();

  @override
  void initState() {
    super.initState();
    _authCubit.init();
  }

  @override
  void dispose() {
    super.dispose();
    _authCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authCubit,
      child: BlocBuilder<AuthCubit, AuthState>(
        cubit: _authCubit,
        builder: (context, state) {
          if (state is AuthLoading)
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );

          if (state is AuthCompleted) {
            return PetsPage(userInfo: state.user);
          }

          if (state is AuthInitialError) {
            return AuthPage(
              showSnackBar: true,
              message: state.message,
            );
          }

          if (state is AuthError)
            return Scaffold(
              body: Center(
                child: AppErrorWidget(
                  function: () {
                    _authCubit.init();
                  },
                ),
              ),
            );

          return AuthPage();
        },
      ),
    );
  }
}
