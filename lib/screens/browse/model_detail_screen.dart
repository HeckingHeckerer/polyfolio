// lib/screens/detail/model_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import '../../models/model_3d.dart';

class ModelDetailScreen extends StatefulWidget {
  final Model3D model;
  const ModelDetailScreen({super.key, required this.model});

  @override
  State<ModelDetailScreen> createState() => _ModelDetailScreenState();
}

class _ModelDetailScreenState extends State<ModelDetailScreen> {
  final Flutter3DController controller = Flutter3DController();
  bool _isRotating = false;

  void _toggleRotation() {
    setState(() {
      _isRotating = !_isRotating;
      if (_isRotating) {
        controller.startRotation();
      } else {
        controller.stopRotation();
      }
    });
  }

  @override
  void dispose() {
    // Ensure rotations are stopped when navigating away
    controller.stopRotation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.model.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 3D Viewer Container
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                border: Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
              ),
              child: Flutter3DViewer(
                controller: controller,
                src: widget.model.modelFileUrl,
              ),
            ),

            // 3D Control Panel
            Container(
              color: Colors.black.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: Icons.play_arrow,
                    label: 'Play',
                    onPressed: () => controller.playAnimation(),
                  ),
                  _buildControlButton(
                    icon: Icons.pause,
                    label: 'Pause',
                    onPressed: () => controller.pauseAnimation(),
                  ),
                  _buildControlButton(
                    icon: Icons.replay,
                    label: 'Reset',
                    onPressed: () => controller.resetAnimation(),
                  ),
                  _buildControlButton(
                    icon: _isRotating ? Icons.stop : Icons.rotate_right,
                    label: _isRotating ? 'Stop' : 'Rotate',
                    onPressed: _toggleRotation,
                    color: _isRotating ? const Color(0xFFE94560) : Colors.white,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Basic Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.model.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (widget.model.downloadable)
                        const Icon(
                          Icons.download_for_offline,
                          color: Color(0xFFE94560),
                          size: 28,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'uploaded by @${widget.model.uploaderUsername}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Geometry Stats
                  _buildSectionTitle('Geometry Statistics'),
                  const SizedBox(height: 12),
                  _buildStatRow(
                    'Triangles',
                    widget.model.triangleCount.toString(),
                  ),
                  _buildStatRow('Quads', widget.model.quadCount.toString()),
                  _buildStatRow(
                    'Total Triangles',
                    widget.model.totalTriangleCount.toString(),
                  ),
                  _buildStatRow('File Format', widget.model.fileFormat),

                  const SizedBox(height: 24),

                  // Description
                  _buildSectionTitle('Description'),
                  const SizedBox(height: 10),
                  Text(
                    widget.model.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.model.tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE94560).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE94560).withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              '#$tag',
                              style: const TextStyle(
                                color: Color(0xFFE94560),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color color = Colors.white,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color.withOpacity(0.8), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 15,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
