import 'dart:convert';

class TransactionImageModel {
  final int? id;
  final int transactionId;
  final List<int> image;
  final String? createdAt;

  TransactionImageModel({
    this.id,
    required this.transactionId,
    required this.image,
    this.createdAt,
  });

  TransactionImageModel copyWith({
    int? id,
    int? transactionId,
    List<int>? image,
    String? createdAt,
  }) {
    return TransactionImageModel(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TransactionImageModel.fromRawJson(String str) => TransactionImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionImageModel.fromJson(Map<String, dynamic> json) => TransactionImageModel(
        id: json["id"],
        transactionId: json["transaction_id"],
        image: (json["image"] as List<dynamic>).cast<int>(),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "image": image,
        "created_at": createdAt,
      };
}
