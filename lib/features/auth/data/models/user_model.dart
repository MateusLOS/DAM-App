import 'package:recomendou_flutter/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'email': email,
    };
  }
}