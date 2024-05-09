import 'dart:io';

class AppConstants {
  static String hivePath = '${Directory.current.path}/hive_db';
  static const String blogBoxName = 'blogs';
  static const String userBoxName = 'user';
  static const String userTableName = 'profiles';
  static const String blogTableName = 'blogs';
  static const String storageBucketName = 'blog_images';
}

class FailureConstants {
  static const String noInternet = "No internet connection";
  static const String userNotLoggedIn = "User is not logged in";
}
