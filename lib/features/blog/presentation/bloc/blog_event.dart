part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class UploadBlogEvent extends BlogEvent {
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  final String posterId;

  UploadBlogEvent({
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
    required this.posterId,
  });
}

final class BlogFetchAllBlogs extends BlogEvent {}
