import "package:DriveVue/terms_and_conditions.dart";
import "package:flutter/material.dart";

void main() {
  runApp(SplashScreen1());
}

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

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
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditions()),
                    );
                  },
                  child: null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
