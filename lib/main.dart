// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/browse/browse_screen.dart';

void main() {
  runApp(const PolyFolioApp());
}

class PolyFolioApp extends StatelessWidget {
  const PolyFolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PolyFolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1A1A2E),
        fontFamily: 'Roboto',
      ),
      home: const BrowseScreen(),
    );
  }
}
