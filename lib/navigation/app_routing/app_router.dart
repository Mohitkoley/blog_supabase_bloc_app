import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/common/pages/loader_view.dart';
import 'package:blog_app/core/common/pages/not_found_view.dart';
import 'package:blog_app/features/auth/presentation/pages/login_view.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_view.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_view.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_view.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details_view.dart';
import 'package:blog_app/navigation/route_guard/auth_guard.dart';
import 'package:blog_app/navigation/route_name/route_names.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)
class AppRouter extends _$AppRouter {
  AuthGuard authGuard;

  AppRouter(this.authGuard);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SignUpRoute.page,
          path: RouteNames.signUpView,
        ),
        AutoRoute(page: LoginRoute.page, path: RouteNames.loginView),
        AutoRoute(
          page: LoaderRoute.page,
          path: RouteNames.loaderView,
        ),
        AutoRoute(
            initial: true,
            page: BlogRoute.page,
            path: RouteNames.blogView,
            guards: [authGuard]),
        AutoRoute(
          page: AddNewBlogRoute.page,
          path: RouteNames.addNewBlogView,
        ),
        AutoRoute(
          page: BlogDetailsRoute.page,
          path: RouteNames.blogView,
        ),
        AutoRoute(
          page: NotFoundRoute.page,
          path: '*',
        ),
      ];
}
