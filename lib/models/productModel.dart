// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final int id;
  final String product_name;
  final String img_url;
  final String product_id;
  final double price;
  final String store_name;
  final int? quantity;
  ProductModel({
    required this.id,
    required this.product_name,
    required this.img_url,
    required this.product_id,
    required this.price,
    required this.store_name,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_name': product_name,
      'img_url': img_url,
      'product_id': product_id,
      'price': price,
      'store_name': store_name,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      quantity: map['quantity'],
      id: map['id'] as int,
      product_name: map['product_name'] as String,
      img_url: map['img_url'] as String,
      product_id: map['product_id'] as String,
      price: map['price'] as double,
      store_name: map['store_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
