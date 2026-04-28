import 'package:flutter/material.dart';
import 'glb_loader_screen.dart';

void main() {
  runApp(const PolyFolioApp());
}

class PolyFolioApp extends StatelessWidget {
  const PolyFolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PolyFolio 3D',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PolyFolio 3D Viewers')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GlbLoaderScreen(
                    src: 'assets/3d/ford_mustang_cobra_jet.glb',
                  ),
                ),
              ),
              child: const Text('Load GLB/GLTF (with Controller)'),
            ),
          ],
        ),
      ),
    );
  }
}
