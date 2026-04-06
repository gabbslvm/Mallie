import 'package:flutter/material.dart';
import 'auth_screen.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);
const kGreen = Color(0xFF55C08A);

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfilePage({
    super.key,
    this.userName = 'Mallie User',
    this.userEmail = 'user@email.com',
  });

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

  void _handleMenuTap(BuildContext context, String label) {
    if (label == 'Log Out') {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Row(
                    children: [
                      _headerIconBtn(Icons.notifications_outlined),
                      const SizedBox(width: 10),
                      _headerIconBtn(Icons.settings_outlined),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerIconBtn(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
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

  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
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
          Container(
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