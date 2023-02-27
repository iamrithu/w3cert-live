// To parse this JSON data, do
//
//     final LeadAgendModel = LeadAgendModelFromJson(jsonString);

import 'dart:convert';

LeadAgendModel LeadAgendModelFromJson(String str) =>
    LeadAgendModel.fromJson(json.decode(str));

String LeadAgendModelToJson(LeadAgendModel data) => json.encode(data.toJson());

class LeadAgendModel {
  LeadAgendModel({
    this.id,
    this.userId,
    this.status,
    this.addedBy,
    this.lastUpdatedBy,
    this.user,
  });

  int? id;
  int? userId;
  String? status;
  int? addedBy;
  int? lastUpdatedBy;
  User? user;

  factory LeadAgendModel.fromJson(Map<String, dynamic> json) => LeadAgendModel(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.employeeDetail,
  });

  int? id;
  String? name;
  String? email;
  String? imageUrl;
  EmployeeDetail? employeeDetail;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["image_url"],
        employeeDetail: json["employee_detail"] == null
            ? null
            : EmployeeDetail.fromJson(json["employee_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image_url": imageUrl,
        "employee_detail": employeeDetail?.toJson(),
      };
}

class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.userId,
    this.employeeId,
  });

  int? id;
  int? userId;
  String? employeeId;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
      };
}
