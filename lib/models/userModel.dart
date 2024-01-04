import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String username;
  final String storeName;
  final String email;
  final String password;
  final String id;
  final String token;
  final bool AdminStatus;
  UserModel({
    required this.username,
    required this.storeName,
    required this.email,
    required this.password,
    required this.id,
    required this.token,
    required this.AdminStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "storeName": storeName,
      "email": email,
      "password": password,
      "id": id,
      "token": token,
      "AdminStatus": AdminStatus.toString(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map["username"] ?? '',
      storeName: map["storeName"] ?? '',
      email: map["email"] ?? '',
      password: map["password"] ?? '',
      id: map["id"] ?? '',
      token: map["token"] ?? '',
      AdminStatus: map["AdminStatus"] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        json.decode(source),
      );
}
