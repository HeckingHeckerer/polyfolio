// lib/screens/browse/browse_screen.dart

import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/model_3d.dart';
import '../../widgets/model_card.dart';
import '../../widgets/tag_filter_bar.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String _searchQuery = '';
  List<String> _selectedTags = [];

  List<Model3D> get _filteredModels {
    return mockModels.where((model) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          model.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesTags =
          _selectedTags.isEmpty ||
          _selectedTags.every((tag) => model.tags.contains(tag));
      return matchesSearch && matchesTags;
    }).toList();
  }

  void _onTagToggled(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text(
          'PolyFolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {}, // Profile — wire up later
          ),
          IconButton(
            icon: const Icon(Icons.upload_outlined, color: Color(0xFFE94560)),
            onPressed: () {}, // Upload — wire up later
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          TagFilterBar(
            tags: mockTags,
            selectedTags: _selectedTags,
            onTagToggled: _onTagToggled,
          ),
          Expanded(child: _buildModelGrid()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE94560),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {}, // Upload — wire up later
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: const Color(0xFF1A1A2E),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search models...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFE94560)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildModelGrid() {
    final models = _filteredModels;
    final hasFilters = _selectedTags.isNotEmpty || _searchQuery.isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: [
              Text(
                '${models.length} model${models.length == 1 ? '' : 's'}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (hasFilters)
                TextButton.icon(
                  onPressed: () => setState(() {
                    _selectedTags.clear();
                    _searchQuery = '';
                  }),
                  icon: const Icon(
                    Icons.close,
                    size: 14,
                    color: Color(0xFFE94560),
                  ),
                  label: const Text(
                    'Clear filters',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE94560)),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                ),
            ],
          ),
        ),
        Expanded(
          child: models.isEmpty
              ? const Center(
                  child: Text(
                    'No models found.',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: models.length,
                  itemBuilder: (context, index) =>
                      ModelCard(model: models[index]),
                ),
        ),
      ],
    );
  }
}
