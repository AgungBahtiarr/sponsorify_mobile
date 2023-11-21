import 'dart:convert';

class EventModel {
    final int id;
    final String name;
    final String description;
    final String profilePhoto;
    final String email;
    final int idUsers;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Users users;

    EventModel({
        required this.id,
        required this.name,
        required this.description,
        required this.profilePhoto,
        required this.email,
        required this.idUsers,
        required this.createdAt,
        required this.updatedAt,
        required this.users,
    });

    factory EventModel.fromRawJson(String str) => EventModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        profilePhoto: json["profile_photo"],
        email: json["email"],
        idUsers: json["id_users"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        users: Users.fromJson(json["users"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "profile_photo": profilePhoto,
        "email": email,
        "id_users": idUsers,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "users": users.toJson(),
    };
}

class Users {
    final int id;
    final String name;
    final String email;
    final dynamic emailVerifiedAt;
    final int idRole;
    final String profilePhoto;
    final DateTime createdAt;
    final DateTime updatedAt;

    Users({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.idRole,
        required this.profilePhoto,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Users.fromJson(Map<String, dynamic> json) => Users(
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
