import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mallie_shop_page.dart';
import 'mallie_quest_page.dart';
import 'mallie_wallet_page.dart';
import 'mallie_profile_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MallieHomeScreen());
}

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);

class MallieHomeScreen extends StatelessWidget {
  const MallieHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mallie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBg,
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSeed(
          seedColor: kBlue,
          primary: kBlue,
          secondary: kYellow,
        ),
        useMaterial3: true,
      ),
      home: const MallieHomePage(),
    );
  }
}

class StoreRec {
  final String name;
  final String location;
  final String price;
  final String discount;
  final Color accent;
  final IconData icon;

  const StoreRec({
    required this.name,
    required this.location,
    required this.price,
    required this.discount,
    required this.accent,
    required this.icon,
  });
}

class NearbyStore {
  final String name;
  final String floor;
  final int distanceMeters;
  final Color color;

  const NearbyStore({
    required this.name,
    required this.floor,
    required this.distanceMeters,
    required this.color,
  });
}

class MallieHomePage extends StatefulWidget {
  const MallieHomePage({super.key});

  @override
  State<MallieHomePage> createState() => _MallieHomePageState();
}

class _MallieHomePageState extends State<MallieHomePage>
    with TickerProviderStateMixin {
  int _selectedTab = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController _floatCtrl;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _floatAnim;
  late final Animation<double> _pulseAnim;

  static const _pages = [
    null, // Home rendered inline
    ShopPage(),
    QuestPage(),
    WalletPage(),
    ProfilePage(),
  ];

  static const _categories = [
    ('Fashion', '👗', Color(0xFFFCE8F0)),
    ('Food', '🍔', Color(0xFFFFF4E0)),
    ('Tech', '⌚', Color(0xFFE6F0FF)),
    ('Beauty', '💄', Color(0xFFF5E8FF)),
    ('Sports', '⚽', Color(0xFFE8FFF2)),
  ];

  static const _recs = [
    StoreRec(
      name: 'ZARA',
      location: '2F · East Wing',
      price: '\$\$',
      discount: '20% OFF',
      accent: Color(0xFF1A1A1A),
      icon: Icons.checkroom_rounded,
    ),
    StoreRec(
      name: 'NIKE',
      location: '2F · East Wing',
      price: '\$\$',
      discount: '20% OFF',
      accent: Color(0xFF111111),
      icon: Icons.directions_run_rounded,
    ),
    StoreRec(
      name: 'SEPHORA',
      location: '1F · Main Atrium',
      price: '\$\$\$',
      discount: '15% OFF',
      accent: Color(0xFFB8003D),
      icon: Icons.face_retouching_natural,
    ),
  ];

  static const _nearby = [
    NearbyStore(
      name: 'PowerHub',
      floor: '3F',
      distanceMeters: 42,
      color: kBlue,
    ),
    NearbyStore(
      name: 'GadgetZone',
      floor: '3F',
      distanceMeters: 78,
      color: kYellow,
    ),
    NearbyStore(
      name: 'TechWorld',
      floor: '4F',
      distanceMeters: 120,
      color: Color(0xFF55C08A),
    ),
  ];

  static const _navItems = [
    (Icons.home_rounded, Icons.home_outlined, 'Home'),
    (Icons.storefront_rounded, Icons.storefront_outlined, 'Shop'),
    (Icons.emoji_events_rounded, Icons.emoji_events_outlined, 'Quest'),
    (
      Icons.account_balance_wallet_rounded,
      Icons.account_balance_wallet_outlined,
      'Wallet',
    ),
    (Icons.person_rounded, Icons.person_outlined, 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
    _pulseAnim = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedTab != 0) {
      return Scaffold(
        backgroundColor: kBg,
        body: _pages[_selectedTab],
        bottomNavigationBar: _buildBottomNav(),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBg,
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          _blob(
            top: -80,
            right: -80,
            color: kBlue.withValues(alpha: 0.08),
            size: 240,
          ),
          _blob(
            top: 200,
            left: -90,
            color: kYellow.withValues(alpha: 0.06),
            size: 200,
          ),
          _blob(
            bottom: 80,
            right: -50,
            color: kBlue.withValues(alpha: 0.05),
            size: 180,
          ),
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [_buildTopBar(), _buildSearchBar()],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: _buildCategories(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                        child: _sectionHeader(
                          'Recommended for you',
                          showStar: true,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: _buildRecommendedCards(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                        child: _sectionHeader('Nearby Stores'),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                        child: _buildNearbyList(),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: kBlue),
            child: Text(
              'Welcome, Mallie here!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Account Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _blob({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Color color,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _floatAnim,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, _floatAnim.value),
              child: child,
            ),
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, child) =>
                  Transform.scale(scale: _pulseAnim.value, child: child),
              child: Image.asset(
                'assets/mallie_mini_logo.png',
                width: 60,
                height: 60,
                errorBuilder: (c, e, s) => const Icon(Icons.face, size: 40),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hi! I'm Mallie",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: kDark,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('👋', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Text(
                  'Your smart mall navigator',
                  style: TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          _iconButton(
            child: const Icon(
              Icons.notifications_outlined,
              color: kDark,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: _iconButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _burgerLine(width: 18),
                  const SizedBox(height: 4),
                  _burgerLine(width: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton({required Widget child}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: kCard,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }

  Widget _burgerLine({required double width}) {
    return Container(
      width: width,
      height: 2,
      decoration: BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: kBlue.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          children: [
            SizedBox(width: 16),
            Icon(Icons.search_rounded, color: kLight, size: 22),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search stores...',
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: TextStyle(fontSize: 13, color: kDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (_, i) {
          final (label, emoji, bg) = _categories[i];
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Column(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(emoji, style: const TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kMid,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionHeader(String title, {bool showStar = false}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: kDark,
          ),
        ),
        if (showStar)
          const Padding(padding: EdgeInsets.only(left: 6), child: Text('✨')),
        const Spacer(),
        const Text(
          'See all',
          style: TextStyle(
            fontSize: 12,
            color: kBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedCards() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _recs.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 14),
          child: _RecCard(rec: _recs[i]),
        ),
      ),
    );
  }

  Widget _buildNearbyList() {
    return Column(children: _nearby.map((s) => _NearbyRow(store: s)).toList());
  }

  Widget _buildBottomNav() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        height: 70,
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: kDark.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(_navItems.length, (i) {
            final (filled, outline, label) = _navItems[i];
            final isSelected = _selectedTab == i;
            return Expanded(
              flex: isSelected ? 3 : 2,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedTab = i);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? kYellow : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected ? filled : outline,
                        color: isSelected ? Colors.white : kLight,
                        size: 22,
                      ),
                      if (isSelected)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              label,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _RecCard extends StatelessWidget {
  final StoreRec rec;
  const _RecCard({required this.rec});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    rec.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: rec.accent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 12,
                        color: kBlue,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          rec.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, color: kMid),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.map_outlined, size: 14, color: kBlue),
                      SizedBox(width: 4),
                      Text(
                        'Map',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: kBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 90,
            height: 140,
            decoration: BoxDecoration(
              color: rec.accent.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    rec.icon,
                    size: 40,
                    color: rec.accent.withValues(alpha: 0.2),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: kYellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      rec.discount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NearbyRow extends StatelessWidget {
  final NearbyStore store;
  const _NearbyRow({required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: store.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.store, color: store.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kDark,
                  ),
                ),
                Text(
                  '${store.floor} · ${store.distanceMeters}m',
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: kLight),
        ],
      ),
    );
  }
}