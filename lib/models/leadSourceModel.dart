// To parse this JSON data, do
//
//     final LeadSourceModel = LeadSourceModelFromJson(jsonString);

import 'dart:convert';

LeadSourceModel LeadSourceModelFromJson(String str) =>
    LeadSourceModel.fromJson(json.decode(str));

String LeadSourceModelToJson(LeadSourceModel data) =>
    json.encode(data.toJson());

class LeadSourceModel {
  LeadSourceModel({
    this.id,
    this.type,
    this.addedBy,
    this.lastUpdatedBy,
  });

  int? id;
  String? type;
  dynamic addedBy;
  dynamic lastUpdatedBy;

  factory LeadSourceModel.fromJson(Map<String, dynamic> json) =>
      LeadSourceModel(
        id: json["id"],
        type: json["type"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
      };
}
