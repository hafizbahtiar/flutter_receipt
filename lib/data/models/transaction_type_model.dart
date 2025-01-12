import 'dart:convert';

class TransactionTypeModel {
  final int id;
  final String name;
  final String createdAt;

  TransactionTypeModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  TransactionTypeModel copyWith({
    int? id,
    String? name,
    String? createdAt,
  }) =>
      TransactionTypeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TransactionTypeModel.fromRawJson(String str) => TransactionTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionTypeModel.fromJson(Map<String, dynamic> json) => TransactionTypeModel(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
      };
}
