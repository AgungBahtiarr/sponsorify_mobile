import 'dart:convert';

class ProposalSponsorshipModel {
  final int? id;
  final String? proposal;
  final dynamic message;
  final int? idSponsorship;
  final int? idEvent;
  final int? idUsers;
  final int? idStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Status? status;
  final Event? event;

  ProposalSponsorshipModel({
    this.id,
    this.proposal,
    this.message,
    this.idSponsorship,
    this.idEvent,
    this.idUsers,
    this.idStatus,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.event,
  });

  factory ProposalSponsorshipModel.fromRawJson(String str) =>
      ProposalSponsorshipModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProposalSponsorshipModel.fromJson(Map<String, dynamic> json) =>
      ProposalSponsorshipModel(
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
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
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
        "status": status?.toJson(),
        "event": event?.toJson(),
      };
}

class Event {
  final int? id;
  final String? name;
  final String? description;
  final String? profilePhoto;
  final String? email;
  final int? idUsers;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Event({
    this.id,
    this.name,
    this.description,
    this.profilePhoto,
    this.email,
    this.idUsers,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        profilePhoto: json["profile_photo"],
        email: json["email"],
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
        "description": description,
        "profile_photo": profilePhoto,
        "email": email,
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
