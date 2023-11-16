import 'dart:convert';

class LoginModel {
  final bool? success;
  final String? message;
  final String? token;
  final String? email;
  final String? password;
  final int? role;

  LoginModel(
      {this.success,
      this.message,
      this.token,
      this.email,
      this.password,
      this.role});

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      success: json["success"],
      message: json["message"],
      token: json["token"],
      role: json['role']);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "email": email,
        "password": password
      };
}
