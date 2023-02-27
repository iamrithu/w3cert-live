// To parse this JSON data, do
//
//     final leadCountryModel = leadCountryModelFromJson(jsonString);

import 'dart:convert';

LeadCountryModel leadCountryModelFromJson(String str) =>
    LeadCountryModel.fromJson(json.decode(str));

String leadCountryModelToJson(LeadCountryModel data) =>
    json.encode(data.toJson());

class LeadCountryModel {
  LeadCountryModel({
    this.id,
    this.iso,
    this.name,
    this.nicename,
    this.iso3,
    this.numcode,
    this.phonecode,
  });

  int? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  int? numcode;
  int? phonecode;

  factory LeadCountryModel.fromJson(Map<String, dynamic> json) =>
      LeadCountryModel(
        id: json["id"],
        iso: json["iso"],
        name: json["name"],
        nicename: json["nicename"],
        iso3: json["iso3"],
        numcode: json["numcode"],
        phonecode: json["phonecode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "iso": iso,
        "name": name,
        "nicename": nicename,
        "iso3": iso3,
        "numcode": numcode,
        "phonecode": phonecode,
      };
}
