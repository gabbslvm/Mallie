import 'package:flutter/material.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);
const kGreen = Color(0xFF55C08A);

class QuestStore {
  final String name;
  final String category;
  final String floorCode;
  final String zone;
  final String reward;
  final IconData icon;
  final Color accent;

  const QuestStore({
    required this.name,
    required this.category,
    required this.floorCode,
    required this.zone,
    required this.reward,
    required this.icon,
    required this.accent,
  });
}

const questStores = <QuestStore>[
  QuestStore(
    name: "McDonald's",
    category: 'Food',
    floorCode: 'B1',
    zone: 'Food Court',
    reward: '+80 pts',
    icon: Icons.fastfood_rounded,
    accent: Color(0xFFDA291C),
  ),
  QuestStore(
    name: 'Jollibee',
    category: 'Food',
    floorCode: 'B1',
    zone: 'Food Court',
    reward: '+70 pts',
    icon: Icons.lunch_dining_rounded,
    accent: Color(0xFFE31837),
  ),
  QuestStore(
    name: 'Starbucks',
    category: 'Food',
    floorCode: '1F',
    zone: 'Main Atrium',
    reward: '+60 pts',
    icon: Icons.local_cafe_rounded,
    accent: Color(0xFF00704A),
  ),
  QuestStore(
    name: "Watson's",
    category: 'Beauty',
    floorCode: '1F',
    zone: 'West Wing',
    reward: '+80 pts',
    icon: Icons.spa_rounded,
    accent: Color(0xFF0066CC),
  ),
  QuestStore(
    name: 'SEPHORA',
    category: 'Beauty',
    floorCode: '1F',
    zone: 'Beauty Zone',
    reward: '+100 pts',
    icon: Icons.face_retouching_natural,
    accent: Color(0xFFB8003D),
  ),
  QuestStore(
    name: 'ZARA',
    category: 'Fashion',
    floorCode: '2F',
    zone: 'East Wing',
    reward: '+120 pts',
    icon: Icons.checkroom_rounded,
    accent: Color(0xFF1A1A1A),
  ),
  QuestStore(
    name: 'NIKE',
    category: 'Sports',
    floorCode: '2F',
    zone: 'East Wing',
    reward: '+100 pts',
    icon: Icons.directions_run_rounded,
    accent: Color(0xFF111111),
  ),
  QuestStore(
    name: 'Adidas',
    category: 'Sports',
    floorCode: '2F',
    zone: 'East Wing',
    reward: '+90 pts',
    icon: Icons.sports_soccer_rounded,
    accent: Color(0xFF000000),
  ),
  QuestStore(
    name: 'Uniqlo',
    category: 'Fashion',
    floorCode: '2F',
    zone: 'West Wing',
    reward: '+90 pts',
    icon: Icons.dry_cleaning_rounded,
    accent: Color(0xFFCC0000),
  ),
  QuestStore(
    name: 'Apple Store',
    category: 'Tech',
    floorCode: '3F',
    zone: 'Tech Hub',
    reward: '+150 pts',
    icon: Icons.laptop_mac_rounded,
    accent: Color(0xFF555555),
  ),
  QuestStore(
    name: 'Samsung',
    category: 'Tech',
    floorCode: '3F',
    zone: 'Tech Hub',
    reward: '+110 pts',
    icon: Icons.smartphone_rounded,
    accent: Color(0xFF1428A0),
  ),
    QuestStore(
    name: 'PowerHub',
    category: 'Tech',
    floorCode: '3F',
    zone: 'Tech Hub',
    reward: '+90 pts',
    icon: Icons.power_rounded,
    accent: kBlue,
  ),
];

class _Room {
  final Rect rect;
  final String zone;
  final Color fill;
  final Color accent;
  const _Room(this.rect, this.zone, this.fill, this.accent);
}

class _StoreNode {
  final String storeName;
  final Offset center;
  const _StoreNode(this.storeName, this.center);
}

class _Marker {
  final Offset center;
  final IconData icon;
  final String label;
  final Color color;
  const _Marker(this.center, this.icon, this.label, this.color);
}

const _kMapW = 360.0;
const _kMapH = 520.0;
const _kRoomRadius = 14.0;

