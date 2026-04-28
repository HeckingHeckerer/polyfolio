import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class ObjLoaderScreen extends StatelessWidget {
  final String src;
  const ObjLoaderScreen({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    // Validation logic
    final bool isValidExtension = src.toLowerCase().endsWith('.obj');

    return Scaffold(
      appBar: AppBar(title: const Text('OBJ Model Viewer')),
      body: !isValidExtension
          ? const Center(child: Text('Error: File is not an OBJ model.'))
          : Center(
              child: Flutter3DViewer.obj(
                src: src,
                scale: 5,
                cameraX: 0,
                cameraY: 0,
                cameraZ: 10,
                onProgress: (double progressValue) {
                  debugPrint('OBJ loading progress : $progressValue');
                },
                onLoad: (String modelAddress) {
                  debugPrint('OBJ loaded : $modelAddress');
                },
                onError: (String error) {
                  debugPrint('OBJ failed to load : $error');
                },
              ),
            ),
    );
  }
}
