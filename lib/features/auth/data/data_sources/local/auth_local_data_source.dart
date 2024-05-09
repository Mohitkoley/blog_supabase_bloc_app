import 'package:blog_app/core/common/constants/app_constants.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

abstract interface class AuthLocalDataSource {
  UserModel? getCurrentUser();
  setCurrentUser({required id, required email, required name});
  removeUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> box;

  AuthLocalDataSourceImpl(this.box);

  @override
  UserModel? getCurrentUser() {
    final user = box.get(AppConstants.userBoxName);

    if (user == null) {
      return null;
    }
    return user;
  }

  @override
  setCurrentUser({required id, required email, required name}) {
    final user = UserModel(id: id, email: email, name: name);
    box.put(AppConstants.userBoxName, user);
  }

  @override
  removeUser() {
    box.clear();
  }
}
