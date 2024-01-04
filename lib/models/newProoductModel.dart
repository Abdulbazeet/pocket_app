// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewProdutModel {
  final String product_id;
  final String prdouct_name;
  final String product_image_url;
  final double product_price;
  final String product_store;
  final int product_quantity;
  NewProdutModel({
    required this.product_id,
    required this.prdouct_name,
    required this.product_image_url,
    required this.product_price,
    required this.product_store,
    required this.product_quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': product_id,
      'prdouct_name': prdouct_name,
      'product_image_url': product_image_url,
      'product_price': product_price,
      'product_store': product_store,
      'product_quantity': product_quantity,
    };
  }

  factory NewProdutModel.fromMap(Map<String, dynamic> map) {
    return NewProdutModel(
      product_id: map['product_id'] as String,
      prdouct_name: map['prdouct_name'] as String,
      product_image_url: map['product_image_url'] as String,
      product_price: map['product_price'] as double,
      product_store: map['product_store'] as String,
      product_quantity: map['product_quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewProdutModel.fromJson(String source) =>
      NewProdutModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
