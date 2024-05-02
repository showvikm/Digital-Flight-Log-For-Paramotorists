import 'package:flutter/material.dart';

class InfoMenu extends StatelessWidget {
  const InfoMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // get screen size
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              "Additional Information",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      // Body, wind info text
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.01),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Wind levels',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // image of wind levels
              Container(
                height: screenSize.height * 0.4,
                width: screenSize.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/windsock.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.07),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cloud types',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // image of cloud types
              Container(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clouds.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
