import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/environment/environment_loader.dart';
import 'package:blog_app/core/service_locators/init_dependencies_imports.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/navigation/app_routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentLoader.loadEnv();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
    BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = serviceLocator<AppRouter>();
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        routerConfig: _appRouter.config(
          includePrefixMatches: true,
        ));
  }
}
