import 'dart:io';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/use_cases/get_blogs.dart';
import 'package:blog_app/features/blog/domain/use_cases/upload_blog.dart';
import 'package:blog_app/navigation/app_routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  UploadBlog _uploadBlog;
  AppRouter _appRouter;
  AppUserCubit _appUserCubit;
  GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required AppRouter appRouter,
    required AppUserCubit appUserCubit,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _appRouter = appRouter,
        _appUserCubit = appUserCubit,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>(_onEvent);
    on<UploadBlogEvent>(_onUploadBlog);
    on<BlogFetchAllBlogs>(_onGetAllBlogs);
  }

  _onEvent(BlogEvent _, Emitter<BlogState> emit) {
    emit(BlogLoading());
  }

  Future<void> _onUploadBlog(
      UploadBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog.call(BlogParams(
      image: event.image,
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      topics: event.topics,
    ));

    res.fold((l) {
      emit(BlogInitial());
      return emit(BlogFailure(l.message));
    }, (r) {
      emit(BlogUploadSuccess());
      //call _onGetAllBlogs to refresh the blog list
      add(BlogFetchAllBlogs());
      _appRouter.maybePop();
    });
  }

  Future<void> _onGetAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs.call(NoParams());
    res.fold((l) {
      emit(BlogInitial());
      return emit(BlogFailure(l.message));
    }, (r) {
      emit(BlogFetchedSuccess(r));
    });
  }
}
