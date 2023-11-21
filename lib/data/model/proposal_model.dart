import 'dart:convert';

class ProposalModel {
  final bool? success;
  final String? message;
  final List<DataProposal>? data;

  ProposalModel({
    this.success,
    this.message,
    this.data,
  });

  factory ProposalModel.fromRawJson(String str) =>
      ProposalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProposalModel.fromJson(Map<String, dynamic> json) => ProposalModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataProposal>.from(json["data"]!.map((x) => DataProposal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataProposal {
  final int? id;
  final String? proposal;
  final dynamic message;
  final int? idSponsorship;
  final int? idEvent;
  final int? idUsers;
  final int? idStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataProposal({
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

  factory DataProposal.fromRawJson(String str) => DataProposal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataProposal.fromJson(Map<String, dynamic> json) => DataProposal(
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
