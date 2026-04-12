import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_screen.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);
const kGreen = Color(0xFF55C08A);

class ProfilePage extends StatefulWidget {
  final String userName;
  final String userEmail;

  const ProfilePage({
    super.key,
    this.userName = 'Mallie User',
    this.userEmail = 'user@email.com',
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userName;
  late String userEmail;
  bool _notificationsEnabled = true;
  final List<String> _savedLocations = [
    'SM Mall of Asia',
    'Robinsons Galleria',
  ];

  @override
  void initState() {
    super.initState();
    userName = widget.userName;
    userEmail = widget.userEmail;
  }

  static const _badges = [
    ('🛍️', 'Shopaholic', Color(0xFFFCE8F0)),
    ('🗺️', 'Explorer', Color(0xFFE6F0FF)),
    ('⭐', 'Gold Member', Color(0xFFFFF4E0)),
    ('🏆', 'Quest King', Color(0xFFFFF4E0)),
  ];

  static const _activity = [
    (
      Icons.card_giftcard_rounded,
      'My Rewards',
      '3 Vouchers Available',
      kYellow,
    ),
    (
      Icons.check_circle_outline_rounded,
      'Quest History',
      '12 Quests Completed',
      kBlue,
    ),
    (
      Icons.emoji_events_rounded,
      'Achievements',
      '5 Badges Earned',
      Color(0xFFFF6B9D),
    ),
  ];

  static const _menuItems = [
    (Icons.person_outline_rounded, 'Edit Profile', kBlue),
    (Icons.location_on_outlined, 'Saved Locations', kYellow),
    (Icons.notifications_outlined, 'Notifications', Color(0xFFFF6B9D)),
    (Icons.lock_outline_rounded, 'Privacy & Security', kGreen),
    (Icons.help_outline_rounded, 'Help & Support', Color(0xFF9B59B6)),
    (Icons.star_outline_rounded, 'Rate Mallie', kYellow),
    (Icons.logout_rounded, 'Log Out', Color(0xFFFF5555)),
  ];

  void _openEditProfile(BuildContext context) {
    final nameCtrl = TextEditingController(text: userName);
    final emailCtrl = TextEditingController(text: userEmail);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: MediaQuery.of(
          context,
        ).viewInsets.add(const EdgeInsets.all(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: kDark,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  setState(() {
                    userName = nameCtrl.text.trim().isEmpty
                        ? userName
                        : nameCtrl.text.trim();
                    userEmail = emailCtrl.text.trim().isEmpty
                        ? userEmail
                        : emailCtrl.text.trim();
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  void _openRateMallie(BuildContext context) {
    int selected = 0;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Rate Mallie',
            style: TextStyle(fontWeight: FontWeight.w900, color: kDark),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'How was your experience?',
                style: TextStyle(color: kMid),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => GestureDetector(
                    onTap: () => setLocal(() => selected = i + 1),
                    child: Icon(
                      i < selected
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: kYellow,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: kMid)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: selected == 0
                  ? null
                  : () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Thanks for rating Mallie! ⭐',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          backgroundColor: kGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(BuildContext context, String label) {
    switch (label) {
      case 'Edit Profile':
        _openEditProfile(context);
        break;
      case 'Saved Locations':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _SavedLocationsPage(
              locations: _savedLocations,
              onUpdate: (updated) => setState(() {
                _savedLocations
                  ..clear()
                  ..addAll(updated);
              }),
            ),
          ),
        );
        break;
      case 'Notifications':
        _openNotifications(context);
        break;
      case 'Privacy & Security':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _PrivacyPage(
              onDeleteAccount: () async {
                final navigator = Navigator.of(context);
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('user_email');
                await prefs.remove('user_password');
                await prefs.remove('has_account');
                if (!mounted) return;
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                  (route) => false,
                );
              },
            ),
          ),
        );
        break;
      case 'Help & Support':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const _HelpPage()),
        );
        break;
      case 'Rate Mallie':
        _openRateMallie(context);
        break;
      case 'Log Out':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _buildProfileCard(),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Text(
                'Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: kDark,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                children: _activity
                    .map(
                      (a) => _ActivityCard(
                        icon: a.$1,
                        title: a.$2,
                        subtitle: a.$3,
                        color: a.$4,
                        onTap: () {
                          if (a.$2 == 'My Rewards') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const _RewardsPage(),
                              ),
                            );
                          } else if (a.$2 == 'Quest History') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const _QuestHistoryPage(),
                              ),
                            );
                          } else if (a.$2 == 'Achievements') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const _AchievementsPage(),
                              ),
                            );
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Text(
                'My Badges',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: kDark,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: SizedBox(
                height: 88,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: _badges
                      .map(
                        (b) => _BadgeTile(emoji: b.$1, label: b.$2, bg: b.$3),
                      )
                      .toList(),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Text(
                'Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: kDark,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: _menuItems.asMap().entries.map((e) {
                    final i = e.key;
                    final (icon, label, color) = e.value;
                    final isLast = i == _menuItems.length - 1;
                    final isLogout = label == 'Log Out';
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => _handleMenuTap(context, label),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(icon, color: color, size: 18),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isLogout
                                          ? const Color(0xFFFF5555)
                                          : kDark,
                                    ),
                                  ),
                                ),
                                if (!isLogout)
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: kLight,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            indent: 68,
                            endIndent: 16,
                            color: kLight.withValues(alpha: 0.35),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 130,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3A86FF), Color(0xFF6AADFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
          ),
        ),
        Positioned(
          top: -30,
          right: -20,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 60,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          left: -20,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: kYellow.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: kBlue.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kBlue.withValues(alpha: 0.1),
                  border: Border.all(
                    color: kBlue.withValues(alpha: 0.3),
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.person_rounded, size: 44, color: kBlue),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _openEditProfile(context),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: kYellow,
                      shape: BoxShape.circle,
                      border: Border.all(color: kCard, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      size: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Text(
            userName.isEmpty ? 'Mallie User' : userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: kDark,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userEmail.isEmpty ? 'user@email.com' : userEmail,
            style: const TextStyle(fontSize: 12, color: kMid),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kYellow, Color(0xFFFFD080)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: kYellow.withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              '⭐  Gold Member',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),

          const SizedBox(height: 20),
          Divider(height: 1, color: kLight.withValues(alpha: 0.4)),
          const SizedBox(height: 16),

          IntrinsicHeight(
            child: Row(
              children: [
                _StatItem(value: '1,350', label: 'Points', icon: '⭐'),
                VerticalDivider(width: 1, color: kLight.withValues(alpha: 0.5)),
                _StatItem(value: '12', label: 'Quests', icon: '🏆'),
                VerticalDivider(width: 1, color: kLight.withValues(alpha: 0.5)),
                _StatItem(value: '₱24k', label: 'Spent', icon: '💳'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: kDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: kBlue.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'View',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final String icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: kBlue,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: kMid)),
        ],
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final String emoji;
  final String label;
  final Color bg;

  const _BadgeTile({
    required this.emoji,
    required this.label,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kYellow.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: kMid,
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedLocationsPage extends StatefulWidget {
  final List<String> locations;
  final void Function(List<String>) onUpdate;

  const _SavedLocationsPage({required this.locations, required this.onUpdate});

  @override
  State<_SavedLocationsPage> createState() => _SavedLocationsPageState();
}

class _SavedLocationsPageState extends State<_SavedLocationsPage> {
  late List<String> _locations;
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _locations = List.from(widget.locations);
  }

  void _add() {
    final val = _ctrl.text.trim();
    if (val.isEmpty) return;
    setState(() => _locations.add(val));
    widget.onUpdate(_locations);
    _ctrl.clear();
  }

  void _remove(int i) {
    setState(() => _locations.removeAt(i));
    widget.onUpdate(_locations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text('Saved Locations'),
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      labelText: 'Add location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: _add,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _locations.isEmpty
                  ? const Center(
                      child: Text(
                        'No saved locations yet',
                        style: TextStyle(color: kMid),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _locations.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: kCard,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: kBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _locations[i],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kDark,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _remove(i),
                              child: const Icon(
                                Icons.close_rounded,
                                color: kMid,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivacyPage extends StatelessWidget {
  final VoidCallback onDeleteAccount;

  const _PrivacyPage({required this.onDeleteAccount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _infoTile(
            Icons.lock_outline_rounded,
            'Data Protection',
            'Your data is encrypted and never shared with third parties.',
            kBlue,
          ),
          _infoTile(
            Icons.visibility_off_outlined,
            'Profile Visibility',
            'Only you can see your personal information.',
            kGreen,
          ),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFF5555),
                  ),
                ),
                content: const Text(
                  'This will permanently delete your account and all associated data. This action cannot be undone.',
                  style: TextStyle(color: kMid),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: kMid,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5555),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      onDeleteAccount();
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            child: _infoTile(
              Icons.delete_outline_rounded,
              'Delete Account',
              'Permanently remove your account and all data.',
              const Color(0xFFFF5555),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpPage extends StatelessWidget {
  const _HelpPage();

  static const _faqs = [
    (
      'How do I top up my wallet?',
      'Go to the Wallet tab and tap Top Up. Enter your Gmail and amount to proceed.',
    ),
    (
      'How do I earn points?',
      'You earn points by completing quests and making purchases in partner stores.',
    ),
    (
      'How do I redeem my points?',
      'Go to Wallet and tap Redeem. Points convert to wallet balance at ₱1 per 100 pts.',
    ),
    (
      'How do I report an issue?',
      'Use the feedback form below or email us at support@mallie.app',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'FAQs',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: kDark,
            ),
          ),
          const SizedBox(height: 12),
          ..._faqs.map(
            (f) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ExpansionTile(
                title: Text(
                  f.$1,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kDark,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    child: Text(
                      f.$2,
                      style: const TextStyle(fontSize: 12, color: kMid),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardsPage extends StatelessWidget {
  const _RewardsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text('My Rewards'),
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _voucherTile(
            '₱50 Off',
            'Valid at any partner store',
            'Expires Apr 30',
          ),
          _voucherTile('Free Delivery', 'Min. spend ₱500', 'Expires May 15'),
          _voucherTile('10% Cashback', 'On food purchases', 'Expires May 1'),
        ],
      ),
    );
  }

  Widget _voucherTile(String title, String subtitle, String expiry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kYellow.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kYellow.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.card_giftcard_rounded, color: kYellow),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kDark,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
                Text(
                  expiry,
                  style: const TextStyle(
                    fontSize: 10,
                    color: kYellow,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kYellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Use',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestHistoryPage extends StatelessWidget {
  const _QuestHistoryPage();

  static const _quests = [
    ('Visit 3 Stores', 'Completed Mar 20', '+150 pts'),
    ('Spend ₱1,000', 'Completed Mar 18', '+200 pts'),
    ('Try a New Restaurant', 'Completed Mar 15', '+100 pts'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text('Quest History'),
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _quests.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final q = _quests[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: kBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_rounded, color: kBlue),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        q.$1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: kDark,
                        ),
                      ),
                      Text(
                        q.$2,
                        style: const TextStyle(fontSize: 11, color: kMid),
                      ),
                    ],
                  ),
                ),
                Text(
                  q.$3,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kGreen,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AchievementsPage extends StatelessWidget {
  const _AchievementsPage();

  static const _achievements = [
    ('🛍️', 'Shopaholic', 'Visited 10+ stores'),
    ('🗺️', 'Explorer', 'Explored 5 malls'),
    ('⭐', 'Gold Member', 'Reached Gold Tier'),
    ('🏆', 'Quest King', 'Completed 10 quests'),
    ('💳', 'Big Spender', 'Spent ₱10,000+'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
        children: _achievements
            .map(
              (a) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(a.$1, style: const TextStyle(fontSize: 32)),
                    const SizedBox(height: 8),
                    Text(
                      a.$2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: kDark,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      a.$3,
                      style: const TextStyle(fontSize: 10, color: kMid),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}