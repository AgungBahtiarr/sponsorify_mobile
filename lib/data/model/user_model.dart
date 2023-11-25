import 'dart:convert';

class UserModel {
  final Data? data;

  UserModel({
    this.data,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final int? idRole;
  final String? profilePhoto;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Role? role;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.idRole,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        idRole: json["id_role"],
        profilePhoto: json["profile_photo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "id_role": idRole,
        "profile_photo": profilePhoto,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role?.toJson(),
      };
}

class Role {
  final int? id;
  final String? role;
  final dynamic createdAt;
  final dynamic updatedAt;

  Role({
    this.id,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        role: json["role"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
