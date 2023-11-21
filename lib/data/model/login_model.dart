import 'dart:convert';

class LoginModel {
  final bool? success;
  final String? message;
  final String? token;
  final int? role;
  final User? user;
  final String? email;
  final String? password;

  LoginModel(
      {this.success,
      this.message,
      this.token,
      this.role,
      this.user,
      this.email,
      this.password});

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      success: json["success"],
      message: json["message"],
      token: json["token"],
      role: json["role"],
      user: User.fromJson(json["user"]),
      email: json["email"],
      password: json["password"]);

  factory LoginModel.fromJsonFail(Map<String, dynamic> json) => LoginModel(
      success: json["success"],
      message: json["message"],
      token: json["token"],
      role: json["role"],
      email: json["email"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final int? idRole;
  final String? profilePhoto;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.idRole,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        idRole: json["id_role"],
        profilePhoto: json["profile_photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "id_role": idRole,
        "profile_photo": profilePhoto,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}
