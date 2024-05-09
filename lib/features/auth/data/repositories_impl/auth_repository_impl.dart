import 'package:blog_app/core/common/constants/app_constants.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:blog_app/features/auth/data/data_sources/remote/auth_remote_datasource.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final AuthLocalDataSource authLocalDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource, this.connectionChecker,
      this.authLocalDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() => authRemoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() => authRemoteDataSource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final user = authLocalDataSource.getCurrentUser();
        if (user == null) {
          return left(Failure(FailureConstants.userNotLoggedIn));
        } else {
          return right(user);
        }
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return (left(Failure(FailureConstants.userNotLoggedIn)));
      } else {
        authLocalDataSource.setCurrentUser(
            id: user.id, name: user.name, email: user.email);
        return right(user);
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() func) async {
    if (!await connectionChecker.isConnected) {
      final user = authLocalDataSource.getCurrentUser();
      if (user != null) {
        return right(user);
      }
      return left(Failure(FailureConstants.noInternet));
    }
    try {
      final user = await func();
      authLocalDataSource.setCurrentUser(
          id: user.id, email: user.email, name: user.name);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
