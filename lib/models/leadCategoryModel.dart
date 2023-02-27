// To parse this JSON data, do
//
//     final leadCategoryModel = leadCategoryModelFromJson(jsonString);

import 'dart:convert';

LeadCategoryModel leadCategoryModelFromJson(String str) =>
    LeadCategoryModel.fromJson(json.decode(str));

String leadCategoryModelToJson(LeadCategoryModel data) =>
    json.encode(data.toJson());

class LeadCategoryModel {
  LeadCategoryModel({
    this.id,
    this.categoryName,
    this.addedBy,
    this.lastUpdatedBy,
  });

  int? id;
  String? categoryName;
  int? addedBy;
  int? lastUpdatedBy;

  factory LeadCategoryModel.fromJson(Map<String, dynamic> json) =>
      LeadCategoryModel(
        id: json["id"],
        categoryName: json["category_name"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
      };
}
