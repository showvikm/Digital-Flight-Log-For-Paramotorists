// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constants {
  //colors
  static const kPrimaryColor = Color(0xFFFFFFFF);
  static const kGreyColor = Color(0xFFEEEEEE);
  static const kBlackColor = Color(0xFF000000);
  static const kDarkGreyColor = Color(0xFF9E9E9E);
  static const kDarkBlueColor = Color(0xFF6057FF);
  static const kBorderColor = Color(0xFFEFEFEF);

  //text
  static const title = "Google Sign In";
  static const textIntro = "Ready to \n begin ";
  static const textIntroDesc1 = "flying? \n ";
  static const textIntroDesc2 = "We will guide you!";
  static const textSmallSignUp = "Sign up takes just a minute!";
  static const textSignIn = "Sign In";
  static const textSignUpBtn = "Create An Account";
  static const textStart = "Log In";
  static const textSignInTitle = "Welcome back!";
  static const textRegister = "Register below!";
  static const textSmallSignIn = "We missed you!";
  static const textSignInGoogle = "Sign in with Google";
  static const textAcc = "Don't have an account? ";
  static const textSignUp = "Sign up here";
  static const textHome = "Home";
  static const textNoData = "No data available.";
  static const textFixIssues = "Please fill in the data correctly!";

  //navigate
  static const signInNavigate = '/sign-in';
  static const homeNavigate = '/home';

  static const statusBarColor = SystemUiOverlayStyle(
      statusBarColor: Constants.kPrimaryColor,
      statusBarIconBrightness: Brightness.dark);
}
