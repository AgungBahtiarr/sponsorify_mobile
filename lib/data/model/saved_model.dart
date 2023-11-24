import 'dart:convert';

class SavedModel {
  final int? id;
  final int? idEvent;
  final int? idSponsorship;
  final int? idUsers;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Sponsorship? sponsorship;

  SavedModel({
    this.id,
    this.idEvent,
    this.idSponsorship,
    this.idUsers,
    this.createdAt,
    this.updatedAt,
    this.sponsorship,
  });

  factory SavedModel.fromRawJson(String str) =>
      SavedModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavedModel.fromJson(Map<String, dynamic> json) => SavedModel(
        id: json["id"],
        idEvent: json["id_event"],
        idSponsorship: json["id_sponsorship"],
        idUsers: json["id_users"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sponsorship: json["sponsorship"] == null
            ? null
            : Sponsorship.fromJson(json["sponsorship"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_event": idEvent,
        "id_sponsorship": idSponsorship,
        "id_users": idUsers,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sponsorship": sponsorship?.toJson(),
      };
}

class Sponsorship {
  final int? id;
  final String? name;
  final String? email;
  final String? description;
  final String? profilePhoto;
  final String? address;
  final int? idCategory;
  final int? idUsers;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Sponsorship({
    this.id,
    this.name,
    this.email,
    this.description,
    this.profilePhoto,
    this.address,
    this.idCategory,
    this.idUsers,
    this.createdAt,
    this.updatedAt,
  });

  factory Sponsorship.fromRawJson(String str) =>
      Sponsorship.fromJson(json.decode(str));

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
