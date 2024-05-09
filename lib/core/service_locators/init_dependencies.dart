part of 'init_dependencies_imports.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: EnvironmentLoader.keys.supabaseUrl,
    anonKey: EnvironmentLoader.keys.anonKey,
  ).onError((error, stackTrace) =>
      throw Exception('Error initializing Supabase: $error and $stackTrace'));

  String defaultPath = (await getApplicationDocumentsDirectory()).path;

  //hive
  Hive.defaultDirectory = defaultPath;

  Hive.registerAdapter<UserModel>(
      "UserModel", (json) => UserModel.fromJson(json));

  serviceLocator
    ..registerLazySingleton(
      () => Hive.box(name: AppConstants.blogBoxName),
    )
    ..registerLazySingleton(
      () => Hive.box<UserModel>(name: AppConstants.userBoxName),
    )

    //supabase
    ..registerLazySingleton(() => supabase.client)

    // core
    ..registerLazySingleton(
      () => AppUserCubit(),
    )

    //network
    ..registerFactory(() => InternetConnection())
    ..registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(
        serviceLocator(),
      ),
    )

    //route guard
    ..registerLazySingleton<AuthGuard>(
        () => AuthGuard(serviceLocator<AppUserCubit>()))
    //router
    ..registerSingleton<AppRouter>(AppRouter(serviceLocator<AuthGuard>()));

  // auth
  _initAuth();
  _initBlog();
}

_initBlog() {
  serviceLocator
    //data sources
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    //repositories
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    //use case upload blog
    ..registerFactory<UploadBlog>(
      () => UploadBlog(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetAllBlogs>(
      () => GetAllBlogs(
        blogRepository: serviceLocator(),
      ),
    )
    //bloc
    ..registerLazySingleton<BlogBloc>(() => BlogBloc(
        uploadBlog: serviceLocator(),
        appRouter: serviceLocator(),
        appUserCubit: serviceLocator(),
        getAllBlogs: serviceLocator()));
}

_initAuth() {
  serviceLocator
    //data sources
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(serviceLocator<Box<UserModel>>()))
    //repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //use case signup
    ..registerFactory<UserSignUp>(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    //use case login
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    //use case current user
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    //bloc
    ..registerLazySingleton<AuthBloc>(() => AuthBloc(
          signUp: serviceLocator(),
          appRouter: serviceLocator(),
          login: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
          connectionChecker: serviceLocator(),
        ));
}
