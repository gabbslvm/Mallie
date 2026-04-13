import 'package:flutter/material.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);
const kGreen = Color(0xFF55C08A);
const kRed = Color(0xFFFF5555);

/* ═══════════════════════════════════════════════════════════════
   QUEST STOP MODEL
═══════════════════════════════════════════════════════════════ */

class QuestStop {
  int number;
  String name;
  String floor;
  bool done;
  final Color color;

  QuestStop({
    required this.number,
    required this.name,
    required this.floor,
    required this.done,
    required this.color,
  });
}

/* ═══════════════════════════════════════════════════════════════
   MALL DESTINATIONS (text-based, for add destination picker)
═══════════════════════════════════════════════════════════════ */

class _MallDestination {
  final String name;
  final String floor;
  final String zone;
  final Color accent;
  final IconData icon;

  const _MallDestination({
    required this.name,
    required this.floor,
    required this.zone,
    required this.accent,
    required this.icon,
  });
}

const _mallDestinations = <_MallDestination>[
  _MallDestination(name: "McDonald's",  floor: 'B1', zone: 'Food Court',   accent: Color(0xFFDA291C), icon: Icons.fastfood_rounded),
  _MallDestination(name: 'Jollibee',    floor: 'B1', zone: 'Food Court',   accent: Color(0xFFE31837), icon: Icons.lunch_dining_rounded),
  _MallDestination(name: 'Starbucks',   floor: '1F', zone: 'Main Atrium',  accent: Color(0xFF00704A), icon: Icons.local_cafe_rounded),
  _MallDestination(name: "Watson's",    floor: '1F', zone: 'West Wing',    accent: Color(0xFF0066CC), icon: Icons.spa_rounded),
  _MallDestination(name: 'SEPHORA',     floor: '1F', zone: 'Beauty Zone',  accent: Color(0xFFB8003D), icon: Icons.face_retouching_natural),
  _MallDestination(name: 'ZARA',        floor: '2F', zone: 'East Wing',    accent: Color(0xFF1A1A1A), icon: Icons.checkroom_rounded),
  _MallDestination(name: 'NIKE',        floor: '2F', zone: 'East Wing',    accent: Color(0xFF111111), icon: Icons.directions_run_rounded),
  _MallDestination(name: 'Adidas',      floor: '2F', zone: 'East Wing',    accent: Color(0xFF000000), icon: Icons.sports_soccer_rounded),
  _MallDestination(name: 'Uniqlo',      floor: '2F', zone: 'West Wing',    accent: Color(0xFFCC0000), icon: Icons.dry_cleaning_rounded),
  _MallDestination(name: 'Apple Store', floor: '3F', zone: 'Tech Hub',     accent: Color(0xFF555555), icon: Icons.laptop_mac_rounded),
  _MallDestination(name: 'Samsung',     floor: '3F', zone: 'Tech Hub',     accent: Color(0xFF1428A0), icon: Icons.smartphone_rounded),
  _MallDestination(name: 'PowerHub',    floor: '3F', zone: 'Tech Hub',     accent: kBlue,             icon: Icons.power_rounded),
];

/* ═══════════════════════════════════════════════════════════════
   QUEST PAGE
═══════════════════════════════════════════════════════════════ */

class QuestPage extends StatefulWidget {
  final VoidCallback? onGoToMap;
  final void Function(String storeName)? onNavigateTo;
  final void Function(List<String> activeNames)? onActiveStoresChanged;
  final List<String> externalDoneQuests;
  const QuestPage({super.key, this.onGoToMap, this.onNavigateTo, this.onActiveStoresChanged, this.externalDoneQuests = const [],});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _trophyCtrl;
  late Animation<double> _trophyAnim;

  final List<QuestStop> _stops = [
    QuestStop(number: 1, name: 'ZARA',        floor: '2F · East Wing',    done: true,  color: Color(0xFF1A1A1A)),
    QuestStop(number: 2, name: 'SEPHORA',     floor: '1F · Main Atrium',  done: true,  color: Color(0xFFB8003D)),
    QuestStop(number: 3, name: "McDonald's",  floor: 'B1 · Food Court',   done: true,  color: Color(0xFFDA291C)),
    QuestStop(number: 4, name: 'PowerHub',    floor: '3F · Tech Hub',     done: false, color: kBlue),
    QuestStop(number: 5, name: 'NIKE',        floor: '2F · East Wing',    done: false, color: Color(0xFF111111)),
  ];

  int get _completedCount => _stops.where((s) => s.done).length;
  double get _progress => _stops.isEmpty ? 0 : _completedCount / _stops.length;

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
    _syncFromExternal();
  }

