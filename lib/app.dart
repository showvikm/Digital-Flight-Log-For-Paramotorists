import 'package:paramotor/features/authentication/bloc/authentication_bloc.dart';
// import 'package:paramotor/screens/database_demo.dart';
import 'package:paramotor/screens/main_menu_screen.dart';
import 'package:paramotor/screens/welcome_view.dart';
import 'package:paramotor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParamotorApp extends StatelessWidget {
  const ParamotorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const BlocNavigate(),
        title: Constants.title,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ));
  }
}

/// BlocNavigate Class:
/// Uses BlocBuilder which takes AuthenticationBloc and it's state.
/// The BlocBuilder will check if you declared the AuthenticationBloc before
/// using it, that's why it was declared in the MultiBlocProvider in main.
class BlocNavigate extends StatelessWidget {
  const BlocNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        /// If the current state is AuthenticationSuccess. User is authenticated.
        /// Go immediately to HomeView().
        /// If not: then the user has to sign up or login so go to WelcomeView.
        if (state is AuthenticationSuccess) {
          return const MainMenuScreen();
        } else {
          return const WelcomeView();
        }
      },
    );
  }
}
