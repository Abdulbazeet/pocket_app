import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchModel {
  final String productName;
  final String imgUrl;
  final String productId;
  final String productPrice;
  final String productQuantity;
  SearchModel({
    required this.productName,
    required this.imgUrl,
    required this.productId,
    required this.productPrice,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'imgUrl': imgUrl,
      'productId': productId,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      productName: map['productName'] as String,
      imgUrl: map['imgUrl'] as String,
      productId: map['productId'] as String,
      productPrice: map['productPrice'] as String,
      productQuantity: map['productQuantity'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) =>
      SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