// ── B1 ──
const _b1Rooms = <_Room>[
  _Room(Rect.fromLTWH(0, 0, 175, 215), 'Parking', Color(0xFFEDEEF4), kMid),
  _Room(Rect.fromLTWH(185, 0, 175, 215), 'Grocery', Color(0xFFEBFAF2), kGreen),
  _Room(
    Rect.fromLTWH(0, 240, 360, 280),
    'Food Court',
    Color(0xFFFFF3F3),
    Color(0xFFDA291C),
  ),
];
const _b1StoreNodes = <_StoreNode>[
  _StoreNode("McDonald's", Offset(120, 372)),
  _StoreNode('Jollibee', Offset(248, 372)),
];
const _b1Markers = <_Marker>[
  _Marker(Offset(86, 215), Icons.swap_vert_circle_outlined, 'Escalator', kMid),
  _Marker(Offset(274, 215), Icons.swap_vert_circle_outlined, 'Escalator', kMid),
  _Marker(Offset(180, 503), Icons.sensor_door_outlined, 'Entrance', kGreen),
];

// ── 1F ──
const _1fRooms = <_Room>[
  _Room(
    Rect.fromLTWH(0, 0, 105, 520),
    'West Wing',
    Color(0xFFF0F5FF),
    Color(0xFF0066CC),
  ),
  _Room(
    Rect.fromLTWH(120, 0, 120, 520),
    'Main Atrium',
    Color(0xFFE8F4FF),
    kBlue,
  ),
  _Room(
    Rect.fromLTWH(255, 0, 105, 520),
    'Beauty Zone',
    Color(0xFFFFF0F5),
    Color(0xFFB8003D),
  ),
];
const _1fStoreNodes = <_StoreNode>[
  _StoreNode("Watson's", Offset(52, 180)),
  _StoreNode('Starbucks', Offset(180, 260)),
  _StoreNode('SEPHORA', Offset(307, 340)),
];
const _1fMarkers = <_Marker>[
  _Marker(Offset(112, 260), Icons.swap_vert_circle_outlined, 'Escalator', kMid),
  _Marker(Offset(248, 260), Icons.swap_vert_circle_outlined, 'Escalator', kMid),
  _Marker(Offset(60, 503), Icons.sensor_door_outlined, 'Entrance', kGreen),
  _Marker(Offset(300, 503), Icons.sensor_door_outlined, 'Entrance', kGreen),
];

// ── 2F ──
const _2fRooms = <_Room>[
  _Room(
    Rect.fromLTWH(0, 0, 105, 520),
    'West Wing',
    Color(0xFFFFF5F5),
    Color(0xFFCC0000),
  ),
  _Room(
    Rect.fromLTWH(120, 160, 120, 200),
    'Center Court',
    Color(0xFFFFF8EC),
    kYellow,
  ),
  _Room(
    Rect.fromLTWH(255, 0, 105, 520),
    'East Wing',
    Color(0xFFF5F5F5),
    Color(0xFF1A1A1A),
  ),
];
const _2fStoreNodes = <_StoreNode>[
  _StoreNode('Uniqlo', Offset(52, 260)),
  _StoreNode('ZARA', Offset(307, 150)),
  _StoreNode('NIKE', Offset(307, 290)),
  _StoreNode('Adidas', Offset(307, 420)),
];
const _2fMarkers = <_Marker>[
  _Marker(Offset(112, 260), Icons.swap_vert_circle_outlined, 'Escalator', kMid),
  _Marker(Offset(248, 260), Icons.swap_vert_circle_outlined, 'Escalator', kMid),
  _Marker(Offset(52, 503), Icons.wc, 'WC', kMid),
  _Marker(Offset(308, 503), Icons.wc, 'WC', kMid),
];

// ── 3F ──
const _3fRooms = <_Room>[
  _Room(
    Rect.fromLTWH(0, 0, 230, 520),
    'Tech Hub',
    Color(0xFFF5F5F7),
    Color(0xFF555555),
  ),
  _Room(
    Rect.fromLTWH(245, 0, 115, 520),
    'Entertainment',
    Color(0xFFECF5FF),
    kBlue,
  ),
];
const _3fStoreNodes = <_StoreNode>[
  _StoreNode('Apple Store', Offset(115, 200)),
  _StoreNode('Samsung', Offset(115, 360)),
  _StoreNode('PowerHub', Offset(115, 460)),
];
const _3fMarkers = <_Marker>[
  _Marker(Offset(238, 260), Icons.swap_vert_circle_outlined, 'Escalator', kMid),
  _Marker(Offset(52, 503), Icons.wc, 'WC', kMid),
];

const _mapFloors = ['B1', '1F', '2F', '3F'];

final _floorRooms = <String, List<_Room>>{
  'B1': _b1Rooms,
  '1F': _1fRooms,
  '2F': _2fRooms,
  '3F': _3fRooms,
};

