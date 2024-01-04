import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cart {
  final String customerName;
  final String orderId;
  final String amount;
  final List<Item> productGroup;
  Cart({
    required this.customerName,
    required this.orderId,
    required this.amount,
    required this.productGroup,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerName': customerName,
      'orderId': orderId,
      'amount': amount,
      'productGroup': productGroup.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      customerName: map['customerName'] as String,
      orderId: map['orderId'] as String,
      amount: map['amount'] as String,
      productGroup: List<Item>.from(
        (map['productGroup'] as List<int>).map<Item>(
          (x) => Item.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Item {
  // final String? image;
  final String productName;
  String productId;
  final int price;
  final int quantity;
  Item({
    required this.productName,
    required this.productId,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productId': productId,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      productName: map['productName'] as String,
      productId: map['productId'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);
}
