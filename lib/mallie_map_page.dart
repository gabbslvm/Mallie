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
    name: 'SEPHORA',
    category: 'Beauty',
    floorCode: '1F',
    zone: 'Main Atrium',
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
];

/* ─── MAP PAGE ────────────────────────────────────────────────── */
class MapPage extends StatefulWidget {
  final String? activeQuestStore;
  final void Function(String storeName) onQuestStart;
  final VoidCallback onQuestCancel;

  const MapPage({
    super.key,
    this.activeQuestStore,
    required this.onQuestStart,
    required this.onQuestCancel,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late String _selectedFloor;
  static const _floors = ['B1', '1F', '2F', '3F'];

  QuestStore? get _activeStore {
    if (widget.activeQuestStore == null) return null;
    final matches = questStores.where((s) => s.name == widget.activeQuestStore);
    return matches.isEmpty ? null : matches.first;
  }

  @override
  void initState() {
    super.initState();
    _selectedFloor = _activeStore?.floorCode ?? 'B1';
  }

  @override
  void didUpdateWidget(MapPage old) {
    super.didUpdateWidget(old);
    if (widget.activeQuestStore != old.activeQuestStore &&
        _activeStore != null) {
      setState(() => _selectedFloor = _activeStore!.floorCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildFloorSelector(),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _FloorMap(
                  floorCode: _selectedFloor,
                  floorStores: questStores
                      .where((s) => s.floorCode == _selectedFloor)
                      .toList(),
                  activeStoreName: widget.activeQuestStore,
                ),
              ),
            ),
            _buildQuestPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
          if (widget.activeQuestStore != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.navigation_rounded, size: 14, color: kGreen),
                  SizedBox(width: 4),
                  Text(
                    'Navigating',
                    style: TextStyle(
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

  Widget _buildFloorSelector() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _floors.length,
        itemBuilder: (_, i) {
          final floor = _floors[i];
          final selected = _selectedFloor == floor;
          final hasActive = _activeStore?.floorCode == floor;
          return GestureDetector(
            onTap: () => setState(() => _selectedFloor = floor),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? kBlue : kCard,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: selected
                        ? kBlue.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    floor,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : kMid,
                    ),
                  ),
                  if (hasActive) ...[
                    const SizedBox(width: 6),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: kGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuestPanel() {
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
                  _activeStore != null ? 'Active Quest' : 'No Active Quest',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: kDark,
                  ),
                ),
              ],
            ),
          ),
          if (_activeStore == null)
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 28),
              child: Text(
                'No quests are currently in progress.',
                style: TextStyle(fontSize: 13, color: kMid),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: _QuestRow(
                store: _activeStore!,
                isActive: true,
                hasOtherActive: false,
                onStart: () {},
                onCancel: widget.onQuestCancel,
              ),
            ),
        ],
      ),
    );
  }
}

/* ─── FLOOR MAP ───────────────────────────────────────────────── */
class _FloorMap extends StatelessWidget {
  final String floorCode;
  final List<QuestStore> floorStores;
  final String? activeStoreName;

  const _FloorMap({
    required this.floorCode,
    required this.floorStores,
    this.activeStoreName,
  });

  static const _floorZones = <String, List<_Zone>>{
    'B1': [
      _Zone('Food Court', Color(0xFFFFECEC), Color(0xFFDA291C), 3),
      _Zone('Grocery', Color(0xFFECFFEC), kGreen, 1),
      _Zone('Parking', Color(0xFFF0F0F0), kMid, 1),
    ],
    '1F': [
      _Zone('Main Atrium', Color(0xFFE8F4FF), kBlue, 2),
      _Zone('Beauty Zone', Color(0xFFFFF0F5), Color(0xFFB8003D), 2),
      _Zone('Services', Color(0xFFF5F0FF), Color(0xFF9B59B6), 1),
    ],
    '2F': [
      _Zone('East Wing', Color(0xFFF5F5F5), kDark, 2),
      _Zone('Center Court', Color(0xFFFFF8EC), kYellow, 1),
      _Zone('West Wing', Color(0xFFFFF5F5), Color(0xFFCC0000), 2),
    ],
    '3F': [
      _Zone('Tech Hub', Color(0xFFF5F5F7), Color(0xFF555555), 3),
      _Zone('Entertainment', Color(0xFFECF5FF), kBlue, 2),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final zones = _floorZones[floorCode] ?? [];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    floorCode,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  floorStores.isEmpty
                      ? 'No stores on this floor'
                      : '${floorStores.length} store${floorStores.length > 1 ? 's' : ''} here',
                  style: const TextStyle(fontSize: 11, color: kMid),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: zones.map((z) {
                  final zoneStores = floorStores
                      .where((s) => s.zone == z.name)
                      .toList();
                  return Expanded(
                    flex: z.flex,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: z.bg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: z.accent.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            z.name,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: z.accent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: zoneStores.map((s) {
                              return _StorePin(
                                store: s,
                                isActive: s.name == activeStoreName,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Zone {
  final String name;
  final Color bg;
  final Color accent;
  final int flex;
  const _Zone(this.name, this.bg, this.accent, this.flex);
}

/* ─── STORE PIN ───────────────────────────────────────────────── */
class _StorePin extends StatelessWidget {
  final QuestStore store;
  final bool isActive;

  const _StorePin({required this.store, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: isActive ? store.accent : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? store.accent : store.accent.withValues(alpha: 0.3),
          width: isActive ? 2 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: store.accent.withValues(alpha: 0.45),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: Icon(
        store.icon,
        size: 16,
        color: isActive ? Colors.white : store.accent,
      ),
    );
  }
}

/* ─── QUEST ROW ───────────────────────────────────────────────── */
class _QuestRow extends StatelessWidget {
  final QuestStore store;
  final bool isActive;
  final bool hasOtherActive;
  final VoidCallback onStart;
  final VoidCallback onCancel;

  const _QuestRow({
    required this.store,
    required this.isActive,
    required this.hasOtherActive,
    required this.onStart,
    required this.onCancel,
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
              color: store.accent.withValues(alpha: 0.1),
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
            GestureDetector(
              onTap: onCancel,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5555).withValues(alpha: 0.1),
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