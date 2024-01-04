import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvoiceModel {
  final String productName;
  final String productId;
  final String productImageURL;
  final double productPrice;
  final int productQuantity;
  final String productTime;
  InvoiceModel({
    required this.productName,
    required this.productId,
    required this.productImageURL,
    required this.productPrice,
    required this.productQuantity,
    required this.productTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productId': productId,
      'productImageURL': productImageURL,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productTime': productTime,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      productName: map['productName'] as String,
      productId: map['productId'] as String,
      productImageURL: map['productImageURL'] as String,
      productPrice: map['productPrice'],
      productQuantity: map['productQuantity'],
      productTime: map['productTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
