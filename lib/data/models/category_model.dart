import 'dart:convert';

class CategoryModel {
  final int? id;
  final int? parentId;
  final String name;
  final String? createdAt;

  CategoryModel({
    this.id,
    this.parentId,
    required this.name,
    this.createdAt,
  });

  CategoryModel copyWith({
    int? id,
    int? parentId,
    String? name,
    String? createdAt,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "created_at": createdAt,
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
      'createdAt': createdAt,
    };
  }
}
