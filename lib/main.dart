import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mallie_splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const MallieApp());
}

class MallieApp extends StatelessWidget {
  const MallieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mallie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A90E2),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90E2),
          primary: const Color(0xFF4A90E2),
        ),
        useMaterial3: true,
      ),
      home: const MallieSplashScreen(),
    );
  }
}

class MallieHomeScreen extends StatelessWidget {
  const MallieHomeScreen({super. key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mallie Home'),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
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
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.store,
                size: 80,
                color: Color(0xFF4A90E2),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Mallie!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5F8C),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your friendly mall guide',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF4A90E2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}