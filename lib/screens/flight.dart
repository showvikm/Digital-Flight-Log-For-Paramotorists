import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'stats.dart';
import "package:flutter/services.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class FlightScreen extends StatefulWidget {
  // const FlightScreen({super.key});
  /// Access equipment lifespan from the Database ( for now from setting screen )
  final double gas;
  const FlightScreen({
    Key? key,
    required this.gas,
  }) : super(key: key);
  @override
  FlightApp createState() => FlightApp();
}

class FlightApp extends State<FlightScreen> {
  ///Equipment Lifespan Calculator, lifespan calculated based on timer
  double EL_Calculator(double equipment) {
    equipment = double.parse((equipment - timeOut / 3600).toStringAsFixed(1));
    return equipment;
  }



  ///starting map location is set to u of s
  late GoogleMapController googleMapController;
  static const CameraPosition currentLocation =
      CameraPosition(target: LatLng(52.132854, -106.631401), zoom: 14);
  Set<Marker> markers = {};

  /// current location permission
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  /// Created global variables for timers
  Duration duration = const Duration();

  /// instantiate duration
  Timer? timer;

  /// instantiate timer
  int timeOut = 0;

  /// elapsed time sending stat screen
  int timeAdd = 1;

  /// Time (in second) added to timer every second
  /// Created global variable for stats
  double fuelDeduction = 0;
  double license = 27;

  /// in hours
  double wings = 8;
  double motor = 9;

  /// Created global variables for weather app
  var temp;

  /// temperature
  var description;

  /// weather description
  var humidity;
  var windspeed;
  var winddir;
  var cloud;
  var city;
  var country;
  var altitude;
  var feelslike;

  /// Gas alert notification tigger
  int gasAlert = 1;

  /// Created timer that update every second
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  /// Add time to timer every second
  void addTime() async {
    setState(() {
      final seconds = duration.inSeconds + timeAdd;
      duration = Duration(seconds: seconds);
      timeOut = timeOut + timeAdd;

      /// also update elapsed time
      /// Fuel reduce by 0.5L every 30 mins
      if (timeOut % 1800 == 0) {
        fuelDeduction = fuelDeduction + 0.5;
      }
    });
  }

