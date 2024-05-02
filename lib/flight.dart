import "package:flutter/material.dart";
import 'dart:async';

void main() {
  // int time = 5;
  runApp(const FlightState());
}

class FlightState extends StatefulWidget {
  const FlightState({super.key});

  @override
  FlightApp createState() => FlightApp();
}

class FlightApp extends State<FlightState> {
  Duration duration = const Duration();
  int flagStop = -1;

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      const addsecond = 1;
      if (flagStop == -1) {
        setState(() {
          final seconds = duration.inSeconds + addsecond;
          duration = Duration(seconds: seconds);
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _stopTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        flagStop = -flagStop;
        timer.cancel();
      });
    });
  }

  String displayTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // String twoDigits(int n) => n.toString().padLeft(2, '0');
    // final minutes = twoDigits(duration.inMinutes.remainder(60));
    // final seconds =
    // App starts here
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text("Flight"),
              backgroundColor: Colors.deepPurple,
              centerTitle: false),
          body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Expanded(
                    flex: 7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          displayTime(),
                          style: const TextStyle(fontSize: 40),
                        ),
                        MaterialButton(
                          onPressed: _startTimer,
                          color: Colors.purple,
                          child: const Text('Start',
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    )),
                Expanded(
                    flex: 30,
                    child: Image.network(
                      'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                Expanded(
                    flex: 5,
                    child: Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.indigo,
                        child: const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Saskatoon, SK\n Sat| Oct 10',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )))),
                Expanded(
                  flex: 15,
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color(0xFF39A5EF),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(1.0, -0.2),
                      child: IconButton(
                        iconSize: 100,
                        onPressed: _stopTimer,
                        icon: const Icon(Icons.stop_circle_outlined,
                            color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ]))),
    );
  }
}
