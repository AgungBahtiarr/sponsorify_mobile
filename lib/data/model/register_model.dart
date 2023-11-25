// import 'package:meta/meta.dart';
import 'dart:convert';

class Register {
  final bool success;
  final Data data;

  Register({
    required this.success,
    required this.data,
  });

  factory Register.fromRawJson(String str) =>
      Register.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  final String name;
  final String email;
  final String? profilePhoto;
  final String idRole;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? password;

  Data(
      {required this.name,
      required this.email,
      this.profilePhoto,
      required this.idRole,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.password});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      name: json["name"],
      email: json["email"],
      profilePhoto: json["profile_photo"],
      idRole: json["id_role"],
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      id: json["id"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profile_photo": 'url_photo',
        "id_role": idRole,
        "id": id,
        "password": password
      };
}
