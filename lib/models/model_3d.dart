// lib/models/model_3d.dart

class Model3D {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String fileFormat;
  final int triangleCount;
  final int quadCount;
  final int totalTriangleCount;
  final int polygonCount;
  final String thumbnailUrl;
  final bool downloadable;
  final int likeCount;
  final int dislikeCount;
  final int viewCount;
  final String uploaderUsername;
  final DateTime dateUploaded;
  final String modelFileUrl;

  const Model3D({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.fileFormat,
    required this.triangleCount,
    required this.quadCount,
    required this.totalTriangleCount,
    required this.polygonCount,
    required this.thumbnailUrl,
    required this.downloadable,
    required this.likeCount,
    required this.dislikeCount,
    required this.viewCount,
    required this.uploaderUsername,
    required this.dateUploaded,
    required this.modelFileUrl,
  });
}
