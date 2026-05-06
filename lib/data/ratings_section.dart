// lib/screens/detail/widgets/ratings_section.dart

import 'package:flutter/material.dart';
import '../../../models/model_3d.dart';
import '../../../data/mock_data.dart';

class RatingsSection extends StatefulWidget {
  final Model3D model;
  const RatingsSection({super.key, required this.model});

  @override
  State<RatingsSection> createState() => _RatingsSectionState();
}

class _RatingsSectionState extends State<RatingsSection> {
  late int _likes;
  late int _dislikes;
  late String? _currentRating;

  @override
  void initState() {
    super.initState();
    _likes = widget.model.likeCount;
    _dislikes = widget.model.dislikeCount;
    _currentRating = mockUserRatings[widget.model.id];
  }

  void _onRate(String action) {
    if (mockCurrentUserRole == 'guest') return;
    setState(() {
      if (_currentRating == action) {
        if (action == 'like') _likes--;
        if (action == 'dislike') _dislikes--;
        _currentRating = null;
      } else {
        if (_currentRating == 'like') _likes--;
        if (_currentRating == 'dislike') _dislikes--;
        if (action == 'like') _likes++;
        if (action == 'dislike') _dislikes++;
        _currentRating = action;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = mockCurrentUserRole == 'guest';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Rate this model:',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const Spacer(),
          _ratingButton(
            icon: Icons.thumb_up_outlined,
            activeIcon: Icons.thumb_up,
            count: _likes,
            isActive: _currentRating == 'like',
            color: const Color(0xFF1A6B3A),
            onTap: isGuest ? null : () => _onRate('like'),
          ),
          const SizedBox(width: 16),
          _ratingButton(
            icon: Icons.thumb_down_outlined,
            activeIcon: Icons.thumb_down,
            count: _dislikes,
            isActive: _currentRating == 'dislike',
            color: const Color(0xFFE94560),
            onTap: isGuest ? null : () => _onRate('dislike'),
          ),
          if (isGuest) ...[
            const SizedBox(width: 12),
            const Text(
              'Log in to rate',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _ratingButton({
    required IconData icon,
    required IconData activeIcon,
    required int count,
    required bool isActive,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isActive ? color : const Color(0xFFDDDDDD)),
        ),
        child: Row(
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 18,
              color: isActive ? color : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isActive ? color : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
