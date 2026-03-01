import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFa8d2e6),  // Matches the top of the gradient
        title: Text(
          'Preferences',
          style: TextStyle(
            color: Color(0xFF165CA1),
            fontSize: 28,  // Blue text for contrast
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFa8d2e6), 
              Color(0xFFeaf6ff), 
              Color(0xFFffffff)
            ],
          ),
        ),
      ),
    );
  }
}