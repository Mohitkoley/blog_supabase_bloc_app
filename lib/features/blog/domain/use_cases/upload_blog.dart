// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements UseCase<Blog, BlogParams> {
  BlogRepository blogRepository;
  UploadBlog({
    required this.blogRepository,
  });

  @override
  Future<Either<Failure, Blog>> call(params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class BlogParams {
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final File image;

  BlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.image,
  });
}
