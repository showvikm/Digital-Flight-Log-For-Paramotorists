import "package:flutter/material.dart";
import "./paramotor_process.dart";
import './main_menu_screen.dart';
import "./flight.dart";
import "./settings.dart";
import "package:flutter/services.dart";

class PreFlightMenu extends StatefulWidget {
  const PreFlightMenu({super.key});

  @override
  PreFlightScreen createState() => PreFlightScreen();
}

class PreFlightScreen extends State<PreFlightMenu> {
  /// List of alerts
  Map<String, String>? alertList = {
    "License": "Be sure to renew your license before it expires",
    "Wings": "Need annual safety check soon",
    "Motor": "Needs spark plug check"
  };

  /// Alert Activator
  Map<String?, int> alertActivator = {"License": 1, "Wings": 1, "Motor": 1};

  /// List of reminders
  Map<String, String>? reminderList = {
    "Buckle Up": "Tighten gear properly to ensure a safe flight",
    "Feel the Wind": "Be sure that the weather is not too harsh",
    "Keep Watch": "Avoid power poles when landing"
  };

  /// reminder text
  late TextEditingController reminderController;
  late TextEditingController reminderDescriptionController;
  late TextEditingController gasController;
  late TextEditingController deleteController;
  late TextEditingController modifierNameController;
  late TextEditingController modifierDescriptionController;
  late TextEditingController modifierValueController;
  double gas = 2.0;

  /// filter flag
  dynamic filterFlag = 0;

  /// Drop down Menu Delete/Modify
  late List<String> reminderAlertKeys = remAlertInit(reminderList, alertList);
  late List<String> reminderKeys = remInit(reminderList);
  String keyValue = 'None';
  String modValue = 'None';

  /// Drop down Menu consts
  final options = ['None', 'Add', 'Delete', 'Modify'];
  String selectedValue = 'None';

  /// text Constants
  static const title = 'PreFlight';
  static const search = 'Search';
  static const reminders = 'Reminders';
  static const alerts = 'Alerts';
  static const notification = 'Notification';
  static const startLog = 'Start Logging';
  static const home = 'Home';
  static const settings = 'Settings';

