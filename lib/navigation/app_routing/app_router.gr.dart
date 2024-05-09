// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddNewBlogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddNewBlogView(),
      );
    },
    BlogDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BlogDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BlogDetailsView(
          key: args.key,
          blog: args.blog,
        ),
      );
    },
    BlogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BlogView(),
      );
    },
    LoaderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoaderView(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    NotFoundRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotFoundView(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpView(),
      );
    },
  };
}

/// generated route for
/// [AddNewBlogView]
class AddNewBlogRoute extends PageRouteInfo<void> {
  const AddNewBlogRoute({List<PageRouteInfo>? children})
      : super(
          AddNewBlogRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddNewBlogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BlogDetailsView]
class BlogDetailsRoute extends PageRouteInfo<BlogDetailsRouteArgs> {
  BlogDetailsRoute({
    Key? key,
    required Blog blog,
    List<PageRouteInfo>? children,
  }) : super(
          BlogDetailsRoute.name,
          args: BlogDetailsRouteArgs(
            key: key,
            blog: blog,
          ),
          initialChildren: children,
        );

  static const String name = 'BlogDetailsRoute';

  static const PageInfo<BlogDetailsRouteArgs> page =
      PageInfo<BlogDetailsRouteArgs>(name);
}

class BlogDetailsRouteArgs {
  const BlogDetailsRouteArgs({
    this.key,
    required this.blog,
  });

  final Key? key;

  final Blog blog;

  @override
  String toString() {
    return 'BlogDetailsRouteArgs{key: $key, blog: $blog}';
  }
}

/// generated route for
/// [BlogView]
class BlogRoute extends PageRouteInfo<void> {
  const BlogRoute({List<PageRouteInfo>? children})
      : super(
          BlogRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoaderView]
class LoaderRoute extends PageRouteInfo<void> {
  const LoaderRoute({List<PageRouteInfo>? children})
      : super(
          LoaderRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoaderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotFoundView]
class NotFoundRoute extends PageRouteInfo<void> {
  const NotFoundRoute({List<PageRouteInfo>? children})
      : super(
          NotFoundRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotFoundRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpView]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
