import 'package:flutter/material.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);
const kGreen = Color(0xFF55C08A);

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _activeCard = 0;

  static const _transactions = [
    _Transaction(store: 'ZARA', amount: -1299.00, date: 'Today, 2:34 PM', icon: Icons.checkroom_rounded, color: Color(0xFF1A1A1A), isCredit: false),
    _Transaction(store: 'Quest Reward', amount: 100.00, date: 'Today, 1:00 PM', icon: Icons.emoji_events_rounded, color: kGreen, isCredit: true),
    _Transaction(store: 'McDonald\'s', amount: -250.00, date: 'Yesterday, 12:15 PM', icon: Icons.fastfood_rounded, color: Color(0xFFDA291C), isCredit: false),
    _Transaction(store: 'SEPHORA', amount: -890.00, date: 'Yesterday, 11:00 AM', icon: Icons.face_retouching_natural, color: Color(0xFFB8003D), isCredit: false),
    _Transaction(store: 'Cashback Reward', amount: 50.00, date: 'Mar 23, 9:00 AM', icon: Icons.card_giftcard_rounded, color: kYellow, isCredit: true),
    _Transaction(store: 'NIKE', amount: -3500.00, date: 'Mar 22, 4:45 PM', icon: Icons.directions_run_rounded, color: Color(0xFF111111), isCredit: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    const Text(
                      'Wallet',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: kDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('💳', style: TextStyle(fontSize: 22)),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: kCard,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.more_horiz_rounded, color: kDark, size: 20),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 170,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.85),
                    onPageChanged: (i) => setState(() => _activeCard = i),
                    children: const [
                      _WalletCard(
                        gradient: [Color(0xFF4D96FF), Color(0xFF6AADFF)],
                        balance: '₱ 5,240.00',
                        points: '1,350 pts',
                        label: 'Mallie Card',
                        last4: '4820',
                      ),
                      _WalletCard(
                        gradient: [Color(0xFF1A2340), Color(0xFF2D3A5A)],
                        balance: '₱ 12,800.00',
                        points: '3,200 pts',
                        label: 'Premium Card',
                        last4: '9912',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _activeCard == i ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _activeCard == i ? kBlue : kLight,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                child: Row(
                  children: [
                    _QuickAction(icon: Icons.add_rounded, label: 'Top Up', color: kBlue),
                    const SizedBox(width: 12),
                    _QuickAction(icon: Icons.send_rounded, label: 'Transfer', color: kYellow),
                    const SizedBox(width: 12),
                    _QuickAction(icon: Icons.history_rounded, label: 'History', color: kGreen),
                    const SizedBox(width: 12),
                    _QuickAction(icon: Icons.card_giftcard_rounded, label: 'Redeem', color: const Color(0xFFFF6B9D)),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kYellow.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kYellow.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Text('⭐', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'You have 1,350 points!',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: kDark,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '150 more to unlock Gold Tier 🎁',
                              style: TextStyle(fontSize: 11, color: kMid),
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
                          'Redeem',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
                child: Row(
                  children: [
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: kDark,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: _TransactionRow(tx: _transactions[i]),
                ),
                childCount: _transactions.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  final List<Color> gradient;
  final String balance;
  final String points;
  final String label;
  final String last4;

  const _WalletCard({
    required this.gradient,
    required this.balance,
    required this.points,
    required this.label,
    required this.last4,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.wifi_rounded, color: Colors.white54, size: 20),
              ],
            ),
            const Spacer(),
            Text(
              balance,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  '⭐ $points',
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  '•••• $last4',
                  style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickAction({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Transaction {
  final String store;
  final double amount;
  final String date;
  final IconData icon;
  final Color color;
  final bool isCredit;

  const _Transaction({
    required this.store,
    required this.amount,
    required this.date,
    required this.icon,
    required this.color,
    required this.isCredit,
  });
}

class _TransactionRow extends StatelessWidget {
  final _Transaction tx;
  const _TransactionRow({required this.tx});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tx.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tx.icon, color: tx.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.store,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kDark,
                  ),
                ),
                Text(
                  tx.date,
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          Text(
            '${tx.isCredit ? '+' : '-'}₱ ${tx.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: tx.isCredit ? kGreen : kDark,
            ),
          ),
        ],
      ),
    );
  }
}