import 'package:paramotor/screens/sign_in_view.dart';
import 'package:paramotor/screens/sign_up_view.dart';
import 'package:paramotor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Constants.kPrimaryColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Constants.statusBarColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/welcome.jpg"),
                SizedBox(height: size.height * 0.06),
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: Constants.textIntro,
                          style: TextStyle(
                            color: Constants.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                      TextSpan(
                          text: Constants.textIntroDesc1,
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0)),
                      TextSpan(
                          text: Constants.textIntroDesc2,
                          style: TextStyle(
                              color: Constants.kBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0)),
                    ])),
                SizedBox(height: size.height * 0.01),
                const Text(
                  Constants.textSmallSignUp,
                  style: TextStyle(color: Constants.kDarkGreyColor),
                ),
                SizedBox(height: size.height * 0.07),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInView()),
                      );
                    },
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.kBlackColor),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none)),
                    child: const Text(Constants.textStart),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.kGreyColor),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none)),
                    child: const Text(
                      Constants.textSignUpBtn,
                      style: TextStyle(color: Constants.kBlackColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