@override
  void didUpdateWidget(QuestPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.externalDoneQuests != oldWidget.externalDoneQuests) {
      _syncFromExternal();
    }
  }

  void _syncFromExternal() {
    bool changed = false;
    for (var name in widget.externalDoneQuests) {
      for (var stop in _stops) {
        if (stop.name == name && !stop.done) {
          stop.done = true;
          changed = true;
        }
      }
    }
    if (changed) setState(() {});
  }
  @override
  void dispose() {
    _trophyCtrl.dispose();
    super.dispose();
  }

  /* ── RENUMBER stops after mutation ── */
  void _renumber() {
    for (int i = 0; i < _stops.length; i++) {
      _stops[i].number = i + 1;
    }
  }

  /* ── TOGGLE done ── */
   void _toggleDone(QuestStop stop) {
    setState(() => stop.done = !stop.done);
    _syncActiveStores();
  }

  void _syncActiveStores() {
    final activeNames = _stops
        .where((s) => !s.done)
        .map((s) => s.name)
        .toList();
    widget.onActiveStoresChanged?.call(activeNames);
  }

  /* ── REMOVE stop ── */
  void _removeStop(QuestStop stop) {
    showDialog(
      context: context,
      builder: (ctx) => _MallieDialog(
        icon: Icons.delete_outline_rounded,
        iconColor: kRed,
        title: 'Remove Stop?',
        message: 'Remove "${stop.name}" from your quest?',
        confirmLabel: 'Remove',
        confirmColor: kRed,
        onConfirm: () {
          Navigator.pop(ctx);
          setState(() => _stops.remove(stop));
          _renumber();
        },
        onCancel: () => Navigator.pop(ctx),
      ),
    );
  }

  /* ── ADD destination picker ── */
  void _showAddDestination() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddDestinationSheet(
        existingNames: _stops.map((s) => s.name).toList(),
        onSelect: (dest) {
          Navigator.pop(context);
          _confirmAddDestination(dest);
        },
        onDismiss: () {
          Navigator.pop(context);
          _promptGoToMap();
        },
      ),
    );
  }

  void _confirmAddDestination(_MallDestination dest) {
    showDialog(
      context: context,
      builder: (ctx) => _MallieDialog(
        icon: Icons.add_location_alt_rounded,
        iconColor: kBlue,
        title: 'Add Destination?',
        message: 'Add "${dest.name}" (${dest.floor} · ${dest.zone}) to your quest?',
        confirmLabel: 'Add Stop',
        confirmColor: kBlue,
        onConfirm: () {
          Navigator.pop(ctx);
          setState(() {
            _stops.add(QuestStop(
              number: _stops.length + 1,
              name: dest.name,
              floor: '${dest.floor} · ${dest.zone}',
              done: false,
              color: dest.accent,
            ));
          });
        },
        onCancel: () => Navigator.pop(ctx),
      ),
    );
  }

  void _promptGoToMap() {
    showDialog(
      context: context,
      builder: (ctx) => _MallieDialog(
        icon: Icons.map_rounded,
        iconColor: kBlue,
        title: 'Go to Map?',
        message: 'Want to head back to the map and continue your journey?',
        confirmLabel: 'Go to Map',
        confirmColor: kBlue,
        onConfirm: () {
          Navigator.pop(ctx);
          widget.onGoToMap?.call();
        },
        onCancel: () => Navigator.pop(ctx),
        cancelLabel: 'Stay Here',
      ),
    );
  }

