import 'package:blog_app/core/common/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  factory UserModel.fromSupabaseUser(sb.User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?["name"] ?? "",
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
