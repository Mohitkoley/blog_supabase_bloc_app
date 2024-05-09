import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/navigation/app_routing/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final AppUserCubit userCubit;

  AuthGuard(this.userCubit);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    userCubit.stream.listen((state) {
      if (state is AppUserLoggedIn) {
        resolver.next(true);
      } else {
        resolver.next(false);
        resolver.redirect(const LoginRoute());
      }
    });
  }
}
