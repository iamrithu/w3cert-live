class CategoryModel {
  CategoryModel({
    this.id,
    this.categoryName,
    this.addedBy,
    this.lastUpdatedBy,
  });

  int? id;
  String? categoryName;
  int? addedBy;
  int? lastUpdatedBy;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
