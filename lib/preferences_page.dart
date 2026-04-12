import 'package:flutter/material.dart';
import 'auth_screen.dart';

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

  bool isSelected(String item) => selectedItems.contains(item);

  // Pass selectedItems to AuthScreen; empty list = skipped (show all)
  void _goToAuth() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AuthScreen(selectedPreferences: List.from(selectedItems)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFa8d2e6),
        title: const Text(
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
            icon: const Icon(Icons.person_outline, color: Color(0xFF165CA1), size: 28),
            onPressed: _goToAuth,
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFa8d2e6), Color(0xFFeaf6ff), Color(0xFFffffff)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'What do you usually shop for?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1a1a1a),
                      ),
                    ),
                    const SizedBox(height: 30),

                    _sectionLabel('Trending'),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 25),

                    _sectionLabel('Food & Lifestyle'),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 25),

                    _sectionLabel('Personal'),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 30),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _goToAuth,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        side: const BorderSide(color: Color(0xFFF0B552), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF0B552),
                        ),
                      ),
                    ),
                  ),
                  if (selectedItems.isNotEmpty) ...[
                    const SizedBox(width: 50),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _goToAuth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF0B552),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1a1a1a),
      ),
    );
  }

  Widget buildChip(String label) {
    final selected = isSelected(label);
    return GestureDetector(
      onTap: () => onItemTapped(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF0B552) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : const Color(0xFF1a1a1a),
          ),
        ),
      ),
    );
  }
}