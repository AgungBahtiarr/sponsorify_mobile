import 'dart:convert';

class ProposalModel {
  final int? id;
  final String? proposal;
  final dynamic message;
  final int? idSponsorship;
  final int? idEvent;
  final int? idUsers;
  final int? idStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Sponsorship? sponsorship;
  final Status? status;

  ProposalModel({
    this.id,
    this.proposal,
    this.message,
    this.idSponsorship,
    this.idEvent,
    this.idUsers,
    this.idStatus,
    this.createdAt,
    this.updatedAt,
    this.sponsorship,
    this.status,
  });

  factory ProposalModel.fromRawJson(String str) =>
      ProposalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProposalModel.fromJson(Map<String, dynamic> json) => ProposalModel(
        id: json["id"],
        proposal: json["proposal"],
        message: json["message"],
        idSponsorship: json["id_sponsorship"],
        idEvent: json["id_event"],
        idUsers: json["id_users"],
        idStatus: json["id_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sponsorship: json["sponsorship"] == null
            ? null
            : Sponsorship.fromJson(json["sponsorship"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "proposal": proposal,
        "message": message,
        "id_sponsorship": idSponsorship,
        "id_event": idEvent,
        "id_users": idUsers,
        "id_status": idStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sponsorship": sponsorship?.toJson(),
        "status": status?.toJson(),
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

class Status {
  final int? id;
  final String? status;
  final String? description;

  Status({
    this.id,
    this.status,
    this.description,
  });

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "description": description,
      };
}