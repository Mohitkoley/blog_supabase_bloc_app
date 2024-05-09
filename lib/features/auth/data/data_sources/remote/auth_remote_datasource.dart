import 'package:blog_app/core/common/constants/app_constants.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get getCurrentSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({
    required this.supabaseClient,
  });

  Session? get getCurrentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
    };

    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: data);
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return UserModel.fromSupabaseUser(response.user!);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException("User not found");
      }
      return UserModel.fromSupabaseUser(response.user!);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (getCurrentSession != null) {
        final users = await supabaseClient
            .from(AppConstants.userTableName)
            .select()
            .eq('id', getCurrentSession!.user.id);
        return UserModel.fromJson(users.first);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
