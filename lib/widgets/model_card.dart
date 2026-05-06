// lib/screens/browse/widgets/model_card.dart

import 'package:flutter/material.dart';
import '../models/model_3d.dart';
import '../screens/browse/model_detail_screen.dart';

class ModelCard extends StatelessWidget {
  final Model3D model;
  const ModelCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ModelDetailScreen(model: model)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
              child: Text(
                model.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
              child: Text(
                '${_formatNumber(model.totalTriangleCount)} tris  •  ${model.fileFormat}',
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.thumb_up_outlined,
                    size: 13,
                    color: Color(0xFFE94560),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '${model.likeCount}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE94560),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.visibility_outlined,
                    size: 13,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '${_formatNumber(model.viewCount)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  if (model.downloadable) ...[
                    const Spacer(),
                    const Icon(
                      Icons.download_outlined,
                      size: 14,
                      color: Color(0xFF1A6B3A),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Image.network(
          model.thumbnailUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              color: const Color(0xFFF0F0F0),
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
          errorBuilder: (context, _, __) => Container(
            color: const Color(0xFFE0E0E0),
            child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}
