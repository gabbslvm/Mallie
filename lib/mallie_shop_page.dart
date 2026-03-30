import 'package:flutter/material.dart';

const kBlue = Color(0xFF4D96FF);
const kYellow = Color(0xFFF0B552);
const kBg = Color(0xFFEEF3FA);
const kCard = Color(0xFFFFFFFF);
const kDark = Color(0xFF1A2340);
const kMid = Color(0xFF6B7A99);
const kLight = Color(0xFFB0BAD3);

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _selectedFilter = 0;

  static const _filters = ['All', 'Fashion', 'Food', 'Tech', 'Beauty', 'Sports'];

  static const _stores = [
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
      name: 'McDonald\'s',
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
  ];

  List<_StoreItem> get _filteredStores {
    if (_selectedFilter == 0) return _stores;
    final cat = _filters[_selectedFilter];
    return _stores.where((s) => s.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  const Text(
                    'Shop',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: kDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('🛍️', style: TextStyle(fontSize: 24)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: kBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.sort_rounded, size: 16, color: kBlue),
                        SizedBox(width: 4),
                        Text(
                          'Sort',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: kBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${_filteredStores.length} stores available',
                style: const TextStyle(fontSize: 13, color: kMid),
              ),
            ),

            // Filter chips
            const SizedBox(height: 16),
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                itemBuilder: (_, i) {
                  final selected = _selectedFilter == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = i),
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
                                ? kBlue.withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _filters[i],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: selected ? Colors.white : kMid,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Store grid
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.82,
                ),
                itemCount: _filteredStores.length,
                itemBuilder: (_, i) => _StoreCard(store: _filteredStores[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
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

class _StoreCard extends StatelessWidget {
  final _StoreItem store;
  const _StoreCard({required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store icon area
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: store.bg,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Center(
                    child: Icon(store.icon, size: 52, color: store.accent.withOpacity(0.35)),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              ],
            ),
          ),

          // Store info
          Padding(
            padding: const EdgeInsets.all(12),
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
                    const Icon(Icons.location_on_rounded, size: 11, color: kBlue),
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
                const SizedBox(height: 6),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
