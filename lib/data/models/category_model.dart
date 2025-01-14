import 'dart:convert';

class CategoryModel {
  final int? id;
  final int? parentId;
  final int transactionTypeId;
  final String transactionTypeName;
  final String name;
  final String? createdAt;

  CategoryModel({
    this.id,
    this.parentId,
    required this.transactionTypeId,
    required this.transactionTypeName,
    required this.name,
    this.createdAt,
  });

  CategoryModel copyWith({
    int? id,
    int? parentId,
    int? transactionTypeId,
    String? transactionTypeName,
    String? name,
    String? createdAt,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        transactionTypeId: transactionTypeId ?? this.transactionTypeId,
        transactionTypeName: transactionTypeName ?? this.transactionTypeName,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        parentId: json["parent_id"],
        transactionTypeId: json["transaction_type_id"],
        transactionTypeName: json["transaction_type_name"] ?? '',
        name: json["name"] ?? '',
        createdAt: json["created_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "transaction_type_id": transactionTypeId,
        "transaction_type_name": transactionTypeName,
        "name": name,
        "created_at": createdAt,
      };
}
