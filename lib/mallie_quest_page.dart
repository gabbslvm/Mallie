import 'package:flutter/material.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);
const kGreen = Color(0xFF55C08A);

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> with SingleTickerProviderStateMixin {
  late AnimationController _trophyCtrl;
  late Animation<double> _trophyAnim;

  static const _questStops = [
    _QuestStop(number: 1, name: 'ZARA', floor: '2F · East Wing', done: true, color: Color(0xFF1A1A1A)),
    _QuestStop(number: 2, name: 'SEPHORA', floor: '1F · Main Atrium', done: true, color: Color(0xFFB8003D)),
    _QuestStop(number: 3, name: 'McDonald\'s', floor: 'B1 · Food Court', done: true, color: Color(0xFFDA291C)),
    _QuestStop(number: 4, name: 'PowerHub', floor: '3F · Tech Hub', done: false, color: kBlue),
    _QuestStop(number: 5, name: 'NIKE', floor: '2F · East Wing', done: false, color: Color(0xFF111111)),
  ];

  int get _completedCount => _questStops.where((s) => s.done).length;
  double get _progress => _completedCount / _questStops.length;

  @override
  void initState() {
    super.initState();
    _trophyCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _trophyAnim = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _trophyCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _trophyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Shopping Quest',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: kDark,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Complete all stops to earn rewards!',
                          style: TextStyle(fontSize: 12, color: kMid),
                        ),
                      ],
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _trophyAnim,
                      builder: (_, child) => Transform.translate(
                        offset: Offset(0, _trophyAnim.value),
                        child: child,
                      ),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: kYellow.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text('🏆', style: TextStyle(fontSize: 26)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Progress card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kBlue, Color(0xFF6AADFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: kBlue.withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Current Quest',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$_completedCount/${_questStops.length} stops',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Mall Explorer Challenge',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progress,
                          minHeight: 10,
                          backgroundColor: Colors.white.withValues(alpha: 0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(kYellow),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            '🎁  Reward: +100 Points',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${(_progress * 100).round()}% done',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Map placeholder
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Simulated map grid
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CustomPaint(
                          size: const Size(double.infinity, 180),
                          painter: _MapGridPainter(),
                        ),
                      ),
                      // Stop markers
                      ..._questStops.asMap().entries.map((e) {
                        final positions = [
                          const Offset(0.25, 0.3),
                          const Offset(0.45, 0.2),
                          const Offset(0.35, 0.55),
                          const Offset(0.6, 0.65),
                          const Offset(0.75, 0.4),
                        ];
                        final stop = e.value;
                        final pos = positions[e.key];
                        return Positioned.fill(
                          child: Align(
                            alignment: Alignment(pos.dx * 2 - 1, pos.dy * 2 - 1),
                            child: _MapMarker(stop: stop),
                          ),
                        );
                      }),
                      // Legend
                      Positioned(
                        bottom: 12,
                        left: 14,
                        child: Row(
                          children: [
                            _legendDot(kGreen),
                            const SizedBox(width: 4),
                            const Text('Affordable', style: TextStyle(fontSize: 10, color: kMid)),
                            const SizedBox(width: 10),
                            _legendDot(kYellow),
                            const SizedBox(width: 4),
                            const Text('\$\$\$ Premium', style: TextStyle(fontSize: 10, color: kMid)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Quest stops list
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
                child: const Text(
                  'Quest Stops',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kDark,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: _QuestStopRow(stop: _questStops[i]),
                ),
                childCount: _questStops.length,
              ),
            ),

            // Start button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: kBlue,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: kBlue.withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'Continue Quest',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendDot(Color color) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

class _QuestStop {
  final int number;
  final String name;
  final String floor;
  final bool done;
  final Color color;

  const _QuestStop({
    required this.number,
    required this.name,
    required this.floor,
    required this.done,
    required this.color,
  });
}

class _MapMarker extends StatelessWidget {
  final _QuestStop stop;
  const _MapMarker({required this.stop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: stop.done ? kGreen : kBlue,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: (stop.done ? kGreen : kBlue).withValues(alpha: 0.4),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: stop.done
            ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
            : Text(
                '${stop.number}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

class _QuestStopRow extends StatelessWidget {
  final _QuestStop stop;
  const _QuestStopRow({required this.stop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: stop.done ? kGreen.withValues(alpha: 0.12) : kBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: stop.done
                  ? const Icon(Icons.check_circle_rounded, color: kGreen, size: 20)
                  : Text(
                      '${stop.number}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: kBlue,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stop.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: stop.done ? kMid : kDark,
                    decoration: stop.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  stop.floor,
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          if (!stop.done)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: kBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Go →',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: kBlue,
                ),
              ),
            )
          else
            const Icon(Icons.check_circle_rounded, color: kGreen, size: 20),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE8EFF8)
      ..strokeWidth = 1;

    // Horizontal lines
    for (int i = 1; i < 6; i++) {
      final y = size.height * i / 6;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical lines
    for (int i = 1; i < 8; i++) {
      final x = size.width * i / 8;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw some "blocks" to simulate mall map
    final blockPaint = Paint()..color = const Color(0xFFD8E6F5);
    final blocks = [
      Rect.fromLTWH(size.width * 0.08, size.height * 0.12, size.width * 0.28, size.height * 0.32),
      Rect.fromLTWH(size.width * 0.42, size.height * 0.08, size.width * 0.22, size.height * 0.25),
      Rect.fromLTWH(size.width * 0.68, size.height * 0.15, size.width * 0.24, size.height * 0.35),
      Rect.fromLTWH(size.width * 0.1, size.height * 0.58, size.width * 0.35, size.height * 0.28),
      Rect.fromLTWH(size.width * 0.52, size.height * 0.52, size.width * 0.3, size.height * 0.3),
    ];
    for (final block in blocks) {
      canvas.drawRRect(RRect.fromRectAndRadius(block, const Radius.circular(6)), blockPaint);
    }

    // Path lines
    final pathPaint = Paint()
      ..color = const Color(0xFF4D96FF).withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(size.width * 0.25, size.height * 0.3)
      ..lineTo(size.width * 0.45, size.height * 0.2)
      ..lineTo(size.width * 0.35, size.height * 0.55)
      ..lineTo(size.width * 0.6, size.height * 0.65)
      ..lineTo(size.width * 0.75, size.height * 0.4);
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
