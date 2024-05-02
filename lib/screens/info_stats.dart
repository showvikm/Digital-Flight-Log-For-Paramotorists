import 'package:flutter/material.dart';

class InfoStats extends StatelessWidget {
  final motors, wings, license;
  const InfoStats({
    Key? key,
    required this.motors,
    required this.license,
    required this.wings,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // AppBar
        appBar: AppBar(
          title: Row(
            children: const [
              Text(
                "Detailed Stats",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Motors Life Span: ${(motors).toString()} hours",
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Wings Life Span: ${(wings).toString()} hours",
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Licence: ${(license).toString()} hours",
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ])
            // Body, not yet implemented
            ));
  }
}
