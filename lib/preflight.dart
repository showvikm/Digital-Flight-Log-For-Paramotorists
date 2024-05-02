import "package:flutter/material.dart";

void main() {
  runApp(const PreFlightApp());
}

class PreFlightApp extends StatelessWidget {
  const PreFlightApp({super.key});

  /* Use this Build to construct the Alert for the alerts pending */
  Widget buildAlert(String alert, String advice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.red,
            ),
            child: const Icon(Icons.warning_amber_rounded,
                color: Colors.black, size: 30.0)),
        const SizedBox(width: 20),
        Expanded(
            flex: 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(alert,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                  Text(
                    advice,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  )
                ])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // App starts here
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text("Pre-Flight"),
            backgroundColor: Colors.deepPurple,
            centerTitle: false),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[40],
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 15)),
                      ))),
              Expanded(
                  flex: 3,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              print('you clicked reminders');
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white30),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                        )))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.alarm,
                                    color: Colors.black, size: 14.0),
                                Text(
                                  'Reminders',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                )
                              ],
                            )),
                        TextButton(
                            onPressed: () {
                              print('you clicked alerts');
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white30),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                        )))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.announcement_outlined,
                                    color: Colors.black, size: 14.0),
                                Text(
                                  'Alerts',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                )
                              ],
                            )),
                        TextButton(
                            onPressed: () {
                              print('you clicked notifications');
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white30),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                        )))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_alert_outlined,
                                    color: Colors.black, size: 14.0),
                                Text(
                                  'Notifications',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                )
                              ],
                            )),
                      ])),
              Expanded(
                  flex: 14,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(1.0),
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            buildAlert("Fuel Levels are low",
                                "Make sure to fill up your tank"),
                            buildAlert("Youre Gay", "Touch Grass"),
                            buildAlert("Youre Fat", "Lose some weight"),
                            buildAlert("Ayo Sus", "Mike Wasowsky"),
                            buildAlert("Cringe", "League Player"),
                            buildAlert("Fuel Levels are low",
                                "Make sure to fill up your tank"),
                            buildAlert("Youre Gay", "Touch Grass"),
                            buildAlert("Youre Fat", "Lose some weight"),
                            buildAlert("Ayo Sus", "Mike Wasowsky"),
                            buildAlert("Cringe", "League Player")
                          ])))),
              Expanded(
                  flex: 4,
                  child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                      child: TextButton(
                          onPressed: () {
                            print('you clicked start logging');
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.greenAccent),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_circle_outline,
                                  color: Colors.black, size: 25.0),
                              Text(
                                'Start Logging',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              )
                            ],
                          )))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            print('you clicked home');
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurple),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.0)))),
                          child: Column(
                            children: const [
                              Icon(Icons.home, color: Colors.white, size: 25.0),
                              Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.white),
                              )
                            ],
                          ))),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            print('you clicked settings');
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurple),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.0)))),
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
                          ))),
                ],
              ),
            ], // Here, <Widget> is optional because of type inferrence
          ),
        ),
      ),
    );
  }
}
