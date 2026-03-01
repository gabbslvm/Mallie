import 'package:flutter/material.dart';
import 'boarding_page_1.dart';
import 'boarding_page_2.dart';
import 'preferences_page.dart';

class BoardingPage3 extends StatelessWidget {
  const BoardingPage3({super.key});

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Skip button
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                          MaterialPageRoute(builder: (context) => PreferencesPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF2b4c6f),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                
                SizedBox(height: 40),
                
                // Title
                Text(
                  'Make it an adventure',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2b4c6f),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 40),
                
                // Image placeholder
                Container(
                  width: 350,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Image here',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Description
                Text(
                  'Turn your mall visits into\na quest.',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF2b4c6f),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                Spacer(),
                
                // Next button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => PreferencesPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFf0b552),
                    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2b4c6f),
                    ),
                  ),
                ),
                
                SizedBox(height: 30),
                
                  // Page indicators (third dot active)
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Page 1
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardingPage1(),
                          ),
                        );
                      },
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF2b4c6f),
                            width: 2,
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    // Page 2
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardingPage2(),
                          ),
                        );
                      },
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF2b4c6f),
                            width: 2,
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    // Page 3 - Active (current page)
                    GestureDetector(
                      onTap: () {
                        // Already on this page
                      },
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2b4c6f),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}