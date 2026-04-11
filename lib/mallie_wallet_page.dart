import 'package:flutter/material.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);
const kGreen = Color(0xFF55C08A);

class WalletData {
  static double balance = 5240.00;
  static int points = 1350;
  static List<Transaction> transactions = [];
}

class Transaction {
  final String type;
  final String email;
  final double amount;
  final String date;
  final IconData icon;
  final Color color;
  final bool isCredit;

  const Transaction({
    required this.type,
    required this.email,
    required this.amount,
    required this.date,
    required this.icon,
    required this.color,
    required this.isCredit,
  });
}

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _activeCard = 0;

  void refresh() {
    if (mounted) setState(() {});
  }

  void openTopUp() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TopUpSheet(onDone: refresh),
    );
  }

  void openTransfer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TransferSheet(onDone: refresh),
    );
  }

  void redeem() {
    if (WalletData.points < 100) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Redeem Points"),
        content: Text(
          "Convert ${WalletData.points} pts to ₱${(WalletData.points / 100).toStringAsFixed(2)}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final double cash = WalletData.points / 100;
              WalletData.balance += cash;
              WalletData.transactions.insert(
                0,
                Transaction(
                  type: "Redeem",
                  email: "System",
                  amount: cash,
                  date: DateTime.now().toString(),
                  icon: Icons.card_giftcard_rounded,
                  color: kYellow,
                  isCredit: true,
                ),
              );
              WalletData.points = 0;
              Navigator.pop(dialogContext);
              if (mounted) setState(() {});
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  List<Transaction> get allTx => WalletData.transactions;

  static const _pointsToNextTier = 1500;

  @override
  Widget build(BuildContext context) {
    final int ptsToGold = (_pointsToNextTier - WalletData.points).clamp(0, _pointsToNextTier);

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
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
                    children: [
                      _WalletCard(
                        gradient: const [Color(0xFF4D96FF), Color(0xFF6AADFF)],
                        balance: '₱ ${WalletData.balance.toStringAsFixed(2)}',
                        points: '${WalletData.points} pts',
                        label: 'Mallie Card',
                        last4: '4820',
                      ),
                      const _WalletCard(
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
                    _QuickAction(icon: Icons.add_rounded,          label: 'Top Up',   color: kBlue,                    onTap: openTopUp),
                    const SizedBox(width: 12),
                    _QuickAction(icon: Icons.send_rounded,         label: 'Transfer', color: kYellow,                  onTap: openTransfer),
                    const SizedBox(width: 12),
                    _QuickAction(icon: Icons.history_rounded,      label: 'History',  color: kGreen,                   onTap: () {}),
                    const SizedBox(width: 12),
                    _QuickAction(icon: Icons.card_giftcard_rounded, label: 'Redeem',  color: const Color(0xFFFF6B9D), onTap: redeem),
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
                          children: [
                            Text(
                              'You have ${WalletData.points} points!',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: kDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              ptsToGold > 0
                                  ? '$ptsToGold more to unlock Gold Tier 🎁'
                                  : 'Gold Tier unlocked! 🎉',
                              style: const TextStyle(fontSize: 11, color: kMid),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: redeem,
                        child: Container(
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
                  children: const [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: kDark,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Spacer(),
                    Text(
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
                (_, i) {
                  if (allTx.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text("No transactions yet")),
                    );
                  }
                  final tx = allTx[i];
                  return GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(tx.type),
                        content: Text(
                          "From/To: ${tx.email}\nAmount: ₱${tx.amount.toStringAsFixed(2)}\nDate: ${tx.date}",
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                      child: TransactionRow(tx: tx),
                    ),
                  );
                },
                childCount: allTx.isEmpty ? 1 : allTx.length,
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
                  style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
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
                Text('⭐ $points', style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
                const Spacer(),
                Text('•••• $last4', style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.5)),
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
  final VoidCallback onTap;

  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionRow extends StatelessWidget {
  final Transaction tx;
  const TransactionRow({required this.tx});

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
                Text(tx.type, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: kDark)),
                Text(tx.email, style: const TextStyle(fontSize: 11, color: kMid)),
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

class TopUpSheet extends StatefulWidget {
  final VoidCallback onDone;
  const TopUpSheet({super.key, required this.onDone});

  @override
  State<TopUpSheet> createState() => _TopUpSheetState();
}

class _TopUpSheetState extends State<TopUpSheet> {
  final email = TextEditingController();
  final amount = TextEditingController();

  void submit() {
    final double amt = double.tryParse(amount.text) ?? 0;
    if (amt <= 0) return;
    WalletData.balance += amt;
    WalletData.transactions.insert(
      0,
      Transaction(
        type: "Top Up",
        email: email.text,
        amount: amt,
        date: DateTime.now().toString(),
        icon: Icons.add_rounded,
        color: kBlue,
        isCredit: true,
      ),
    );
    widget.onDone();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Top Up", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: kDark)),
          const SizedBox(height: 12),
          TextField(controller: email,  decoration: const InputDecoration(labelText: "Gmail")),
          TextField(controller: amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Amount")),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: submit, child: const Text("Confirm")),
        ],
      ),
    );
  }
}

class TransferSheet extends StatefulWidget {
  final VoidCallback onDone;
  const TransferSheet({super.key, required this.onDone});

  @override
  State<TransferSheet> createState() => _TransferSheetState();
}

class _TransferSheetState extends State<TransferSheet> {
  final email = TextEditingController();
  final amount = TextEditingController();

  void send() {
    final double amt = double.tryParse(amount.text) ?? 0;
    if (amt <= 0 || amt > WalletData.balance) return;
    WalletData.balance -= amt;
    WalletData.transactions.insert(
      0,
      Transaction(
        type: "Transfer",
        email: email.text,
        amount: amt,
        date: DateTime.now().toString(),
        icon: Icons.send_rounded,
        color: kYellow,
        isCredit: false,
      ),
    );
    widget.onDone();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Transfer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: kDark)),
          const SizedBox(height: 12),
          TextField(controller: email,  decoration: const InputDecoration(labelText: "Send To (Gmail)")),
          TextField(controller: amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Amount")),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: send, child: const Text("Send")),
        ],
      ),
    );
  }
}