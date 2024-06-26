import 'dart:io';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/constants/app_constants.dart';
import 'package:blog_app/core/environment/environment_loader.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:blog_app/features/auth/data/data_sources/remote/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/use_cases/current_user.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_login.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_sources/local/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_sources/remote/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories_impl/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/use_cases/get_blogs.dart';
import 'package:blog_app/features/blog/domain/use_cases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/navigation/app_routing/app_router.dart';
import 'package:blog_app/navigation/route_guard/auth_guard.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';

part 'init_dependencies.dart';
