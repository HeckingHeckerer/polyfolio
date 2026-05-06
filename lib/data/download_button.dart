// lib/screens/detail/widgets/download_button.dart

import 'package:flutter/material.dart';
import '../../../models/model_3d.dart';
import '../../../data/mock_data.dart';

class DownloadButton extends StatelessWidget {
  final Model3D model;
  const DownloadButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isGuest = mockCurrentUserRole == 'guest';
    if (!model.downloadable || isGuest) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Downloading ${model.title}...'),
                backgroundColor: const Color(0xFF1A6B3A),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          icon: const Icon(Icons.download_outlined),
          label: Text('Download ${model.fileFormat} File'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A6B3A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
