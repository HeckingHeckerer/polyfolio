// lib/screens/detail/model_detail_screen.dart

import 'package:flutter/material.dart';
import '../../models/model_3d.dart';

class ModelDetailScreen extends StatelessWidget {
  final Model3D model;
  const ModelDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          model.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.view_in_ar, color: Color(0xFFE94560), size: 64),
            const SizedBox(height: 16),
            Text(
              model.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '3D viewer and details — coming next',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
