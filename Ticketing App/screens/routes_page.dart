// lib/screens/routes_page.dart
import 'package:flutter/material.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final List<Map<String, String>> _allRoutes = [
    {'title': 'Route A — Central → Airport', 'time': '30 - 45 min'},
    {'title': 'Route B — East → Central', 'time': '20 - 30 min'},
    {'title': 'Route C — Downtown Loop', 'time': '50 - 60 min'},
    {'title': 'Route D — University → Mall', 'time': '15 - 25 min'},
    {'title': 'Route E — Northside Express', 'time': '40 - 50 min'},
    {'title': 'Route F — South Connector', 'time': '35 - 45 min'},
  ];

  List<Map<String, String>> _filteredRoutes = [];
  String _query = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredRoutes = List.from(_allRoutes);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final q = _searchController.text.trim().toLowerCase();
    if (q == _query) return;
    setState(() {
      _query = q;
      if (_query.isEmpty) {
        _filteredRoutes = List.from(_allRoutes);
      } else {
        _filteredRoutes = _allRoutes.where((r) {
          final title = r['title']!.toLowerCase();
          final time = r['time']!.toLowerCase();
          return title.contains(_query) || time.contains(_query);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      // keep AppBar here so we definitely see the search area — if you already have an AppBar in HomeScreen, remove this one.
      appBar: AppBar(
        title: const Text('Routes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () => Navigator.pushNamed(context, '/topup'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: Offset(0, 2)),
              ],
            ),
            child: Row(children: [
              const Icon(Icons.search),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search routes or duration (e.g. "airport", "30")',
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (_query.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _clearSearch,
                  tooltip: 'Clear',
                )
            ]),
          ),

          const SizedBox(height: 12),
          const Text('Popular routes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),

          // Results
          Expanded(
            child: _filteredRoutes.isEmpty
                ? Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.search_off, size: 56, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text('No routes found', style: TextStyle(color: Colors.grey[600])),
                      if (_query.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: TextButton.icon(
                            onPressed: _clearSearch,
                            icon: const Icon(Icons.clear),
                            label: const Text('Clear search'),
                          ),
                        ),
                    ]),
                  )
                : ListView.builder(
                    itemCount: _filteredRoutes.length,
                    itemBuilder: (_, i) {
                      final r = _filteredRoutes[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(backgroundColor: primary.withOpacity(0.1), child: Icon(Icons.directions_bus, color: primary)),
                          title: Text(r['title']!),
                          subtitle: Text(r['time']!),
                          trailing: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/booking', arguments: r['title']),
                            child: const Text('Book'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ]),
      ),
    );
  }
}
