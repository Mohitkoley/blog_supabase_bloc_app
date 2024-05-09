import 'dart:io';

import 'package:blog_app/core/common/constants/app_constants.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadImage({required String blogID, required File image});
  Future<List<BlogModel>> getAllBlog();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({
    required this.supabaseClient,
  });

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final blogListData = await supabaseClient
          .from(AppConstants.blogTableName)
          .insert(blogModel.uploadJson())
          .select();
      return BlogModel.fromJson(blogListData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage(
      {required String blogID, required File image}) async {
    try {
      await supabaseClient.storage
          .from(AppConstants.storageBucketName)
          .upload(blogID, image);
      return supabaseClient.storage
          .from(AppConstants.storageBucketName)
          .getPublicUrl(blogID);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    try {
      final blogListData = await supabaseClient
          .from('blogs')
          .select('*, profiles(name)')
          .order('updated_at', ascending: false);
      return blogListData.map((blog) => BlogModel.fromJson(blog)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
