import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class ObjLoaderScreen extends StatelessWidget {
  const ObjLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OBJ Model Viewer')),
      body: Center(
        child: Flutter3DViewer.obj(
          src: 'assets/flutter_dash.obj', // Ensure this is in pubspec.yaml
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
