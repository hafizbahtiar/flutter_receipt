import 'dart:convert';

class IncomeModel {
  final int? id;
  final int categoryId;
  final double amount;
  final String? description;
  final String? createdAt;

  IncomeModel({
    this.id,
    required this.categoryId,
    required this.amount,
    this.description,
    this.createdAt,
  });

  IncomeModel copyWith({
    int? id,
    int? categoryId,
    double? amount,
    String? description,
    String? createdAt,
  }) =>
      IncomeModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );

  factory IncomeModel.fromRawJson(String str) => IncomeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        id: json["id"],
        categoryId: json["category_id"],
        amount: json["amount"]?.toDouble(),
        description: json["description"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "amount": amount,
        "description": description,
        "created_at": createdAt,
      };
}
