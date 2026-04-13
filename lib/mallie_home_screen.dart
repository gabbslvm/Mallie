import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth_screen.dart';
import 'mallie_map_page.dart';
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
const kGreen = Color(0xFF55C08A);

class MallieHomeScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  final List<String> selectedPreferences;

  const MallieHomeScreen({
    super.key,
    this.userName = '',
    this.userEmail = '',
    this.selectedPreferences = const [],
  });

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
      home: MallieHomePage(
        userName: userName,
        userEmail: userEmail,
        selectedPreferences: selectedPreferences,
      ),
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

class _StoreItem {
  final String name;
  final String category;
  final String floor;
  final String price;
  final double rating;
  final String discount;
  final IconData icon;
  final Color accent;
  final Color bg;

  const _StoreItem({
    required this.name,
    required this.category,
    required this.floor,
    required this.price,
    required this.rating,
    required this.discount,
    required this.icon,
    required this.accent,
    required this.bg,
  });
}

class MallieHomePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final List<String> selectedPreferences;

  const MallieHomePage({
    super.key,
    this.userName = '',
    this.userEmail = '',
    this.selectedPreferences = const [],
  });

  @override
  State<MallieHomePage> createState() => _MallieHomePageState();
}

class _MallieHomePageState extends State<MallieHomePage>
    with TickerProviderStateMixin {
  int _selectedTab = 0;
  int _selectedFilter = 0;
  String _searchQuery = '';
  List<String> _activeQuestStores = [];
  bool _notificationsEnabled = true;
  String? _profileHighlight;
  late final QuestPage _questPage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchCtrl = TextEditingController();

  late final AnimationController _floatCtrl;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _floatAnim;
  late final Animation<double> _pulseAnim;

  static const Map<String, String> _prefToCategory = {
    'Clothing': 'Fashion',
    'Footwear': 'Fashion',
    'Accessories': 'Fashion',
    'Jewelry': 'Fashion',
    'Eyewear': 'Fashion',
    'Home': 'Home',
    'Skincare': 'Beauty',
    'Barbershop & Salon': 'Beauty',
    'Electronics': 'Tech',
    'Groceries': 'Food',
    'Restaurants': 'Food',
    'Cafe': 'Food',
    'Pastries': 'Food',
    'Fast Food': 'Food',
    'Wellness': 'Wellness',
    'Spa & Relaxation': 'Wellness',
    'Cinema': 'Entertainment',
    'Arcade': 'Entertainment',
    'Books': 'Books',
    'Sports & Fitness': 'Sports',
    'Toys & Kids': 'Toys',
    'Pet Supplies': 'Pets',
  };

  static const _allCategories = [
    ('All', '🏪', Color(0xFFE8EFFE)),
    ('Fashion', '👗', Color(0xFFFCE8F0)),
    ('Food', '🍔', Color(0xFFFFF4E0)),
    ('Tech', '⌚', Color(0xFFE6F0FF)),
    ('Beauty', '💄', Color(0xFFF5E8FF)),
    ('Sports', '⚽', Color(0xFFE8FFF2)),
    ('Home', '🏠', Color(0xFFE8F4FF)),
    ('Wellness', '🧘', Color(0xFFE8FFEE)),
    ('Entertainment', '🎬', Color(0xFFF0E8FF)),
    ('Books', '📚', Color(0xFFFFF8E8)),
    ('Toys', '🧸', Color(0xFFFFF0E8)),
    ('Pets', '🐾', Color(0xFFFFECE8)),
  ];

  static const _stores = [
    // Fashion
    _StoreItem(
      name: 'ZARA',
      category: 'Fashion',
      floor: '2F · East Wing',
      price: '\$\$',
      rating: 4.5,
      discount: '20% OFF',
      icon: Icons.checkroom_rounded,
      accent: Color(0xFF1A1A1A),
      bg: Color(0xFFF5F5F5),
    ),
    _StoreItem(
      name: 'Uniqlo',
      category: 'Fashion',
      floor: '2F · West Wing',
      price: '\$',
      rating: 4.4,
      discount: '10% OFF',
      icon: Icons.dry_cleaning_rounded,
      accent: Color(0xFFCC0000),
      bg: Color(0xFFFFF5F5),
    ),
    // Food
    _StoreItem(
      name: "McDonald's",
      category: 'Food',
      floor: 'B1 · Food Court',
      price: '\$',
      rating: 4.2,
      discount: 'Buy 1 Get 1',
      icon: Icons.fastfood_rounded,
      accent: Color(0xFFDA291C),
      bg: Color(0xFFFFF3F3),
    ),
    _StoreItem(
      name: 'Jollibee',
      category: 'Food',
      floor: 'B1 · Food Court',
      price: '\$',
      rating: 4.5,
      discount: '₱50 OFF',
      icon: Icons.lunch_dining_rounded,
      accent: Color(0xFFE31837),
      bg: Color(0xFFFFF0F0),
    ),
    _StoreItem(
      name: 'Starbucks',
      category: 'Food',
      floor: '1F · Main Atrium',
      price: '\$\$\$',
      rating: 4.6,
      discount: 'Free Upsize',
      icon: Icons.local_cafe_rounded,
      accent: Color(0xFF00704A),
      bg: Color(0xFFEFFFF6),
    ),
    // Tech
    _StoreItem(
      name: 'Apple Store',
      category: 'Tech',
      floor: '3F · Tech Hub',
      price: '\$\$\$\$',
      rating: 4.9,
      discount: 'Free Setup',
      icon: Icons.laptop_mac_rounded,
      accent: Color(0xFF555555),
      bg: Color(0xFFF5F5F7),
    ),
    _StoreItem(
      name: 'Samsung',
      category: 'Tech',
      floor: '3F · Tech Hub',
      price: '\$\$\$',
      rating: 4.6,
      discount: '₱500 OFF',
      icon: Icons.smartphone_rounded,
      accent: Color(0xFF1428A0),
      bg: Color(0xFFEEF1FF),
    ),
    // Beauty
    _StoreItem(
      name: 'SEPHORA',
      category: 'Beauty',
      floor: '1F · Main Atrium',
      price: '\$\$\$',
      rating: 4.7,
      discount: '15% OFF',
      icon: Icons.face_retouching_natural,
      accent: Color(0xFFB8003D),
      bg: Color(0xFFFFF0F5),
    ),
    _StoreItem(
      name: "Watson's",
      category: 'Beauty',
      floor: '1F · West Wing',
      price: '\$',
      rating: 4.3,
      discount: 'Buy 2 Get 1',
      icon: Icons.spa_rounded,
      accent: Color(0xFF0066CC),
      bg: Color(0xFFEEF5FF),
    ),
    // Sports
    _StoreItem(
      name: 'NIKE',
      category: 'Sports',
      floor: '2F · East Wing',
      price: '\$\$',
      rating: 4.6,
      discount: '20% OFF',
      icon: Icons.directions_run_rounded,
      accent: Color(0xFF111111),
      bg: Color(0xFFF5F5F5),
    ),
    _StoreItem(
      name: 'Adidas',
      category: 'Sports',
      floor: '2F · East Wing',
      price: '\$\$',
      rating: 4.5,
      discount: '15% OFF',
      icon: Icons.sports_soccer_rounded,
      accent: Color(0xFF000000),
      bg: Color(0xFFF8F8F8),
    ),
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
    NearbyStore(name: 'EasyPC', floor: '3F', distanceMeters: 42, color: kBlue),
    NearbyStore(
      name: 'GadgetZone',
      floor: '3F',
      distanceMeters: 78,
      color: kYellow,
    ),
    NearbyStore(
      name: 'DataBlitz',
      floor: '4F',
      distanceMeters: 120,
      color: Color(0xFF55C08A),
    ),
  ];

  static const _navItems = [
    (Icons.home_rounded, Icons.home_outlined, 'Home'),
    (Icons.location_on_rounded, Icons.location_on_outlined, 'Map'),
    (Icons.emoji_events_rounded, Icons.emoji_events_outlined, 'Quest'),
    (Icons.credit_card_rounded, Icons.credit_card_outlined, 'Wallet'),
    (Icons.person_rounded, Icons.person_outlined, 'Profile'),
  ];

  List<Widget?> get _pages => [
    null,
    MapPage(
      activeQuestStores: _activeQuestStores,
      onQuestStart: (name) {
        setState(() {
          if (!_activeQuestStores.contains(name)) {
            _activeQuestStores.add(name);
          }
        });
      },
      onQuestCancel: (name) {
        setState(() => _activeQuestStores.remove(name));
      },
      onQuestDone: (name) {
        setState(() {
          _activeQuestStores.remove(name);
          _selectedTab = 2; // switch to Quest tab
        });
      },
    ),
    _questPage,
    const WalletPage(),
    ProfilePage(
      userName: widget.userName,
      userEmail: widget.userEmail,
      highlightItem: _profileHighlight,
    ),
  ];

  List<(String, String, Color)> get _visibleCategories {
    if (widget.selectedPreferences.isEmpty) return _allCategories;
    final mapped = widget.selectedPreferences
        .map((p) => _prefToCategory[p])
        .whereType<String>()
        .toSet();
    return [
      _allCategories[0],
      ..._allCategories.skip(1).where((c) => mapped.contains(c.$1)),
    ];
  }

  List<_StoreItem> get _filteredStores {
    final visible = _visibleCategories;
    final prefCats = widget.selectedPreferences.isEmpty
        ? null
        : visible.skip(1).map((c) => c.$1).toSet();

    final safeFilter = _selectedFilter < visible.length ? _selectedFilter : 0;
    final chipLabel = safeFilter == 0 ? null : visible[safeFilter].$1;

    return _stores.where((s) {
      final matchPref = prefCats == null || prefCats.contains(s.category);
      final matchChip = chipLabel == null || s.category == chipLabel;
      final matchSearch =
          _searchQuery.isEmpty ||
          s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchPref && matchChip && matchSearch;
    }).toList();
  }

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
    _questPage = QuestPage(
  onGoToMap: () => setState(() => _selectedTab = 1),
  onNavigateTo: (name) {
    setState(() {
      if (!_activeQuestStores.contains(name)) {
        _activeQuestStores.add(name);
      }
    });
  },
  onActiveStoresChanged: (stores) {
    setState(() => _activeQuestStores = List.from(stores));
  },
);
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _pulseCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _confirmLogout() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Log Out',
          style: TextStyle(fontWeight: FontWeight.w800, color: kDark),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: kMid),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: kMid, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Color(0xFFFF5555),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNavigateDialog(String storeName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.navigation_rounded, color: kBlue, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Navigate',
              style: TextStyle(fontWeight: FontWeight.w800, color: kDark),
            ),
          ],
        ),
        content: Text(
          'Start navigation to $storeName?',
          style: const TextStyle(color: kMid),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: kMid, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                if (!_activeQuestStores.contains(storeName)) {
                  _activeQuestStores.add(storeName);
                }
                _selectedTab = 1;
              });
            },
            child: const Text(
              'Navigate',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setLocal) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: kDark,
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Enable Notifications',
                  style: TextStyle(fontWeight: FontWeight.w700, color: kDark),
                ),
                subtitle: const Text(
                  'Quest updates, rewards, and promos',
                  style: TextStyle(fontSize: 11, color: kMid),
                ),
                value: _notificationsEnabled,
                activeThumbColor: kBlue,
                onChanged: (val) {
                  setLocal(() {});
                  setState(() => _notificationsEnabled = val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedTab != 0) {
      return Scaffold(
        backgroundColor: kBg,
        bottomNavigationBar: _buildBottomNav(),
        body: _pages[_selectedTab]!,
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
                          onSeeAll: () => setState(() {
                            _selectedFilter = 0;
                            _searchCtrl.clear();
                            _searchQuery = '';
                          }),
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
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: _buildNearbyList(),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                        child: _sectionHeader(
                          _buildStoresSectionTitle(),
                          subtitle:
                              '${_filteredStores.length} store${_filteredStores.length != 1 ? 's' : ''} available',
                          onSeeAll: _selectedFilter != 0
                              ? () => setState(() => _selectedFilter = 0)
                              : null,
                          seeAllLabel: _selectedFilter != 0 ? 'See all' : null,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                      sliver: _filteredStores.isEmpty
                          ? const SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Center(
                                  child: Text(
                                    'No stores found',
                                    style: TextStyle(color: kMid, fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          : SliverGrid(
                              delegate: SliverChildBuilderDelegate((_, i) {
                                final store = _filteredStores[i];
                                final isActive = _activeQuestStores.contains(
                                  store.name,
                                );
                                return _StoreCard(
                                  store: store,
                                  isActive: isActive,
                                  onNavigate: () =>
                                      _showNavigateDialog(store.name),
                                  onCancel: () => setState(
                                    () => _activeQuestStores.remove(store.name),
                                  ),
                                );
                              }, childCount: _filteredStores.length),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 14,
                                    crossAxisSpacing: 14,
                                    childAspectRatio: 0.82,
                                  ),
                            ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 110)),
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

  String _buildStoresSectionTitle() {
    if (_selectedFilter == 0) return 'All Stores';
    final visible = _visibleCategories;
    final safe = _selectedFilter < visible.length ? _selectedFilter : 0;
    return safe == 0 ? 'All Stores' : '${visible[safe].$1} Stores';
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF165CA1), kBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: DecorationImage(
                image: AssetImage('assets/MallieLogoMain.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.3, 1.0],
                ),
              ),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Welcome, Mallie here!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _selectedTab = 4;
                _profileHighlight = 'Help & Support';
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Account Settings'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _selectedTab = 4;
                _profileHighlight = null;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFFFF5555)),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFFFF5555),
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: _confirmLogout,
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
          GestureDetector(
            onTap: () => _openNotifications(context),
            child: _iconButton(
              child: const Icon(
                Icons.notifications_outlined,
                color: kDark,
                size: 20,
              ),
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
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search_rounded, color: kLight, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchCtrl,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: const InputDecoration(
                  hintText: 'Search stores...',
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 13, color: kDark),
              ),
            ),
            if (_searchQuery.isNotEmpty)
              GestureDetector(
                onTap: () => setState(() {
                  _searchCtrl.clear();
                  _searchQuery = '';
                }),
                child: const Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Icon(Icons.close_rounded, color: kLight, size: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final visible = _visibleCategories;
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: visible.length,
        itemBuilder: (_, i) {
          final (label, emoji, bg) = visible[i];
          final isSelected = _selectedFilter == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: isSelected ? kBlue : bg,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: kBlue.withValues(alpha: 0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(emoji, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: isSelected ? kBlue : kMid,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionHeader(
    String title, {
    bool showStar = false,
    String? subtitle,
    VoidCallback? onSeeAll,
    String? seeAllLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text('✨'),
              ),
            const Spacer(),
            if (onSeeAll != null)
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  seeAllLabel ?? 'Clear all',
                  style: const TextStyle(
                    fontSize: 12,
                    color: kBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: kMid)),
        ],
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: kBlue.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: kDark.withValues(alpha: 0.07),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Row(
            children: List.generate(_navItems.length, (i) {
              final (filled, outline, label) = _navItems[i];
              final isSelected = _selectedTab == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedTab = i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? kYellow : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: kYellow.withValues(alpha: 0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            isSelected ? filled : outline,
                            key: ValueKey(isSelected),
                            color: isSelected ? Colors.white : kBlue,
                            size: isSelected ? 22 : 20,
                          ),
                        ),
                        const SizedBox(height: 3),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: isSelected ? 10.5 : 10,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w500,
                            color: isSelected ? Colors.white : kBlue,
                            fontFamily: 'Nunito',
                          ),
                          child: Text(label),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
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

class _StoreCard extends StatelessWidget {
  final _StoreItem store;
  final bool isActive;
  final VoidCallback onNavigate;
  final VoidCallback onCancel;

  const _StoreCard({
    required this.store,
    required this.isActive,
    required this.onNavigate,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: store.bg,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      store.icon,
                      size: 52,
                      color: store.accent.withValues(alpha: 0.35),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: kYellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      store.discount,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Active indicator
                if (isActive)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: kGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: store.accent,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 11,
                      color: kBlue,
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        store.floor,
                        style: const TextStyle(fontSize: 10, color: kMid),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 13, color: kYellow),
                    const SizedBox(width: 3),
                    Text(
                      '${store.rating}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: kDark,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      store.price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Navigate / Cancel button
                GestureDetector(
                  onTap: isActive ? onCancel : onNavigate,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFFFF5555).withValues(alpha: 0.10)
                          : kBlue.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isActive
                            ? const Color(0xFFFF5555).withValues(alpha: 0.3)
                            : kBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isActive
                              ? Icons.close_rounded
                              : Icons.navigation_rounded,
                          size: 12,
                          color: isActive ? const Color(0xFFFF5555) : kBlue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isActive ? 'Cancel' : 'Navigate',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isActive ? const Color(0xFFFF5555) : kBlue,
                          ),
                        ),
                      ],
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