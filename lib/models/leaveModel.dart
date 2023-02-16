import 'dart:convert';

LeaveModel leaveModelFromJson(String str) =>
    LeaveModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveModel data) => json.encode(data.toJson());

class LeaveModel {
  LeaveModel({
    this.id,
    this.userId,
    this.leaveTypeId,
    this.duration,
    this.leaveDate,
    this.reason,
    this.status,
    this.rejectReason,
    this.paid,
    this.addedBy,
    this.lastUpdatedBy,
    this.eventId,
    this.date,
    this.type,
  });

  int? id;
  int? userId;
  int? leaveTypeId;
  String? duration;
  DateTime? leaveDate;
  String? reason;
  String? status;
  dynamic rejectReason;
  int? paid;
  int? addedBy;
  int? lastUpdatedBy;
  dynamic eventId;
  DateTime? date;
  Type? type;

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        id: json["id"],
        userId: json["user_id"],
        leaveTypeId: json["leave_type_id"],
        duration: json["duration"],
        leaveDate: json["leave_date"] == null
            ? null
            : DateTime.parse(json["leave_date"]),
        reason: json["reason"],
        status: json["status"],
        rejectReason: json["reject_reason"],
        paid: json["paid"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        eventId: json["event_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "leave_type_id": leaveTypeId,
        "duration": duration,
        "leave_date": leaveDate?.toIso8601String(),
        "reason": reason,
        "status": status,
        "reject_reason": rejectReason,
        "paid": paid,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "event_id": eventId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "type": type?.toJson(),
      };
}

class Type {
  Type({
    this.id,
    this.typeName,
    this.color,
    this.noOfLeaves,
    this.paid,
  });

  int? id;
  String? typeName;
  String? color;
  int? noOfLeaves;
  int? paid;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        typeName: json["type_name"],
        color: json["color"],
        noOfLeaves: json["no_of_leaves"],
        paid: json["paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_name": typeName,
        "color": color,
        "no_of_leaves": noOfLeaves,
        "paid": paid,
      };
}