  /// converts numerical time of hour, minutes, and seconds into string
  String displayTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(99));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    /// If fuel is is 1L or below, open dialog alert
    //gasAlertDetect();

    /// Get the current date and format it
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy - hh:mm:ss a').format(now);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
            const SizedBox(height: 30.0),

            /// Displays the timer of the flight window
            Expanded(
                flex: 7,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent,
                    ),
                    child: Center(
                      child: Text(
                        displayTime(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 60,
                            fontWeight: FontWeight.bold),
                      ),
                    ))),

            /// Display the google maps of the flight window
            Expanded(
              flex: 25,
              child: GoogleMap(
                initialCameraPosition: currentLocation,
                markers: markers,
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) async {
                  googleMapController = controller;

                  Position position = await _determinePosition();

                  googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 14)));

                  /// creates a pin at the starting location of the flight
                  markers.add(Marker(
                      markerId: const MarkerId('1'),
                      position: LatLng(position.latitude, position.longitude),
                      infoWindow: const InfoWindow(
                        title: "Start Location",
                        snippet: "Starting position of your flight",
                      )));

                  /// Gets the current weather conditions of where you are located
                  final queryParameters = {
                    'lat': '${position.latitude}',
                    'lon': '${position.longitude}',
                    'appid': 'c1354c2bb0bc228c7455d19fedf35db1',
                    'units': 'metric'
                  };

                  final uri = Uri.https('api.openweathermap.org',
                      '/data/2.5/weather', queryParameters);

                  final response = await http.get(uri);
                  var results = jsonDecode(response.body);
                  setState(() {
                    temp = (results['main']['temp']).round();
                    feelslike = (results['main']['feels_like']).round();
                    description = results['weather'][0]['description'];
                    humidity = results['main']['humidity'];
                    windspeed = (results['wind']['speed'] * 3.6).round();
                    winddir = results['wind']['deg'];
                    cloud = results['clouds']['all'];
                    city = results['name'];
                    country = results['sys']['country'];
                    altitude = (position.altitude).round();
                  });
                },
              ),
            ),

            /// The button that directs the map to the users current location
            Expanded(
              flex: 4,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  Position position = await _determinePosition();

                  googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 14)));

                  ///create a pin at the current location that you are at
                  markers.add(Marker(
                      markerId: const MarkerId('2'),
                      position: LatLng(position.latitude, position.longitude),
                      infoWindow: const InfoWindow(
                        title: "Current Location",
                        snippet: "Your current location",
                      )));

                  /// updates the  current temperature of where you are located when the button is pressed
                  final queryParameters = {
                    'lat': '${position.latitude}',
                    'lon': '${position.longitude}',
                    'appid': 'c1354c2bb0bc228c7455d19fedf35db1',
                    'units': 'metric'
                  };

                  final uri = Uri.https('api.openweathermap.org',
                      '/data/2.5/weather', queryParameters);

                  final response = await http.get(uri);
                  var results = jsonDecode(response.body);
                  setState(() {
                    temp = (results['main']['temp']).round();
                    feelslike = (results['main']['feels_like']).round();
                    description = results['weather'][0]['description'];
                    humidity = results['main']['humidity'];
                    windspeed = (results['wind']['speed'] * 3.6).round();
                    winddir = results['wind']['deg'];
                    cloud = results['clouds']['all'];
                    city = results['name'];
                    country = results['sys']['country'];
                    altitude = (position.altitude).round();
                  });
                },
                label: const Text('Current Location',
                    style: TextStyle(color: Colors.white)),
                icon: const Icon(
                  Icons.location_history,
                  color: Colors.white,
                ),
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: Colors.black45,
              ),
            ),

            /// Displays current date and time
            Expanded(
              flex: 5,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.lightBlueAccent,
                  ),
                  width: double.infinity,
                  height: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${city != null ? city.toString() : 'Loading'}, ${country != null ? country.toString() : 'Loading'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ])),
            ),

            /// contains the lower section of the flight menu (run/pause buttons and weather data)
            Expanded(
              flex: 15,
              child: Container(
                  //width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// this list down the weather variables for the flight
                        Expanded(
                            flex: 10,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 0),
                                      child: Text(
                                          'Fuel: ${(widget.gas - fuelDeduction).toString()} L',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0))),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 2.0, 20.0, 0),
                                      child: Text(
                                          'Temperature: ${temp != null ? temp.toString() : 'Loading'}° C\n'
                                          'Feels like: ${feelslike != null ? feelslike.toString() : 'Loading'}° C\n'
                                          'Wind speed: ${windspeed != null ? windspeed.toString() : 'Loading'} km/h\n'
                                          'Wind direction: ${winddir != null ? winddir.toString() : 'Loading'}°\n'
                                          'Humidity Level: ${humidity != null ? humidity.toString() : 'Loading'} %\n'
                                          'Weather Description:\n${description != null ? description.toString() : 'Loading'}\n'
                                          'Cloudiness: ${cloud != null ? cloud.toString() : 'Loading'}%\n'
                                          'Altitude: ${altitude != null ? altitude.toString() : 'Loading'} m',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0))),
                                ])),

                        /// This stops the timer proceeds to the stats screen
                        Expanded(
                            flex: 5,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: FloatingActionButton(
                                    /// Once the stop button is pressed send the elapsed time to stat screen
                                    onPressed: () => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StatsScreen(
                                                    timeOut: timeOut,
                                                    motors:
                                                        EL_Calculator(motor),
                                                    license:
                                                        EL_Calculator(license),
                                                    wings: EL_Calculator(wings),
                                                  )))
                                    },
                                    child: const Icon(Icons.stop,
                                        color: Colors.black54, size: 80.0),
                                  ),
                                )))
                      ])),
            ),
          ]))),
    );
  }
}
