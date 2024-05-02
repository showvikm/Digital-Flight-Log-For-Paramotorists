import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
// import './stats.dart';
import "package:flutter/services.dart";

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  /// text Constants
  static const title = 'Settings';
  static const pid = 'Profile Settings';
  static const eq = 'Equipment Settings';
  static const pref = 'Personal Preferences';
  static const def = 'Default';
  static const save = 'Save';

  /// Defaults times in days
  static const defaultLicense = 730; // 2 years
  static const defaultMotor = 183; // 6 months
  static const defaultWings = 61; // 2 months

  int license = defaultLicense;
  int motor = defaultMotor;
  int wings = defaultWings;

  /// Builds a setting with a text field where the user can input the value/string
  /// that they need based on the specified setting
  Widget buildSetting(String set, String part, Size sSize) {
    return Padding(
        padding: EdgeInsets.only(
            top: sSize.height * 0.01, bottom: sSize.height * 0.01),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: sSize.width / 18),
              SizedBox(
                  width: sSize.width * 5 / 18,
                  child: Text(
                    set,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: sSize.width / 18),
              SizedBox(
                  width: sSize.width * 10 / 18,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[40],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: const BorderSide(color: Colors.grey)),
                        hintText: part,
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 15)),
                  )),
              // SizedBox(
              //   width: sSize.width * 2 / 18,
              //   child: FloatingActionButton(
              //       onPressed: () => {},
              //       shape: const BeveledRectangleBorder(
              //         borderRadius: BorderRadius.zero,
              //       ),
              //       child: const Icon(Icons.format_list_bulleted_outlined,
              //           color: Colors.white, size: 25.0)),
              // ),
              SizedBox(width: sSize.width / 18),
            ]));
  }

  /// Builds a slider setting and allows the user to only be able to choose between true or false
  Widget buildSliderSetting(String set, Size sSize) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Padding(
        padding: EdgeInsets.only(
            top: sSize.height * 0.01, bottom: sSize.height * 0.01),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: sSize.width / 18),
              SizedBox(
                  width: sSize.width * 11 / 18,
                  child: Text(
                    set,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: sSize.width / 18),
              SizedBox(
                  width: sSize.width * 3 / 18,
                  child: SlidingSwitch(
                    value: false,

                    /// change base value later based on current user settings
                    width: sSize.width * 3 / 18,
                    height: sSize.height * 0.04,
                    onChanged: (bool value) {
                      print(value);

                      /// modify the effects of the settings
                    },
                    onTap: () {},
                    onDoubleTap: () {},
                    onSwipe: () {},
                    textOff: "",
                    textOn: "",
                    // iconOff: Icons.,
                    // iconOn: Icons.human-male,
                    contentSize: 17,
                    background: const Color(0xffe4e5eb),
                    buttonColor: const Color(0xfff7f5f7),
                    inactiveColor: const Color(0xff636f7b),
                  )),
              SizedBox(width: sSize.width / 18),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    /// get the size of the window
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(

        /// prevents the keyboard pop up from compressing the column
        resizeToAvoidBottomInset: false,

        /// Screen title
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            style: TextStyle(color: Colors.white),
            title,
          ),
          // backgroundColor: Colors.deepPurple,
          centerTitle: false,
        ),

        /// Body of the Settings menu
        body: Center(
            child: SingleChildScrollView(
                child: Column(
                  children: [
                      SizedBox(height: screenSize.height * 0.05),
                        Row(children: [
                          SizedBox(width: screenSize.width * 0.05),

                          /// Profile Settings
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(pid,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold)))
                        ]),

                        SizedBox(height: screenSize.height * 0.03),

                        /// Display all the profile related settings
                        buildSetting('Name', 'Brix', screenSize),

                        /// change the age to value from data base
                        buildSetting('Age', '21', screenSize),

                        /// change the age to value from data base

                        SizedBox(height: screenSize.height * 0.05),

                        /// Equipment Settings
                        Row(children: [
                          SizedBox(width: screenSize.width * 0.03),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(eq,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold)))
                        ]),

                        SizedBox(height: screenSize.height * 0.03),

                        /// Display all the equipment related settings
                        buildSetting('License', '$license', screenSize),
                        buildSetting('Wings', '$wings', screenSize),
                        buildSetting('Motor', '$motor', screenSize),

                        SizedBox(height: screenSize.height * 0.05),

                        // /// Personal Preferences settings
                        // Row(children: [
                        //   SizedBox(width: screenSize.width * 0.03),
                        //   const Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Text(pref,
                        //           style: TextStyle(
                        //               color: Colors.black,
                        //               fontSize: 25.0,
                        //               fontWeight: FontWeight.bold)))
                        // ]),

                        SizedBox(height: screenSize.height * 0.03),

                        // /// Display all the equipment related settings
                        // buildSliderSetting('Access Student Informations', screenSize),
                        // buildSliderSetting('Language Filter', screenSize),
                        // buildSliderSetting('Show Info to Friends', screenSize),

                        SizedBox(height: screenSize.height * 0.05),

                        /// Default & Save Buttons
                        Row(
                          children: [
                            SizedBox(width: screenSize.width / 18),
                            SizedBox(
                              width: screenSize.width * 8 / 18,
                              child: FloatingActionButton(
                                  onPressed: () => {},
                                  shape: const BeveledRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.undo_outlined,
                                            color: Colors.white, size: 20.0),
                                        SizedBox(width: screenSize.width * 0.01),
                                        const Text(
                                          def,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        )
                                      ])),
                            ),
                            SizedBox(
                              width: screenSize.width * 8 / 18,
                              child: FloatingActionButton(
                                  onPressed: () => {},
                                  shape: const BeveledRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.save_outlined,
                                            color: Colors.white, size: 20.0),
                                        SizedBox(width: screenSize.width * 0.01),
                                        const Text(
                                          save,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        )
                                      ])),
                            ),
                            SizedBox(width: screenSize.width / 18),
                          ],
                        ),

                        SizedBox(height: screenSize.height * 0.03),
          ],
        ))));
  }
}
