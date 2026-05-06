// lib/data/mock_data.dart

import '../models/model_3d.dart';

final List<Model3D> mockModels = [
  Model3D(
    id: '1',
    title: 'Samurai Armor',
    description: 'Detailed feudal Japanese samurai armor with textures.',
    tags: ['armor', 'japanese', 'character', 'historical'],
    fileFormat: 'GLB',
    triangleCount: 7700,
    quadCount: 39400,
    totalTriangleCount: 86500,
    polygonCount: 48200,
    thumbnailUrl: 'https://picsum.photos/seed/samurai/400/300',
    downloadable: true,
    likeCount: 214,
    dislikeCount: 3,
    viewCount: 1840,
    uploaderUsername: 'kagenobu',
    dateUploaded: DateTime(2025, 3, 10),
    modelFileUrl: 'assets/3d/samurai_armor.glb',
  ),
  Model3D(
    id: '2',
    title: 'Sci-Fi Pistol',
    description: 'Low-poly futuristic sidearm, game-ready.',
    tags: ['weapon', 'scifi', 'lowpoly', 'game-ready'],
    fileFormat: 'GLB',
    triangleCount: 2400,
    quadCount: 3000,
    totalTriangleCount: 8400,
    polygonCount: 8400,
    thumbnailUrl: 'https://picsum.photos/seed/pistol/400/300',
    downloadable: true,
    likeCount: 98,
    dislikeCount: 1,
    viewCount: 760,
    uploaderUsername: 'neon_forge',
    dateUploaded: DateTime(2025, 4, 2),
    modelFileUrl: 'assets/3d/scifi_pistol.glb',
  ),
  Model3D(
    id: '3',
    title: 'Ancient Temple',
    description: 'Environment asset — overgrown stone temple ruins.',
    tags: ['environment', 'ruins', 'historical', 'nature'],
    fileFormat: 'GLB',
    triangleCount: 124000,
    quadCount: 0,
    totalTriangleCount: 124000,
    polygonCount: 124000,
    thumbnailUrl: 'https://picsum.photos/seed/temple/400/300',
    downloadable: false,
    likeCount: 502,
    dislikeCount: 12,
    viewCount: 4300,
    uploaderUsername: 'terra_sculpt',
    dateUploaded: DateTime(2025, 1, 28),
    modelFileUrl: 'assets/3d/ancient_temple.glb',
  ),
  Model3D(
    id: '4',
    title: 'Steam Punk Robot',
    description: 'Friendly bipedal robot with idle animation.',
    tags: ['character', 'robot', 'scifi', 'animated'],
    fileFormat: 'GLB',
    triangleCount: 5500,
    quadCount: 13000,
    totalTriangleCount: 31500,
    polygonCount: 31500,
    thumbnailUrl: 'https://picsum.photos/seed/robot/400/300',
    downloadable: true,
    likeCount: 377,
    dislikeCount: 5,
    viewCount: 2910,
    uploaderUsername: 'mech_works',
    dateUploaded: DateTime(2025, 2, 14),
    modelFileUrl: 'assets/3d/combat_steampunk_robot.glb',
  ),
  Model3D(
    id: '5',
    title: 'Fantasy Sword',
    description: 'Ornate elven longsword with glowing runes.',
    tags: ['weapon', 'fantasy', 'character'],
    fileFormat: 'GLB',
    triangleCount: 12800,
    quadCount: 0,
    totalTriangleCount: 12800,
    polygonCount: 12800,
    thumbnailUrl: 'https://picsum.photos/seed/sword/400/300',
    downloadable: false,
    likeCount: 155,
    dislikeCount: 2,
    viewCount: 1100,
    uploaderUsername: 'elven_blade',
    dateUploaded: DateTime(2025, 3, 30),
    modelFileUrl: 'assets/3d/shattered_crystal_sword.glb',
  ),
  Model3D(
    id: '6',
    title: 'Sword of Victory',
    description: 'The Sword that leads to Victory.',
    tags: ['weapon', 'fantasy', 'character', 'game-ready'],
    fileFormat: 'GLB',
    triangleCount: 1200,
    quadCount: 2000,
    totalTriangleCount: 5200,
    polygonCount: 5200,
    thumbnailUrl: 'https://picsum.photos/seed/trees/400/300',
    downloadable: true,
    likeCount: 89,
    dislikeCount: 0,
    viewCount: 430,
    uploaderUsername: 'poly_grove',
    dateUploaded: DateTime(2025, 4, 18),
    modelFileUrl: 'assets/3d/the_sword_of_victory.glb',
  ),
];

// All unique tags extracted from mock models — used for the filter chips
final List<String> mockTags = [
  'armor',
  'japanese',
  'character',
  'historical',
  'weapon',
  'scifi',
  'lowpoly',
  'game-ready',
  'environment',
  'ruins',
  'nature',
  'robot',
  'animated',
  'fantasy',
];

// Append to the bottom of lib/data/mock_data.dart

class MockComment {
  final String id;
  final String username;
  final String text;
  final DateTime timestamp;

  const MockComment({
    required this.id,
    required this.username,
    required this.text,
    required this.timestamp,
  });
}

final Map<String, List<MockComment>> mockComments = {
  '1': [
    MockComment(
      id: 'c1',
      username: 'poly_grove',
      text: 'Incredible detail on the shoulder plates!',
      timestamp: DateTime(2025, 3, 12),
    ),
    MockComment(
      id: 'c2',
      username: 'neon_forge',
      text: 'What software did you use to sculpt this?',
      timestamp: DateTime(2025, 3, 14),
    ),
    MockComment(
      id: 'c3',
      username: 'terra_sculpt',
      text: 'The topology is very clean, great work.',
      timestamp: DateTime(2025, 3, 20),
    ),
  ],
  '2': [
    MockComment(
      id: 'c4',
      username: 'kagenobu',
      text: 'Perfect for my FPS project!',
      timestamp: DateTime(2025, 4, 3),
    ),
  ],
  '3': [
    MockComment(
      id: 'c5',
      username: 'mech_works',
      text: 'The overgrowth texture is stunning.',
      timestamp: DateTime(2025, 2, 1),
    ),
    MockComment(
      id: 'c6',
      username: 'elven_blade',
      text: 'Would love a day/night version of this.',
      timestamp: DateTime(2025, 2, 10),
    ),
  ],
  '4': [],
  '5': [],
  '6': [],
};

// Mock current user — swap with real auth later
const mockCurrentUsername = 'demo_user';
const mockCurrentUserRole = 'user'; // 'guest', 'user', or 'admin'

// null = not yet rated, 'like' or 'dislike' = rated
final Map<String, String?> mockUserRatings = {
  '1': null,
  '2': 'like',
  '3': null,
  '4': null,
  '5': null,
  '6': null,
};
