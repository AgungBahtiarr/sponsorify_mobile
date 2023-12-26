import 'dart:convert';

class Transaction {
    final int? id;
    final int? idEvent;
    final int? idProposal;
    final int? idSponsorship;
    final int? sponsorshipFunds;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Event? event;
    final Event? sponsorship;
    final Proposal? proposal;

    Transaction({
        this.id,
        this.idEvent,
        this.idProposal,
        this.idSponsorship,
        this.sponsorshipFunds,
        this.createdAt,
        this.updatedAt,
        this.event,
        this.sponsorship,
        this.proposal,
    });

    factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        idEvent: json["id_event"],
        idProposal: json["id_proposal"],
        idSponsorship: json["id_sponsorship"],
        sponsorshipFunds: json["sponsorship_funds"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        sponsorship: json["sponsorship"] == null ? null : Event.fromJson(json["sponsorship"]),
        proposal: json["proposal"] == null ? null : Proposal.fromJson(json["proposal"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_event": idEvent,
        "id_proposal": idProposal,
        "id_sponsorship": idSponsorship,
        "sponsorship_funds": sponsorshipFunds,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "event": event?.toJson(),
        "sponsorship": sponsorship?.toJson(),
        "proposal": proposal?.toJson(),
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
    final String? address;
    final int? idCategory;

    Event({
        this.id,
        this.name,
        this.description,
        this.profilePhoto,
        this.email,
        this.idUsers,
        this.createdAt,
        this.updatedAt,
        this.address,
        this.idCategory,
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        address: json["address"],
        idCategory: json["id_category"],
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
        "address": address,
        "id_category": idCategory,
    };
}

class Proposal {
    final int? id;
    final String? proposal;
    final String? message;
    final int? idSponsorship;
    final int? idEvent;
    final int? idUsers;
    final int? idStatus;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Proposal({
        this.id,
        this.proposal,
        this.message,
        this.idSponsorship,
        this.idEvent,
        this.idUsers,
        this.idStatus,
        this.createdAt,
        this.updatedAt,
    });

    factory Proposal.fromRawJson(String str) => Proposal.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        proposal: json["proposal"],
        message: json["message"],
        idSponsorship: json["id_sponsorship"],
        idEvent: json["id_event"],
        idUsers: json["id_users"],
        idStatus: json["id_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    };
}
