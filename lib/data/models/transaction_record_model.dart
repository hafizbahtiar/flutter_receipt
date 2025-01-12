import 'dart:convert';

class TransactionRecordModel {
  final int? id;
  final int categoryId;
  final int transactionTypeId;
  final String transactionTypeName;
  final String name;
  final double amount;
  final String? description;
  final String? createdAt;

  TransactionRecordModel({
    this.id,
    required this.categoryId,
    required this.transactionTypeId,
    required this.transactionTypeName,
    required this.name,
    required this.amount,
    this.description,
    this.createdAt,
  });

  TransactionRecordModel copyWith({
    int? id,
    int? categoryId,
    int? transactionTypeId,
    String? transactionTypeName,
    String? name,
    double? amount,
    String? description,
    String? createdAt,
  }) =>
      TransactionRecordModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        transactionTypeId: transactionTypeId ?? this.transactionTypeId,
        transactionTypeName: transactionTypeName ?? this.transactionTypeName,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TransactionRecordModel.fromRawJson(String str) => TransactionRecordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionRecordModel.fromJson(Map<String, dynamic> json) => TransactionRecordModel(
        id: json["id"],
        categoryId: json["category_id"],
        transactionTypeId: json["transaction_type_id"],
        transactionTypeName: json["transaction_type_name"],
        name: json["name"],
        amount: json["amount"]?.toDouble(),
        description: json["description"] ?? '',
        createdAt: json["created_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "transaction_type_id": transactionTypeId,
        "transaction_type_name": transactionTypeName,
        "name": name,
        "amount": amount,
        "description": description,
        "created_at": createdAt,
      };
}
