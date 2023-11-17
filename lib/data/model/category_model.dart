import 'dart:convert';

class CategoryModel {
    final int id;
    final String category;
    final String description;
    final dynamic createdAt;
    final dynamic updatedAt;

    CategoryModel({
        required this.id,
        required this.category,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        category: json["category"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