void _confirmGoToStore(QuestStop stop) {
  showDialog(
    context: context,
    builder: (ctx) => _MallieDialog(
      icon: Icons.near_me_rounded,
      iconColor: kBlue,
      title: 'Navigate to ${stop.name}?',
      message: 'Go to the map and navigate to ${stop.name} (${stop.floor})?',
      confirmLabel: 'Go',
      confirmColor: kBlue,
      onConfirm: () {
        Navigator.pop(ctx);
        widget.onNavigateTo?.call(stop.name);
        _syncActiveStores();
        widget.onGoToMap?.call();
      },
      onCancel: () => Navigator.pop(ctx),
    ),
  );
}

  /* ══════════════════════════════════════════════════════════════
     BUILD
  ══════════════════════════════════════════════════════════════ */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            /* ── Header ── */
            SliverToBoxAdapter(child: _buildHeader()),

            /* ── Progress Card ── */
            SliverToBoxAdapter(child: _buildProgressCard()),

            /* ── Section label: Quest Stops ── */
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
                child: Row(
                  children: [
                    const Text(
                      'Quest Stops',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: kDark,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: kBlue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_stops.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: kBlue,
                        ),
                      ),
                    ),
                    const Spacer(),
                    /* Add destination button */
                    GestureDetector(
                      onTap: _showAddDestination,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: kBlue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: kBlue.withValues(alpha: 0.30),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_rounded, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Add Stop',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /* ── Quest Stop Rows (mutable) ── */
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: _QuestStopCard(
                    stop: _stops[i],
                    onToggleDone: () => _toggleDone(_stops[i]),
                    onRemove: () => _removeStop(_stops[i]),
                    onNavigate: () => _confirmGoToStore(_stops[i]),
                  ),
                ),
                childCount: _stops.length,
              ),
            ),

            /* ── Continue Quest / Go to Map button ── */
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
                child: GestureDetector(
                  onTap: () => widget.onGoToMap?.call(),
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
                        Icon(Icons.map_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Continue on Map',
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

  /* ── Header ── */
  Widget _buildHeader() {
    return Padding(
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
    );
  }

  /* ── Progress Card ── */
  Widget _buildProgressCard() {
    return Padding(
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
                    '$_completedCount/${_stops.length} stops',
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
    );
  }
}

/* ═══════════════════════════════════════════════════════════════
   QUEST STOP CARD  (mutable: toggle done, remove, navigate)
═══════════════════════════════════════════════════════════════ */

class _QuestStopCard extends StatelessWidget {
  final QuestStop stop;
  final VoidCallback onToggleDone;
  final VoidCallback onRemove;
  final VoidCallback onNavigate;

  const _QuestStopCard({
    required this.stop,
    required this.onToggleDone,
    required this.onRemove,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: stop.done ? kBg : kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: stop.done
              ? kGreen.withValues(alpha: 0.25)
              : Colors.transparent,
        ),
        boxShadow: stop.done
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        children: [
          /* Number / done indicator — tap to toggle */
          GestureDetector(
            onTap: onToggleDone,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: stop.done
                    ? kGreen.withValues(alpha: 0.12)
                    : stop.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: stop.done
                    ? const Icon(Icons.check_circle_rounded,
                        color: kGreen, size: 20)
                    : Text(
                        '${stop.number}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: stop.color,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          /* Name + floor */
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
                    decoration:
                        stop.done ? TextDecoration.lineThrough : null,
                    decorationColor: kMid,
                  ),
                ),
                Text(
                  stop.floor,
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          /* Action buttons */
          if (!stop.done) ...[
            /* Navigate */
            _ActionBtn(
              label: 'Go',
              icon: Icons.near_me_rounded,
              color: kBlue,
              onTap: onNavigate,
            ),
            const SizedBox(width: 6),
          ],

          /* Mark done / undo */
          _ActionBtn(
            label: stop.done ? 'Undo' : 'Done',
            icon: stop.done
                ? Icons.undo_rounded
                : Icons.check_rounded,
            color: stop.done ? kMid : kGreen,
            onTap: onToggleDone,
          ),
          const SizedBox(width: 6),

          /* Remove */
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: kRed.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                size: 16,
                color: kRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ═══════════════════════════════════════════════════════════════
   MINI MAP MARKER  (only for remaining / pending stops)
═══════════════════════════════════════════════════════════════ */

/* ═══════════════════════════════════════════════════════════════
   ADD DESTINATION BOTTOM SHEET
═══════════════════════════════════════════════════════════════ */

class _AddDestinationSheet extends StatelessWidget {
  final List<String> existingNames;
  final void Function(_MallDestination) onSelect;
  final VoidCallback onDismiss;

  const _AddDestinationSheet({
    required this.existingNames,
    required this.onSelect,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final available = _mallDestinations
        .where((d) => !existingNames.contains(d.name))
        .toList();

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 24),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /* Handle */
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: kLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          /* Title row */
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
            child: Row(
              children: [
                const Text(
                  'Add Destination',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: kDark,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onDismiss,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: kBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.close_rounded,
                        size: 16, color: kMid),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              'Select a store to add to your quest.',
              style: TextStyle(fontSize: 12, color: kMid),
            ),
          ),
          /* Store list */
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.42,
            ),
            child: available.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'All available stores are already in your quest!',
                      style: TextStyle(fontSize: 13, color: kMid),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: available.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final dest = available[i];
                      return GestureDetector(
                        onTap: () => onSelect(dest),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: kBg,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: dest.accent.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(dest.icon,
                                    color: dest.accent, size: 18),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dest.name,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: kDark,
                                      ),
                                    ),
                                    Text(
                                      '${dest.floor} · ${dest.zone}',
                                      style: const TextStyle(
                                          fontSize: 11, color: kMid),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.add_circle_outline_rounded,
                                  size: 18, color: kBlue),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/* ═══════════════════════════════════════════════════════════════
   REUSABLE MALLIE DIALOG
═══════════════════════════════════════════════════════════════ */

class _MallieDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String confirmLabel;
  final Color confirmColor;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _MallieDialog({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.confirmColor,
    required this.onConfirm,
    required this.onCancel,
    this.cancelLabel = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      backgroundColor: kCard,
      title: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kDark,
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 13, color: kMid),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            cancelLabel,
            style: const TextStyle(
                color: kMid, fontWeight: FontWeight.w600),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          onPressed: onConfirm,
          child: Text(
            confirmLabel,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}