import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class GlbLoaderScreen extends StatefulWidget {
  const GlbLoaderScreen({super.key});

  @override
  State<GlbLoaderScreen> createState() => _GlbLoaderScreenState();
}

class _GlbLoaderScreenState extends State<GlbLoaderScreen> {
  final Flutter3DController controller = Flutter3DController();

  @override
  void initState() {
    super.initState();
    // Listen to model loading state
    controller.onModelLoaded.addListener(() {
      debugPrint('Model is loaded: ${controller.onModelLoaded.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GLB Model Viewer')),
      body: Column(
        children: [
          Expanded(
            child: Flutter3DViewer(
              controller: controller,
              src: 'assets/business_man.glb', // Ensure this is in pubspec.yaml
              activeGestureInterceptor: true,
              progressBarColor: Colors.orange,
              onProgress: (double val) => debugPrint('Loading: $val'),
              onLoad: (String address) => debugPrint('Loaded: $address'),
              onError: (String error) => debugPrint('Error: $error'),
            ),
          ),
          // Controller Demonstration Panel
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () => controller.playAnimation(),
                  tooltip: 'Play Animation',
                ),
                IconButton(
                  icon: const Icon(Icons.pause),
                  onPressed: () => controller.pauseAnimation(),
                  tooltip: 'Pause Animation',
                ),
                IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: () => controller.resetAnimation(),
                  tooltip: 'Reset Animation',
                ),
                IconButton(
                  icon: const Icon(Icons.rotate_right),
                  onPressed: () => controller.startRotation(rotationSpeed: 30),
                  tooltip: 'Start Rotation',
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () => controller.stopRotation(),
                  tooltip: 'Stop Rotation',
                ),
                ElevatedButton(
                  onPressed: () async {
                    final anims = await controller.getAvailableAnimations();
                    debugPrint('Available Animations: $anims');
                  },
                  child: const Text('Get Animations'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
