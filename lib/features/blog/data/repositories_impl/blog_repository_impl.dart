import 'dart:io';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/data_sources/local/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_sources/remote/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("No internet connection"));
      }

      final String blogId = const Uuid().v1();

      // Upload image
      final imageUrl = await blogRemoteDataSource.uploadImage(
        blogID: blogId,
        image: image,
      );

      final BlogModel blogModel = BlogModel(
          id: blogId,
          title: title,
          content: content,
          imageUrl: imageUrl,
          topics: topics,
          updatedAt: DateTime.now(),
          posterId: posterId);

      final BlogModel blog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(blog);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlog() async {
    try {
      if (!await connectionChecker.isConnected) {
        final List<BlogModel> blogList = blogLocalDataSource.loadBlogs();
        return right(blogList);
      }

      final List<BlogModel> blogList = await blogRemoteDataSource.getAllBlog();
      blogLocalDataSource.uploadLocalBlogsAll(blogs: blogList);
      return right(blogList);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
