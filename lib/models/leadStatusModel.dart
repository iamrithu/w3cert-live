// To parse this JSON data, do
//
//     final leadStatusModel = leadStatusModelFromJson(jsonString);

import 'dart:convert';

LeadStatusModel leadStatusModelFromJson(String str) =>
    LeadStatusModel.fromJson(json.decode(str));

String leadStatusModelToJson(LeadStatusModel data) =>
    json.encode(data.toJson());

class LeadStatusModel {
  LeadStatusModel({
    this.id,
    this.type,
    this.priority,
    this.leadStatusModelDefault,
    this.labelColor,
  });

  int? id;
  String? type;
  int? priority;
  int? leadStatusModelDefault;
  String? labelColor;

  factory LeadStatusModel.fromJson(Map<String, dynamic> json) =>
      LeadStatusModel(
        id: json["id"],
        type: json["type"],
        priority: json["priority"],
        leadStatusModelDefault: json["default"],
        labelColor: json["label_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "priority": priority,
        "default": leadStatusModelDefault,
        "label_color": labelColor,
      };
}
