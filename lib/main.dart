import 'package:flutter/material.dart';
import 'BoardingPage1.dart';

void main() {
  runApp(MallieApp());
}

class MallieApp extends StatelessWidget {
  const MallieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),  // Changed this line
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFa8d2e6),
              Color(0xFFeaf6ff),
              Color(0xFFffffff),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/mallie2.png',
                width: 400,
                height: 600,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BoardingPage1()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFf0b552),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2b4c6f),
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