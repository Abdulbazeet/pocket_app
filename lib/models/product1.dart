import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product1Model {
  final String store_id;
  final String name;
  final String price;
  final String image_url;
  Product1Model({
    required this.store_id,
    required this.name,
    required this.price,
    required this.image_url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'store_id': store_id,
      'name': name,
      'price': price,
      'image_url': image_url,
    };
  }

  factory Product1Model.fromMap(Map<String, dynamic> map) {
    return Product1Model(
      store_id: map['store_id'],
      name: map['name'] ?? '',
      price: map['price'],
      image_url: map['image_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product1Model.fromJson(String source) =>
      Product1Model.fromMap(json.decode(source) as Map<String, dynamic>);
}
