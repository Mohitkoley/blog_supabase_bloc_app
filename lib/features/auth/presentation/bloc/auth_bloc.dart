import 'dart:async';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/use_cases/current_user.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_login.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:blog_app/navigation/app_routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _signup;
  final AppRouter _appRouter;
  final UserLogin _login;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final ConnectionChecker _connectionChecker;
  AuthBloc({
    required UserSignUp signUp,
    required AppRouter appRouter,
    required UserLogin login,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required ConnectionChecker connectionChecker,
  })  : _signup = signUp,
        _appRouter = appRouter,
        _login = login,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _connectionChecker = connectionChecker,
        super(AuthInitial()) {
    on<AuthEvent>(_onEvent);
    on<AuthSignUp>(_onSignUp);
    on<AuthLogin>(_onLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  _onEvent(AuthEvent _, Emitter<AuthState> emit) {
    emit(AuthLoading());
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _signup.call(UserSignUpParams(
        email: event.email, name: event.name, password: event.password));
    res.fold((l) {
      emit(AuthInitial());
      return emit(AuthFailure(message: l.message));
    }, (r) {
      _emitAuthSucess(r, emit);
      _appRouter.replaceAll([
        const BlogRoute(),
      ]);
    });
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _login
        .call(UserLoginParams(email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(message: l.message)), (r) {
      _emitAuthSucess(r, emit);
    });
  }

  Future<void> _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser.call(NoParams());
    res.fold((l) {
      debugPrint("failure is $l ");
      _appUserCubit.updateUser(null);
      emit(AuthFailure(message: l.message));
    }, (user) {
      _emitAuthSucess(user, emit);
    });
  }

  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }

  void goToBlogView() {
    _appRouter.replace(const BlogRoute());
  }
}
