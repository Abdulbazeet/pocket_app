// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final int id;
  final String product_name;
  final String img_url;
  final List product_id;
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
      'quantity': quantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: map['id'] as int,
        product_name: map['product_name'] ,
        img_url: map['img_url'] ,
        product_id: List.from(
          (map['product_id'] ),
        ),
        price: map['price'] as double,
        store_name: map['store_name'] as String,
        quantity: map['quantity'] != null ? map['quantity'] as int : null);
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
