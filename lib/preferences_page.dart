import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<String> selectedItems = [];

  void onItemTapped(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  bool isSelected(String item) {
    return selectedItems.contains(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFa8d2e6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF165CA1), size: 28),
          onPressed: () {
            Navigator.of(context).pop();
            },
          ),
        title: Text(
          'Preferences',
          style: TextStyle(
            color: Color(0xFF165CA1),
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline, color: Color(0xFF165CA1), size: 28),
            onPressed: () {
              // User profile button pressed
            },
          ),
        ],
        elevation: 0,
      ),
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    
                    Text(
                      'What do you usually shop for?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1a1a1a),
                      ),
                    ),
                    SizedBox(height: 30),

                    Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1a1a1a),
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        buildChip('Clothing'),
                        buildChip('Footwear'),
                        buildChip('Accessories'),
                        buildChip('Home'),
                        buildChip('Skincare'),
                        buildChip('Electronics'),
                        buildChip('Groceries'),
                        buildChip('Wellness'),
                      ],
                    ),
                    SizedBox(height: 25),

                    Text(
                      'Food & Lifestyle',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1a1a1a),
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        buildChip('Restaurants'),
                        buildChip('Cafe'),
                        buildChip('Pastries'),
                        buildChip('Fast Food'),
                        buildChip('Cinema'),
                        buildChip('Arcade'),
                        buildChip('Books'),
                      ],
                    ),
                    SizedBox(height: 25),

                    Text(
                      'Personal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1a1a1a),
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        buildChip('Jewelry'),
                        buildChip('Sports & Fitness'),
                        buildChip('Toys & Kids'),
                        buildChip('Eyewear'),
                        buildChip('Barbershop & Salon'),
                        buildChip('Spa & Relaxation'),
                        buildChip('Pet Supplies'),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 30),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Row(
                children: [
                  // Skip button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Uncomment when home screen is ready
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => YourHomeScreen()),
                        // );
                        Text('Skipped preferences');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        side: BorderSide(color: Color(0xFF165CA1), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF165CA1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  
                  // Next button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Text('Selected: $selectedItems');
                        // TODO: Uncomment when home screen is ready
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => YourHomeScreen()),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF165CA1),
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChip(String label) {
    bool selected = isSelected(label);
    
    return GestureDetector(
      onTap: () {
        onItemTapped(label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Color(0xFF4A9FE5) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Color(0xFF1a1a1a),
          ),
        ),
      ),
    );
  }
}