  /// List of Alerts and Reminders
  Widget buildNAR(String equipment, String advice, String ar) {
    /// Use this Build to construct the Alerts and Reminders
    if (ar == 'r') {
      return Padding(
          padding: const EdgeInsets.all(5.0),
          child: IntrinsicHeight(
              child: Row(children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
                child: const Icon(Icons.chat_outlined,
                    color: Colors.black, size: 25.0)),
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
                      fontSize: 14.0,
                    ),
                  )
                ]),
            const SizedBox(width: 45),
          ])));
    } else {
      return Padding(
          padding: const EdgeInsets.all(5.0),
          child: IntrinsicHeight(
              child: Row(children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red,
                ),
                child: const Icon(Icons.warning_amber_rounded,
                    color: Colors.black, size: 25.0)),
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
                      fontSize: 14.0,
                    ),
                  )
                ]),
            const SizedBox(width: 30),
          ])));
    }
  }

  /// Directs the reminders button to the paramotor_process screen
  void moveToParamotorProcess(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const ParamotorProcessMenu();
        },
      ),
    );
  }

  /// Directs the Start Logging button to the flight screen
  void moveToFlight(BuildContext context, double gas) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return FlightScreen(
            gas: gas,
          );
        },
      ),
    );
  }

  /// Directs the Settings button to the settings screen
  void moveToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SettingsMenu();
        },
      ),
    );
  }

  /// Directs the Home button to the Home screen
  void moveToHome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const MainMenuScreen();
        },
      ),
    );
  }

  /// The dialog box pop up for the Modify reminder
  Future<Map<String, dynamic>?> openDialogModify() =>
      showDialog<Map<String, dynamic>?>(
          context: context,
          builder: (context) => StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  elevation: 16,
                  title: const Text('Specify the Reminder to be changed:'),
                  content: SizedBox(
                    height: 185.0,
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          value: modValue,
                          items: reminderKeys
                              .map<DropdownMenuItem<String>>((String value) =>
                                  DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 10.0),
                                          child: Text(value,
                                              style: const TextStyle(
                                                  fontSize: 18.0)))))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() => modValue = newValue!);
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          underline: const SizedBox(),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          autofocus: true,
                          cursorColor: Colors.grey,
                          controller: modifierNameController,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[40],
                              filled: true,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: 'New Name',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          autofocus: true,
                          controller: modifierDescriptionController,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[40],
                              filled: true,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: 'New Description',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          cancelModifier();
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          modifierValueController.text = modValue;
                          submitModifier();
                        },
                        child: const Text('Save')),
                  ],
                );
              }));

  /// The dialog box to pop up for Delete Alerts/Reminder
  Future<String?> openDialogDelete() => showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              elevation: 20,
              title: const Text('Choose a Reminder or Alert to delete:'),
              content: DropdownButton<String>(
                value: keyValue,
                items: reminderAlertKeys
                    .map<DropdownMenuItem<String>>((String value) =>
                        DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                child: Text(value,
                                    style: const TextStyle(fontSize: 18.0)))))
                    .toList(),
                onChanged: (newValue) {
                  setState(() => keyValue = newValue!);
                },
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 20,
                underline: const SizedBox(),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      cancelDelete();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      deleteController.text = keyValue;
                      submitDelete();
                    },
                    child: const Text('Delete')),
              ],
            );
          }));

  /// The dialog box pop up for the Add reminder
  Future<Map<String, dynamic>?> openDialogAdd() =>
      showDialog<Map<String, dynamic>?>(
          context: context,
          builder: (context) => AlertDialog(
                elevation: 20,
                title: const Text(
                    'Enter the name of your reminder and its description:'),
                content: SizedBox(
                  height: 125.0,
                  child: Column(
                    children: [
                      TextField(
                        autofocus: true,
                        cursorColor: Colors.grey,
                        controller: reminderController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[40],
                            filled: true,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: 'Reminder Name',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        autofocus: true,
                        controller: reminderDescriptionController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[40],
                            filled: true,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: 'Reminder Description',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        cancelReminder();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        submitReminder();
                      },
                      child: const Text('Save')),
                ],
              ));

  /// The dialog box pop up for the Addition of gas before flight
  Future<double?> openDialog() => showDialog<double>(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            elevation: 20,
            title: const Text('Enter your current amount of Gas (liters):'),
            content: SizedBox(
              height: 50.0,
              child: Slider(
                  min: 2.0,
                  max: 8.0,
                  divisions: 6,
                  value: gas,
                  onChanged: (nGas) {
                    setState(() => gas = nGas);
                  },
                  label: "$gas"),
            ),
            actions: [
              TextButton(onPressed: cancelGas, child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    submitGas;
                    moveToFlight(context, gas);
                  },
                  child: const Text('Save'))
            ],
          );
        }),
      );

  @override
  void initState() {
    super.initState();

    reminderController = TextEditingController();
    reminderDescriptionController = TextEditingController();
    gasController = TextEditingController();
    deleteController = TextEditingController();
    modifierValueController = TextEditingController();
    modifierNameController = TextEditingController();
    modifierDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    reminderController.dispose();
    reminderDescriptionController.dispose();
    gasController.dispose();
    deleteController.dispose();
    modifierValueController.dispose();
    modifierNameController.dispose();
    modifierDescriptionController.dispose();

    super.dispose();
  }

  void cancelModifier() {
    Navigator.of(context).pop();
    modifierValueController.clear();
    modifierNameController.clear();
    modifierDescriptionController.clear();
  }

  void submitModifier() {
    Navigator.of(context).pop({
      'a': modifierValueController.text,
      'b': modifierNameController.text,
      'c': modifierDescriptionController.text,
    });
    modifierValueController.clear();
    modifierNameController.clear();
    modifierDescriptionController.clear();
  }

  void cancelGas() {
    Navigator.of(context).pop();
    gasController.clear();
  }

  void submitGas() {
    Navigator.of(context).pop(gasController.hashCode);
    gasController.clear();
  }

  void cancelReminder() {
    Navigator.of(context).pop();
    reminderController.clear();
    reminderDescriptionController.clear();
  }

  void submitReminder() {
    Navigator.of(context).pop({
      'a': reminderController.text,
      'b': reminderDescriptionController.text
    });
    reminderController.clear();
    reminderDescriptionController.clear();
  }

  void cancelDelete() {
    Navigator.of(context).pop(deleteController.text);
    deleteController.clear();
  }

  void submitDelete() {
    Navigator.of(context).pop(deleteController.text);
    deleteController.clear();
  }

  /// filetering mechanism for the reminders and alerts
  /// A: List of alerts
  /// R: List of reminders
  List<Widget>? filterList(List<Widget>? A, List<Widget>? R) {
    List<Widget>? filteredList;
    if (filterFlag == 1) {
      if (A == null) {
        return filteredList;
      } else {
        filteredList = A;
        return filteredList;
      }
    } else if (filterFlag == 2) {
      if (R == null) {
        return filteredList;
      } else {
        filteredList = R;
        return filteredList;
      }
    } else {
      if (R == null && A == null) {
        return filteredList;
      } else if (R == null) {
        filteredList = A;
        return filteredList;
      } else if (A == null) {
        filteredList = R;
        return filteredList;
      } else {
        filteredList = A + R;
        return filteredList;
      }
    }
  }

  /// Modify Reminder
  Map<String, String>? modifyReminder(
      Map<String, String>? rl, String value, String name, String description) {
    Map<String, String>? newReminders = {};
    rl?.forEach((v, k) {
      if (v == value) {
        newReminders[name] = description;
      } else {
        newReminders[v] = k;
      }
    });
    return newReminders;
  }

  /// Create displayable list of Alerts
  List<Widget>? displayAlert(Map<String, String>? al) {
    List<Widget>? listofAlerts;
    if (al == null) {
      return listofAlerts;
    } else {
      listofAlerts = [];
      al.forEach((i, j) {
        if (alertActivator[i] == 1) {
          listofAlerts?.add(buildNAR(i, j, 'a'));
        }
      });
      return listofAlerts;
    }
  }

  /// Create displayable list of Reminders
  List<Widget>? displayReminder(Map<String, String>? rl) {
    List<Widget>? listofReminders;
    if (rl == null) {
      return listofReminders;
    } else {
      listofReminders = [];
      rl.forEach((v, k) => listofReminders?.add(buildNAR(v, k, 'r')));
      return listofReminders;
    }
  }

  /// Initialize the List of reminder and alert names
  List<String> remAlertInit(Map<String, String>? rl, Map<String, String>? al) {
    List<String> rk = ["None"];
    al?.forEach((v, k) {
      if (alertActivator[v] == 1) {
        rk.add(v);
      }
    });
    rl?.forEach((v, k) => rk.add(v));
    return rk;
  }

  /// Initialize the List of reminder names
  List<String> remInit(Map<String, String>? rl) {
    List<String> rk = ["None"];
    rl?.forEach((v, k) => rk.add(v));
    return rk;
  }

  /// Separate list of alerts
  late List<Widget>? listofAlerts = displayAlert(alertList);

  /// Separate list of reminders
  late List<Widget>? listofReminders = displayReminder(reminderList);

  /// List of the Alerts and Reminders
  late List<Widget>? listofAR = filterList(listofAlerts, listofReminders);

  @override
  Widget build(BuildContext context) {
    /// get the size of the window
    Size screenSize = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // App starts here
    return MaterialApp(
        home: Scaffold(
      /// prevents the keyboard pop up from compressing the column
      resizeToAvoidBottomInset: false,

      /// Sets the title of the screen
      appBar: AppBar(
        title: const Text(
          style: TextStyle(color: Colors.white),
          title,
        ),
        backgroundColor: Colors.cyan,
      ),

      /// the body of the screen
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brix's image here

              /// These display the tabs for the Reminders and Alerts
              Container(
                  height: screenSize.height * 0.06,
                  color: Colors.blueAccent,
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// The Reminder Tab
                            /// TO DO: redirect list to a list of reminders
                            TextButton(
                                onPressed: () {
                                  if (filterFlag != 2) {
                                    setState(() => filterFlag = 2);
                                  } else {
                                    setState(() => filterFlag = 0);
                                  }
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
                                              color: Colors.black,
                                            )))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.alarm,
                                        color: Colors.black, size: 14.0),
                                    Text(
                                      reminders,
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black),
                                    )
                                  ],
                                )),

                            /// The Alerts Tab
                            /// TO DO: redirect list to a list of alerts
                            TextButton(
                                onPressed: () {
                                  if (filterFlag != 1) {
                                    setState(() => filterFlag = 1);
                                  } else {
                                    setState(() => filterFlag = 0);
                                  }
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
                                              color: Colors.black,
                                            )))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.announcement_outlined,
                                        color: Colors.black, size: 14.0),
                                    Text(
                                      alerts,
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black),
                                    )
                                  ],
                                )),

                            /// Display the dropdown menu to Add, Remove, and Modify reminders
                            Container(
                                height: screenSize.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<String>(
                                  value: selectedValue,
                                  items: options
                                      .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0.0,
                                                          horizontal: 10.0),
                                                      child: Text(value,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      18.0)))))
                                      .toList(),
                                  onChanged: (newValue) async {
                                    if (newValue == 'Add') {
                                      Map<String, String>? data =
                                          (await openDialogAdd())
                                              ?.cast<String, String>();

                                      if (reminderList != null || reminderList != []) {
                                        bool? b = reminderList?.containsKey(data!["a"]);
                                        if (b == true) return;
                                      }
                                      if (data!["a"] == null || data!["a"] == "License" || data!["a"] == "Motor" || data!["a"] == "Wings" || data!["a"] == ''
                                          || data["b"] == null || data["b"] == '') return;

                                      if (data!["a"] == null ||
                                          data["a"] == "License" ||
                                          data["a"] == "Motor" ||
                                          data["a"] == "Wings" ||
                                          data["a"] == '' ||
                                          data["b"] == null ||
                                          data["b"] == '') return;
                                      setState(() {
                                        selectedValue = newValue!;
                                        reminderList![data['a']!] = data['b']!;
                                        reminderAlertKeys = remAlertInit(
                                            reminderList, alertList);
                                        reminderKeys = remInit(reminderList);
                                        listofReminders =
                                            displayReminder(reminderList);
                                        listofAR = filterList(
                                            listofAlerts, listofReminders);
                                      });
                                      //disposeReminder();
                                      selectedValue = 'None';
                                    } else if (newValue == 'Delete') {
                                      String? val = await openDialogDelete();
                                      if (val != 'None') {
                                        if (alertActivator.containsKey(val)) {
                                          setState(() {
                                            alertActivator[val] = 0;
                                          });
                                        } else {
                                          setState(() {
                                            reminderList?.remove(val);
                                          });
                                        }
                                      }
                                      setState(() {
                                        selectedValue = newValue!;
                                        reminderAlertKeys = remAlertInit(
                                            reminderList, alertList);
                                        reminderKeys = remInit(reminderList);
                                        listofReminders =
                                            displayReminder(reminderList);
                                        listofAlerts = displayAlert(alertList);
                                        listofAR = filterList(
                                            listofAlerts, listofReminders);
                                      });
                                      keyValue = 'None';
                                      selectedValue = 'None';
                                    } else if (newValue == 'Modify') {
                                      Map<String, String>? data =
                                          (await openDialogModify())
                                              ?.cast<String, String>();
                                      if (data!['a'] != 'None') {
                                        if (data["b"] == null ||
                                            data["b"] == "License" ||
                                            data["b"] == "Motor" ||
                                            data["b"] == "Wings" ||
                                            data["b"] == '' ||
                                            data["c"] == null ||
                                            data["c"] == '') return;
                                        setState(() {
                                          selectedValue = newValue!;
                                          reminderList = modifyReminder(
                                              reminderList,
                                              data['a']!,
                                              data['b']!,
                                              data['c']!);
                                          reminderAlertKeys = remAlertInit(
                                              reminderList, alertList);
                                          reminderKeys = remInit(reminderList);
                                          listofReminders =
                                              displayReminder(reminderList);
                                          listofAR = filterList(
                                              listofAlerts, listofReminders);
                                        });
                                        modValue = 'None';
                                        selectedValue = 'None';
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 20,
                                  underline: const SizedBox(),
                                )),
                          ]))),

              /// Displays the list of Reminders and Alerts
              SizedBox(
                  height: screenSize.height * 0.65,
                  child: Scrollbar(
                      child: ListView.builder(
                    itemCount: listofAR == null
                        ? 0
                        : filterList(listofAlerts, listofReminders)?.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) {
                      listofAR = filterList(listofAlerts, listofReminders);
                      return listofAR == null ? const SizedBox() : listofAR![i];
                    },
                  ))),

              /// The construction of the checklist button and the start logging button
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.1),

                    /// This display the yellow checklist button on the screen
                    SizedBox(
                        height: screenSize.height * 0.08,
                        width: screenSize.width * 0.2,
                        child: FloatingActionButton(
                          onPressed: () => moveToParamotorProcess(context),
                          backgroundColor: Colors.yellow,
                          child: const Icon(Icons.checklist_rounded,
                              color: Colors.black, size: 25.0),
                        )),
                    SizedBox(width: screenSize.width * 0.1),

                    /// This display the green start logging button on the screen
                    SizedBox(
                      height: screenSize.height * 0.08,
                      width: screenSize.width * 0.5,
                      child: FloatingActionButton.extended(
                        onPressed: () async {
                          final newGas = await openDialog();
                          if (newGas == null) return;

                          setState(() => gas = newGas);
                        },
                        backgroundColor: Colors.greenAccent,
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.black, size: 25.0),
                        label: const Text(
                          startLog,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.1),
                  ],
                ),
              ),

              /// This displays the bottom menu on the screen
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// The button for the Home
                  Expanded(
                      child: TextButton(
                          onPressed: () => moveToHome(context),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.cyan),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.0)))),
                          child: Column(
                            children: const [
                              Icon(Icons.home, color: Colors.white, size: 25.0),
                              Text(
                                home,
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.white),
                              )
                            ],
                          ))),

                  /// The button for the Settings
                  Expanded(
                      child: TextButton(
                          onPressed: () => moveToSettings(context),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.cyan),
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
                                settings,
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.white),
                              )
                            ],
                          ))),
                ],
              )),
            ]), // Here, <Widget> is optional because of type inferrence
      ),
    ));
  }
}
