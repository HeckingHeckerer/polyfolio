// lib/screens/browse/widgets/tag_filter_bar.dart

import 'package:flutter/material.dart';

class TagFilterBar extends StatelessWidget {
  final List<String> tags;
  final List<String> selectedTags;
  final void Function(String tag) onTagToggled;

  const TagFilterBar({
    super.key,
    required this.tags,
    required this.selectedTags,
    required this.onTagToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: const Color(0xFF1A1A2E),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = selectedTags.contains(tag);
          return GestureDetector(
            onTap: () => onTagToggled(tag),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE94560)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFE94560)
                      : Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                '#$tag',
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
