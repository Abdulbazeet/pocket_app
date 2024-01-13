import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvoiceModel {
  final String productName;
  final List productId;
  final String productImageURL;
  final double productPrice;
  final int productQuantity;
  final String productTime;
  InvoiceModel({
    required this.productName,
    required this.productImageURL,
    required this.productPrice,
    required this.productQuantity,
    required this.productTime,
    required  this.productId,

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
      productImageURL: map['productImageURL'] as String,
      productPrice: map['productPrice'],
      productQuantity: map['productQuantity'],
      productTime: map['productTime'] as String,
       productId: List.from(
        (map['productId'] as List),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
