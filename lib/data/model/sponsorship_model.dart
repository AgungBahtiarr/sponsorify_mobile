import 'dart:convert';

class Sponsorship {
    final int id;
    final String name;
    final String email;
    final String description;
    final String profilePhoto;
    final String address;
    final int idCategory;
    final int idUsers;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Category category;
    final User user;

    Sponsorship({
        required this.id,
        required this.name,
        required this.email,
        required this.description,
        required this.profilePhoto,
        required this.address,
        required this.idCategory,
        required this.idUsers,
        required this.createdAt,
        required this.updatedAt,
        required this.category,
        required this.user,
    });

    factory Sponsorship.fromRawJson(String str) => Sponsorship.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sponsorship.fromJson(Map<String, dynamic> json) => Sponsorship(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        description: json["description"],
        profilePhoto: json["profile_photo"],
        address: json["address"],
        idCategory: json["id_category"],
        idUsers: json["id_users"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "description": description,
        "profile_photo": profilePhoto,
        "address": address,
        "id_category": idCategory,
        "id_users": idUsers,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "user": user.toJson(),
    };
}

class Category {
    final int id;
    final String category;
    final String description;
    final dynamic createdAt;
    final dynamic updatedAt;

    Category({
        required this.id,
        required this.category,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        category: json["category"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class User {
    final int id;
    final String name;
    final String email;
    final dynamic emailVerifiedAt;
    final int idRole;
    final String profilePhoto;
    final DateTime createdAt;
    final DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.idRole,
        required this.profilePhoto,
        required this.createdAt,
        required this.updatedAt,
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
