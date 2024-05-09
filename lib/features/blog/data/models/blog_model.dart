import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.updatedAt,
      required super.posterId,
      super.posterName});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'] ?? '',
      topics: List<String>.from(json['topics'] ?? []),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      posterId: json['poster_id'],
      posterName: json['profiles'] == null ? null : json['profiles']['name'],
    );
  }

  factory BlogModel.fromLocalJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'] ?? '',
      topics: List<String>.from(json['topics'] ?? []),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      posterId: json['poster_id'],
      posterName: json['postar_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': super.id,
        'title': super.title,
        'content': super.content,
        'image_url': super.imageUrl,
        'topics': super.topics,
        'updated_at': super.updatedAt.toIso8601String(),
        'poster_id': super.posterId,
        'postar_name': super.posterName,
      };

  Map<String, dynamic> uploadJson() => {
        'id': super.id,
        'title': super.title,
        'content': super.content,
        'image_url': super.imageUrl,
        'topics': super.topics,
        'updated_at': super.updatedAt.toIso8601String(),
        'poster_id': super.posterId,
      };

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterId,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? super.id,
      title: title ?? super.title,
      content: content ?? super.content,
      imageUrl: imageUrl ?? super.imageUrl,
      topics: topics ?? super.topics,
      updatedAt: updatedAt ?? super.updatedAt,
      posterId: posterId ?? super.posterId,
      posterName: posterName ?? super.posterName,
    );
  }
}
