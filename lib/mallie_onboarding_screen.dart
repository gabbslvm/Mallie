import 'package:flutter/material.dart';
import 'preferences_page.dart';

class MallieOnboardingScreen extends StatefulWidget {
  const MallieOnboardingScreen({super.key});

  @override
  State<MallieOnboardingScreen> createState() => _MallieOnboardingScreenState();
}

class _MallieOnboardingScreenState extends State<MallieOnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  double _scrollOffset = 0.0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Welcome to Mallie',
      description: '',
      isLogoPage: true,
    ),
    OnboardingData(
      title: 'Find stores easily!',
      description: 'Use Mallie to find any\nstores in seconds.',
      imagePath: 'assets/mallieOnboarding1.png',
    ),
    OnboardingData(
      title: 'Discover by Category',
      description: 'Browse shops by your\npreference.',
      imagePath: 'assets/mallieOnboarding2.png',
    ),
    OnboardingData(
      title: 'Make it an Adventure!',
      description: 'Turn your mall visits into a\nquest.',
      imagePath: 'assets/mallieOnboarding3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    _pageController.addListener(() {
      setState(() {
        _scrollOffset = _pageController.page ?? 0.0;
      });
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _animationController.reset();
    _animationController.forward();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutQuart,
      );
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const PreferencesPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: animation.drive(Tween(begin: const Offset(0.1, 0), end: Offset.zero)),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFa8d2e6), Color(0xFFeaf6ff), Color(0xFFffffff)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _navigateToHome,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 2,
                    ),
                    child: const Text('Skip', style: TextStyle(color: Color(0xFF1E5F8C), fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index], index);
                  },
                ),
              ),
              // Bottom Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  children: [
                    SizedBox(
                      width: 280,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE5A855),
                          foregroundColor: const Color(0xFF1E5F8C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 4,
                        ),
                        child: Text(
                          _currentPage == 0 ? 'Get Started' : 'Next',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildPageIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingData data, int index) {
    double relativePosition = index - _scrollOffset;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(relativePosition * 20, 0),
              child: Text(
                data.title,
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF1E5F8C)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Transform.translate(
              offset: Offset(relativePosition * 80, 0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.49,
                decoration: BoxDecoration(
                  color:Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: data.isLogoPage
                      ? Image.asset('assets/MallieLogoMain.png', fit: BoxFit.contain)
                      : data.imagePath != null
                          ? Image.asset(data.imagePath!, fit: BoxFit.contain)
                          : const Icon(Icons.image, size: 100, color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SlideTransition(
              position: _slideAnimation,
              child: Text(
                data.description,
                style: const TextStyle(fontSize: 20, color: Color(0xFF1E5F8C), fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => GestureDetector(
          onTap: () => _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeOut),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: _currentPage == index ? 24 : 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _currentPage == index
                  ? const Color(0xFF4A90E2)
                  : const Color(0xFF4A90E2).withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final bool isLogoPage;
  final String? imagePath;

  OnboardingData({
    required this.title,
    required this.description,
    this.isLogoPage = false,
    this.imagePath,
  });
}