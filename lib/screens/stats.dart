import "package:flutter/material.dart";
import 'package:paramotor/screens/info_stats.dart';
import './main_menu_screen.dart';
// import "./settings.dart";
import "package:flutter/services.dart";
// import 'flight.dart';

class StatsScreen extends StatefulWidget {
  final int timeOut;
  final double motors, license, wings;

  const StatsScreen({Key? key, required this.timeOut,
    required this.motors,
    required this.wings,
    required this.license,
  }) : super(key: key);
  @override
  StatsMenu createState() => StatsMenu();
}

class StatsMenu extends State<StatsScreen> {
  /// text Constants
  static const timeEl = 'Time Elapsed: ';
  static const alertsPend = 'Alerts Pending';

  /// Convert time
  String convertT(int s) {
    int sec = s % 60;
    int min = (s / 60).floor().remainder(60);
    int h = (s / 3600).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    String hour = h.toString().length <= 1 ? "0$h" : "$h";
    return '$hour:$minute:$second';
  }

  Widget buildSymbol(String ar) {
    /// NAR determines whether the input is a notification, alert, or reminder
    if (ar == 'r') {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue,
          ),
          child:
              const Icon(Icons.chat_outlined, color: Colors.black, size: 25.0));
    } else {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.red,
          ),
          child: const Icon(Icons.warning_amber_rounded,
              color: Colors.black, size: 25.0));
    }
  }

  /// Use this Build to construct the Alert for the alerts pending
  Widget buildNAR(String equipment, String advice, String ar) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildSymbol(ar),
            const SizedBox(width: 20),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(equipment,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                  Text(
                    advice,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  )
                ]),
          ],
        ));
  }

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
                  width: sSize.width * 3 / 18,
                  child: Text(
                    set,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: sSize.width / 18),
              SizedBox(
                  width: sSize.width * 12 / 18,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[40],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.grey)),
                        hintText: part,
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 15)),
                  )),
              SizedBox(width: sSize.width / 18),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// get the size of the window
    Size screenSize = MediaQuery.of(context).size;

    /// List of the Comment Text Fields
    final inputList = [
      buildSetting("Weather Condition", "None", screenSize),
      buildSetting("Flight Takeoff Type", "None", screenSize),
      buildSetting("Location Started", "None", screenSize),
      buildSetting("Location Ended", "None", screenSize),
      buildSetting("Additional Comments", "None", screenSize)
    ];

    /// List of the Alerts
    List<Widget> alertList = [
    ];
    /// Conditions for alert
    /// Alert to renew licence
    if (widget.license < 24){
      alertList.add(buildNAR("licence", "Licence need to be renewed soon", 'a'));
    }
    if (widget.wings < 4){
      alertList.add(buildNAR("Wings", "Need annual safety check soon", 'a'));
    }
    if (widget.motors < 4){
      alertList.add(buildNAR("Motor", "Needs spark plug check", 'a'));
    }
    if (alertList.isEmpty){
      alertList.add(buildNAR("No Alert", "You are good to go", 'a'));
    }


    /// Directs the Home button to the Home screen
    void moveToHome(BuildContext context) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return const MainMenuScreen();
          },
        ),
      );
    }
    /// Directs the Stats button to the info stats screen
    void moveToInfoStat(BuildContext context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return  InfoStats(motors: widget.motors,
              wings: widget.wings,
              license: widget.license, );
          },
        ),
      );
    }

    // App starts here
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        /// prevents the keyboard pop up from compressing the column
        resizeToAvoidBottomInset: false,

        /// Sets the title of the Screen
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Stats"),
            backgroundColor: Colors.cyan,
            centerTitle: false),

        /// the body of the screen
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// This Column displays the 2 top buttons of Stats and Alerts on the screen
              SizedBox(
                  height: screenSize.height * 0.05,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// The Stats button
                        SizedBox(
                            width: screenSize.width * 1,
                            child: TextButton(
                                onPressed: () {
                                  moveToInfoStat(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.list,
                                        color: Colors.white, size: 14.0),
                                    Text(
                                      'Stats',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white),
                                    )
                                  ],
                                ))),
                      ])),

              /// Displays the total time Elapsed on the current run
              Container(
                  height: screenSize.height * 0.08,
                  color: Colors.cyanAccent,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Time Elapsed: ${convertT(widget.timeOut)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35.0)),
                  )),

              /// Text fields to add additional information on the flight
              SizedBox(
                  height: screenSize.height * 0.40,
                  child: Scrollbar(
                      child: ListView.builder(
                    itemCount: inputList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) {
                      return inputList[i];
                    },
                  ))),

              /// Displays the 'Alerts Pending' text on the screen
              Container(
                  height: screenSize.height * 0.07,
                  color: Colors.cyan,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      alertsPend,
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold),
                    ),
                  )),

              /// Displays the list of alerts after the flight
              SizedBox(
                  height: screenSize.height * 0.15,
                  child: Scrollbar(
                      child: ListView.builder(
                    itemCount: alertList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) {
                      return alertList[i];
                    },
                  ))),

              SizedBox(height: screenSize.height * 0.02),

              /// Default & Save Buttons
              SizedBox(
                  height: screenSize.height * 0.06,
                  child: Row(
                    children: [
                      SizedBox(width: screenSize.width * 2 / 18),
                      SizedBox(
                        width: screenSize.width * 6 / 18,
                        child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () => moveToHome(context),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.delete,
                                      color: Colors.white, size: 20.0),
                                  SizedBox(width: screenSize.width * 0.01),
                                  const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  )
                                ])),
                      ),
                      SizedBox(width: screenSize.width * 2 / 18),
                      SizedBox(
                        width: screenSize.width * 6 / 18,
                        child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () => {moveToHome(context)},
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.save_outlined,
                                      color: Colors.white, size: 20.0),
                                  SizedBox(width: screenSize.width * 0.01),
                                  const Text(
                                    'Save Log',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  )
                                ])),
                      ),
                      SizedBox(width: screenSize.width * 2 / 18),
                    ],
                  )),
              SizedBox(height: screenSize.height * 0.02),
            ], // Here, <Widget> is optional because of type inferrence
          ),
        ),
      ),
    );
  }
}