final _floorStoreNodes = <String, List<_StoreNode>>{
  'B1': _b1StoreNodes,
  '1F': _1fStoreNodes,
  '2F': _2fStoreNodes,
  '3F': _3fStoreNodes,
};

final _floorMarkers = <String, List<_Marker>>{
  'B1': _b1Markers,
  '1F': _1fMarkers,
  '2F': _2fMarkers,
  '3F': _3fMarkers,
};

const _storeRoutes = <String, List<Offset>>{
  "McDonald's": [
    Offset(180, 503),
    Offset(180, 440),
    Offset(120, 440),
    Offset(120, 372),
  ],
  'Jollibee': [
    Offset(180, 503),
    Offset(180, 440),
    Offset(248, 440),
    Offset(248, 372),
  ],
  "Watson's": [
    Offset(60, 503),
    Offset(60, 440),
    Offset(52, 440),
    Offset(52, 180),
  ],
  'Starbucks': [
    Offset(60, 503),
    Offset(60, 480),
    Offset(180, 480),
    Offset(180, 260),
  ],
  'SEPHORA': [
    Offset(60, 503),
    Offset(60, 480),
    Offset(248, 480),
    Offset(248, 340),
    Offset(307, 340),
  ],
  'Uniqlo': [
    Offset(180, 503),
    Offset(180, 480),
    Offset(112, 480),
    Offset(112, 260),
    Offset(52, 260),
  ],
  'ZARA': [
    Offset(180, 503),
    Offset(180, 480),
    Offset(248, 480),
    Offset(248, 150),
    Offset(307, 150),
  ],
  'NIKE': [
    Offset(180, 503),
    Offset(180, 480),
    Offset(248, 480),
    Offset(248, 290),
    Offset(307, 290),
  ],
  'Adidas': [
    Offset(180, 503),
    Offset(180, 480),
    Offset(248, 480),
    Offset(248, 420),
    Offset(307, 420),
  ],
  'Apple Store': [
    Offset(180, 503),
    Offset(180, 420),
    Offset(238, 420),
    Offset(238, 200),
    Offset(115, 200),
  ],
  'Samsung': [
    Offset(180, 503),
    Offset(180, 420),
    Offset(238, 420),
    Offset(238, 360),
    Offset(115, 360),
  ],
  'PowerHub': [
    Offset(180, 503),
    Offset(180, 420),
    Offset(238, 420),
    Offset(238, 460),
    Offset(115, 460),
  ],
};

class MapPage extends StatefulWidget {
  final List<String> activeQuestStores;
  final void Function(String storeName) onQuestStart;
  final void Function(String name)? onQuestCancel;
  final void Function(String name)? onQuestDone;

