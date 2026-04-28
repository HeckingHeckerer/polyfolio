import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class GlbLoaderScreen extends StatefulWidget {
  final String src;
  const GlbLoaderScreen({super.key, required this.src});

  @override
  State<GlbLoaderScreen> createState() => _GlbLoaderScreenState();
}

class _GlbLoaderScreenState extends State<GlbLoaderScreen> {
  final Flutter3DController controller = Flutter3DController();

  @override
  void initState() {
    super.initState();
    controller.onModelLoaded.addListener(_onModelLoadedListener);
  }

  void _onModelLoadedListener() {
    debugPrint('Model is loaded: ${controller.onModelLoaded.value}');
  }

  @override
  void dispose() {
    // Remove listener to prevent memory leaks
    controller.onModelLoaded.removeListener(_onModelLoadedListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Validation logic: check if the extension is correct
    final bool isValidExtension =
        widget.src.toLowerCase().endsWith('.glb') ||
        widget.src.toLowerCase().endsWith('.gltf');

    return Scaffold(
      appBar: AppBar(title: const Text('GLB Model Viewer')),
      body: !isValidExtension
          ? const Center(child: Text('Error: File is not a GLB/GLTF model.'))
          : Column(
              children: [
                Expanded(
                  child: Flutter3DViewer(
                    controller: controller,
                    src: widget.src,
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
                        onPressed: () =>
                            controller.startRotation(rotationSpeed: 30),
                        tooltip: 'Start Rotation',
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop),
                        onPressed: () => controller.stopRotation(),
                        tooltip: 'Stop Rotation',
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final anims = await controller
                              .getAvailableAnimations();
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
