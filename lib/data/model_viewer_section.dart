import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import '../../../models/model_3d.dart';

class ModelViewerSection extends StatefulWidget {
  final Model3D model;
  const ModelViewerSection({super.key, required this.model});

  @override
  State<ModelViewerSection> createState() => _ModelViewerSectionState();
}

class _ModelViewerSectionState extends State<ModelViewerSection> {
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
    controller.stopRotation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
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
          Text(
            label,
            style: TextStyle(color: color.withOpacity(0.8), fontSize: 11),
          ),
        ],
      ),
    );
  }
}
