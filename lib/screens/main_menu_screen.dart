import "package:flutter/material.dart";
import 'package:paramotor/screens/database_demo.dart';
import 'package:paramotor/screens/welcome_view.dart';
import "./preflight.dart";
import "./settings.dart";
import "./info_menu.dart";
import 'package:paramotor/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  void moveToPreFlight(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const PreFlightMenu();
        },
      ),
    );
  }

  void moveToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SettingsMenu();
        },
      ),
    );
  }

  void moveToInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const InfoMenu();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // App starts here
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeView()),
              (Route<dynamic> route) => false);
        }
      },
      buildWhen: (previous, current) {
        if (current is AuthenticationFailure) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: const Text(
                style: TextStyle(color: Colors.white),
                "Main Menu",
              ),
              // backgroundColor: Colors.deepPurple,
              centerTitle: false),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/main.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.green,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome ${(state as AuthenticationSuccess).displayName!}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ready to fly?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Once you are ready to begin flying hit the start button on the bottom left!',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                          width: size.width * 0.7,
                          child: FloatingActionButton.extended(
                            onPressed: () => moveToInfo(context),
                            backgroundColor: Colors.yellow,
                            label: const Text(
                              "More Information",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        onPressed: () => moveToPreFlight(context),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.timer, color: Colors.white, size: 25.0),
                            Text(
                              'Start',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const HomeView()),
                            ),
                          ),
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.account_circle,
                                color: Colors.white, size: 25.0),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => moveToSettings(context),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.settings,
                                color: Colors.white, size: 25.0),
                            Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ], // Here, <Widget> is optional because of type inferrence
            ),
          ),
        );
      },
    );
  }
}