  const MapPage({
    super.key,
    this.activeQuestStores = const [],
    required this.onQuestStart,
    this.onQuestCancel,
    this.onQuestDone,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _selectedFloor = 'B1';

  @override
  void didUpdateWidget(MapPage old) {
    super.didUpdateWidget(old);
    if (widget.activeQuestStores != old.activeQuestStores &&
        widget.activeQuestStores.isNotEmpty) {
      try {
        final store = questStores.firstWhere(
          (s) => s.name == widget.activeQuestStores.first,
        );
        if (_mapFloors.contains(store.floorCode)) {
          setState(() => _selectedFloor = store.floorCode);
        }
      } catch (_) {}
    }
  }

  List<QuestStore> get _activeStores {
    return widget.activeQuestStores
        .map((name) {
          try {
            return questStores.firstWhere((s) => s.name == name);
          } catch (_) {
            return null;
          }
        })
        .whereType<QuestStore>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: _Mall2DMap(
                      key: ValueKey(_selectedFloor),
                      floorCode: _selectedFloor,
                      activeStoreNames: widget.activeQuestStores,
                      onStoreTap: widget.onQuestStart,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildQuestPanel(),
              ],
            ),
            Positioned(right: 10, top: 68, child: _buildFloatingSidebar()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 68, 0),
      child: Row(
        children: [
          const Text(
            'Mallie Map',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: kDark,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          if (widget.activeQuestStores.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.navigation_rounded, size: 14, color: kGreen),
                  const SizedBox(width: 4),
                  Text(
                    'Navigating (${widget.activeQuestStores.length})',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kGreen,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingSidebar() {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(-2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._mapFloors.map((floor) {
            final selected = _selectedFloor == floor;
            final hasActiveQuest = questStores.any(
              (s) =>
                  widget.activeQuestStores.contains(s.name) &&
                  s.floorCode == floor,
            );
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: GestureDetector(
                onTap: () => setState(() => _selectedFloor = floor),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: selected ? kBlue : kBg,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: kBlue.withValues(alpha: 0.38),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        floor,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: selected ? Colors.white : kMid,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (hasActiveQuest)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: kGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: 20,
              height: 1.5,
              decoration: BoxDecoration(
                color: kLight,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
          const _CompassWidget(),
        ],
      ),
    );
  }

  Widget _buildQuestPanel() {
    final stores = _activeStores;
    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: kLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
            child: Row(
              children: [
                Text(
                  stores.isNotEmpty
                      ? 'Active Quests (${stores.length})'
                      : 'No Active Quest',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: kDark,
                  ),
                ),
              ],
            ),
          ),
          if (stores.isEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 28),
              child: Text(
                'No quests are currently in progress.',
                style: TextStyle(fontSize: 13, color: kMid),
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                itemCount: stores.length,
                itemBuilder: (_, i) {
                  final store = stores[i];
                  return _QuestRow(
                    store: store,
                    isActive: true,
                    hasOtherActive: false,
                    onStart: () {},
                    onCancel: () => widget.onQuestCancel?.call(store.name),
                    onDone: () => _confirmDone(context, store),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

void _confirmDone(BuildContext context, QuestStore store) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: kGreen, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Quest Complete?',
              style: TextStyle(fontWeight: FontWeight.w800, color: kDark),
            ),
          ],
        ),
        content: Text(
          'Mark "${store.name}" as done?',
          style: const TextStyle(color: kMid),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Not yet',
              style: TextStyle(color: kMid, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              widget.onQuestCancel?.call(store.name);
              widget.onQuestDone?.call(store.name);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${store.name}" completed!'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: kGreen,
                ),
              );
            },
            child: const Text(
              'Done!',
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
}

class _Mall2DMap extends StatefulWidget {
  final String floorCode;
  final List<String> activeStoreNames;
  final void Function(String) onStoreTap;

  const _Mall2DMap({
    super.key,
    required this.floorCode,
    this.activeStoreNames = const [],
    required this.onStoreTap,
  });

  @override
  State<_Mall2DMap> createState() => _Mall2DMapState();
}

class _Mall2DMapState extends State<_Mall2DMap>
    with SingleTickerProviderStateMixin {
  late final AnimationController _routeCtrl;
  late final Animation<double> _routeProgress;

  List<List<Offset>> get _activeRoutes {
    return widget.activeStoreNames
        .where((name) {
          try {
            final store = questStores.firstWhere((s) => s.name == name);
            return store.floorCode == widget.floorCode;
          } catch (_) {
            return false;
          }
        })
        .map((name) => _storeRoutes[name] ?? <Offset>[])
        .where((r) => r.isNotEmpty)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _routeCtrl = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _routeProgress = CurvedAnimation(
      parent: _routeCtrl,
      curve: Curves.easeInOut,
    );
    if (_activeRoutes.isNotEmpty) _routeCtrl.forward();
  }

  @override
  void didUpdateWidget(_Mall2DMap old) {
    super.didUpdateWidget(old);
    final hadRoute = old.activeStoreNames.any(
      (name) => _routeForStore(name, old.floorCode) != null,
    );
    final hasRoute = _activeRoutes.isNotEmpty;
    if (!hadRoute && hasRoute) {
      _routeCtrl.forward(from: 0);
    } else if (hadRoute && !hasRoute) {
      _routeCtrl.reverse();
    }
  }

  List<Offset>? _routeForStore(String? name, String floor) {
    if (name == null) return null;
    try {
      final store = questStores.firstWhere((s) => s.name == name);
      if (store.floorCode != floor) return null;
    } catch (_) {
      return null;
    }
    return _storeRoutes[name];
  }

  @override
  void dispose() {
    _routeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = _floorRooms[widget.floorCode] ?? const <_Room>[];
    final nodes = _floorStoreNodes[widget.floorCode] ?? const <_StoreNode>[];
    final markers = _floorMarkers[widget.floorCode] ?? const <_Marker>[];
    final routes = _activeRoutes;

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDDE3F0),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 18,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.75,
              maxScale: 5.0,
              boundaryMargin: const EdgeInsets.all(60),
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: _kMapW,
                  height: _kMapH,
                  child: Stack(
                    children: [
                      Container(
                        width: _kMapW,
                        height: _kMapH,
                        color: const Color(0xFFD8DFEE),
                      ),
                      CustomPaint(
                        size: const Size(_kMapW, _kMapH),
                        painter: _RoomPainter(rooms),
                      ),
                      ...routes.map(
                        (route) => Positioned.fill(
                          child: AnimatedBuilder(
                            animation: _routeProgress,
                            builder: (_, _) => CustomPaint(
                              painter: _RoutePainter(
                                route,
                                _routeProgress.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (routes.isNotEmpty)
                        Positioned(
                          left: routes.first.first.dx - 16,
                          top: routes.first.first.dy - 16,
                          child: const _YouAreHereDot(),
                        ),
                      ...markers.map(_buildMarker),
                      ...nodes.map((n) {
                        final store = questStores.firstWhere(
                          (s) => s.name == n.storeName,
                          orElse: () => questStores.first,
                        );
                        return Positioned(
                          left: n.center.dx - 24,
                          top: n.center.dy - 24,
                          child: GestureDetector(
                            onTap: () => widget.onStoreTap(store.name),
                            child: _StorePin2D(
                              store: store,
                              isActive: widget.activeStoreNames.contains(
                                store.name,
                              ),
                            ),
                          ),
                        );
                      }),
                      CustomPaint(
                        size: const Size(_kMapW, _kMapH),
                        painter: _BorderPainter(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 14,
              bottom: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: kDark.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.floorCode,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 14,
              bottom: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.pinch_outlined, size: 13, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Pinch to zoom',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildMarker(_Marker m) {
    return Positioned(
      left: m.center.dx - 13,
      top: m.center.dy - 13,
      child: Tooltip(
        message: m.label,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.70),
            shape: BoxShape.circle,
          ),
          child: Icon(m.icon, size: 16, color: m.color.withValues(alpha: 0.70)),
        ),
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final List<Offset> waypoints;
  final double progress;

  const _RoutePainter(this.waypoints, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (waypoints.length < 2 || progress <= 0) return;

    final full = Path()..moveTo(waypoints[0].dx, waypoints[0].dy);
    for (int i = 1; i < waypoints.length; i++) {
      full.lineTo(waypoints[i].dx, waypoints[i].dy);
    }

    final metric = full.computeMetrics().first;
    final drawLen = metric.length * progress;
    final revealed = metric.extractPath(0, drawLen);

    canvas.drawPath(
      revealed,
      Paint()
        ..color = kBlue.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    _drawDashed(
      canvas,
      revealed,
      dashLen: 12,
      gapLen: 7,
      paint: Paint()
        ..color = kBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );

    _drawDashed(
      canvas,
      revealed,
      dashLen: 12,
      gapLen: 7,
      paint: Paint()
        ..color = Colors.white.withValues(alpha: 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );

    if (progress > 0.95) {
      final dest = waypoints.last;
      canvas.drawCircle(
        dest,
        7,
        Paint()..color = kBlue.withValues(alpha: 0.25),
      );
      canvas.drawCircle(dest, 4.5, Paint()..color = kBlue);
      canvas.drawCircle(dest, 2, Paint()..color = Colors.white);
    }
  }

  void _drawDashed(
    Canvas canvas,
    Path path, {
    required double dashLen,
    required double gapLen,
    required Paint paint,
  }) {
    for (final m in path.computeMetrics()) {
      double dist = 0;
      while (dist < m.length) {
        final end = (dist + dashLen).clamp(0.0, m.length);
        canvas.drawPath(m.extractPath(dist, end), paint);
        dist += dashLen + gapLen;
      }
    }
  }

  @override
  bool shouldRepaint(_RoutePainter old) =>
      old.progress != progress || old.waypoints != waypoints;
}

class _YouAreHereDot extends StatefulWidget {
  const _YouAreHereDot();

  @override
  State<_YouAreHereDot> createState() => _YouAreHereDotState();
}

class _YouAreHereDotState extends State<_YouAreHereDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _ring;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();
    _ring = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: AnimatedBuilder(
        animation: _ring,
        builder: (_, _) =>
            CustomPaint(painter: _YouAreHerePainter(_ring.value)),
      ),
    );
  }
}

class _YouAreHerePainter extends CustomPainter {
  final double pulse;
  const _YouAreHerePainter(this.pulse);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(
      center,
      8 + pulse * 8,
      Paint()
        ..color = kBlue.withValues(alpha: (1 - pulse) * 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      center,
      7.5,
      Paint()..color = kBlue.withValues(alpha: 0.20),
    );
    canvas.drawCircle(center, 5.5, Paint()..color = kBlue);
    canvas.drawCircle(center, 2.5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_YouAreHerePainter old) => old.pulse != pulse;
}

class _RoomPainter extends CustomPainter {
  final List<_Room> rooms;
  const _RoomPainter(this.rooms);

  @override
  void paint(Canvas canvas, Size size) {
    for (final room in rooms) {
      final rrect = RRect.fromRectAndRadius(
        room.rect.deflate(1.5),
        const Radius.circular(_kRoomRadius),
      );
      canvas.drawRRect(rrect, Paint()..color = room.fill);
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = Color.fromRGBO(
            room.accent.r.toInt(),
            room.accent.g.toInt(),
            room.accent.b.toInt(),
            0.20,
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
      (TextPainter(
        text: TextSpan(
          text: room.zone.toUpperCase(),
          style: TextStyle(
            fontSize: 8.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
            color: Color.fromRGBO(
              room.accent.r.toInt(),
              room.accent.g.toInt(),
              room.accent.b.toInt(),
              0.55,
            ),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: room.rect.width - 16)).paint(
        canvas,
        Offset(room.rect.left + 9, room.rect.top + 9),
      );
    }
  }

  @override
  bool shouldRepaint(_RoomPainter old) => old.rooms != rooms;
}

class _BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
        const Radius.circular(20),
      ),
      Paint()
        ..color = const Color(0xFFADB8CF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(_BorderPainter old) => false;
}

class _StorePin2D extends StatefulWidget {
  final QuestStore store;
  final bool isActive;

  const _StorePin2D({required this.store, required this.isActive});

  @override
  State<_StorePin2D> createState() => _StorePin2DState();
}

class _StorePin2DState extends State<_StorePin2D>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _pulse = Tween<double>(
      begin: 1.0,
      end: 1.10,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    if (widget.isActive) _ctrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_StorePin2D old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) {
      _ctrl.repeat(reverse: true);
    } else if (!widget.isActive && old.isActive) {
      _ctrl
        ..stop()
        ..reset();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.store;
    final active = widget.isActive;

    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, child) =>
          Transform.scale(scale: active ? _pulse.value : 1.0, child: child),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: active ? s.accent : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: active ? s.accent : s.accent.withValues(alpha: 0.45),
                width: active ? 2.5 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: s.accent.withValues(alpha: active ? 0.52 : 0.16),
                  blurRadius: active ? 20 : 6,
                  spreadRadius: active ? 3 : 0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              s.icon,
              size: 22,
              color: active ? Colors.white : s.accent,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: active ? s.accent : kDark.withValues(alpha: 0.70),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              s.name,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompassWidget extends StatelessWidget {
  const _CompassWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: CustomPaint(painter: _CompassPainter()),
    );
  }
}

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawPath(
      Path()
        ..moveTo(cx, cy - 12)
        ..lineTo(cx - 5, cy + 2)
        ..lineTo(cx, cy - 1)
        ..close(),
      Paint()..color = kBlue,
    );
    canvas.drawPath(
      Path()
        ..moveTo(cx, cy + 12)
        ..lineTo(cx + 5, cy - 2)
        ..lineTo(cx, cy + 1)
        ..close(),
      Paint()..color = kLight,
    );
    canvas.drawCircle(Offset(cx, cy), 2.5, Paint()..color = kDark);
    (TextPainter(
      text: const TextSpan(
        text: 'N',
        style: TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w900,
          color: kBlue,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout()).paint(canvas, Offset(cx - 3.5, cy - 21));
  }

  @override
  bool shouldRepaint(_CompassPainter old) => false;
}

class _QuestRow extends StatelessWidget {
  final QuestStore store;
  final bool isActive;
  final bool hasOtherActive;
  final VoidCallback onStart;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  const _QuestRow({
    required this.store,
    required this.isActive,
    required this.hasOtherActive,
    required this.onStart,
    required this.onCancel,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? kGreen.withValues(alpha: 0.08) : kBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isActive ? kGreen.withValues(alpha: 0.4) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: store.accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(store.icon, color: store.accent, size: 20),
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
                    fontWeight: FontWeight.w800,
                    color: kDark,
                  ),
                ),
                Text(
                  '${store.floorCode} · ${store.zone} · ${store.reward}',
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isActive)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: onDone,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: kGreen.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kGreen,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5555).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF5555),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else if (!hasOtherActive)
            GestureDetector(
              onTap: onStart,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: kBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Start',
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