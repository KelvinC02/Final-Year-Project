import "package:flutter/material.dart";

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Image.asset('assets/images/app_logo.jpeg'),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      "DriveVue",
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Version 1.0",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Times New Roman",
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
