import "package:flutter/material.dart";
import "./preflight.dart";
import "package:flutter/services.dart";

class ParamotorProcessMenu extends StatefulWidget {
  const ParamotorProcessMenu({super.key});

  @override
  ParamotorProcessScreen createState() => ParamotorProcessScreen();
}

class ParamotorProcessScreen extends State<ParamotorProcessMenu> {
  static const title = 'PreFlight';
  static const done = 'Done';

  void moveToPreFlight(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const PreFlightMenu();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// get the size of the window
    Size screenSize = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // App starts here
    return MaterialApp(
      home: Scaffold(
        /// Sets the title of the screen
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                title,
              ),
              SizedBox(width: screenSize.width * 0.50),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => moveToPreFlight(context),
                  child: const Text(
                    done,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.cyan,
        ),

        /// Body of the menu
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// The entire paramotoring process
                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Paramotoring Process',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Things you need to remember',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Basic pre flight checks',
                      style: TextStyle(fontSize: 20.0, color: Colors.black54)),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilot',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1) Fitness and state of mind\n2) Pockets sealed - empty\n3) Loose items\n4) Footware\n5) Helmet',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Wing',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1) Opening up\n2) Checking\n3) Controls',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Finally',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1) Helmet - chin strap & fitr\n2) Harness - Buckles - Loops length\n3) Wing to motor - karabiners\n4) Pilot - Loose objects - no scarfs',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.02),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PRE-ENGINE START: Fu.S.T.I.C.S',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Fu - Fuel. Tap. Cap. Contents. Quality. Vent\n'
                    'S - Security. Loose items. Zips. Drawings. Hair. Cage. Netting\n'
                    'T - Throttle. Full & Free Movement. Throttle. Closed. Choke Set.\n'
                    'I - Ignition. On.\n'
                    'C - Clear. "Clear Prop"\n'
                    'S - Start. Start Engine. Kill Switch. Vibration. Warm Up.',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.02),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PRE-TAKE OFF: W.H.I.P.S & M.A.C.E',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'W - Wind and Weather. Speed and direction, incoming.\n'
                    'H - Helmet and Harness. Helmet on and fastened, harness all fastened and chest strap set, reserve pin in.\n'
                    'I - Instruments. On, Set.\n'
                    'P - Performance limitations. Did I check that a take-off can safely be made from this field in these conditions.\n'
                    'S - Straps and Security. No loose items, pockets closed, drawings, hoods.',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.02),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'M - Motor, Motor running cleanly and revving normally. Idle.\n'
                    'A - All Clear. Above & In Front. Traffic. Keep Checking.\n'
                    'C - Controls. Correctly held for launch type, no twists, trimmers set.\n'
                    'E - Eventualities. Plans for dealing with emergencies during the take off and climb out.',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.02),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('PRE-LANDING: W.U.T.F.I.S.T',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'W - Wind. Direction & Strength.\n'
                    'U - Undercarriage. Down & Locked!\n'
                    'T - Trimmers. Set for Landing.\n'
                    'F - Fuel. Sufficient.\n'
                    'I - Ignition. Power On or Power Off?\n'
                    'S - Security. Loose Items. Speedbar & Stirrup Secure.\n'
                    'T - Throttle. Full & Free Movement - If Used.',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.02),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('PARAGLIDING PRE-TAKE-OFF: WGHHCAT',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),

                SizedBox(height: screenSize.height * 0.01),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      '("Will Geordie Have His Cat Aboard Today")\n'
                      'W - Wind & Weather. Speed & Direction. Incoming.\n'
                      'G - Glider. Layout. Cells Clear. Lines Free.\n'
                      'H - Helmet. On & Secure.\n'
                      'H - Harness. Leg Strap. Chest Strap. Karabiners. Reserve.\n'
                      'C - Controls. Correctly Held. No Twists. Trimmers Set.\n'
                      'A - All Clear. Above & In Front. Traffic. Keep Checking.\n'
                      'T - Turn Direction. Which Way For A Reverse Launch?.',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                      )),
                ),

                SizedBox(height: screenSize.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
