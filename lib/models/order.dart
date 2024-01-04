import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Order {
  final int? id;
  final String customer_name;
  final String order_id;
  final String amount;
  final String orderStatus;
  final String timestamp;
  final int? store;
  final List products;
  // final DateTime time;
  Order({
    required this.id,
    required this.customer_name,
    required this.order_id,
    required this.amount,
    required this.orderStatus,
    required this.timestamp,
    required this.store,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customer_name': customer_name,
      'order_id': order_id,
      'amount': amount,
      'orderStatus': orderStatus,
      'store': store,
      'products': products,
      // 'time': time.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      // time: DateTime.fromMillisecondsSinceEpoch(
      //   map['time'],
      // ),
      timestamp: map['timestamp'],
      id: map['id'] as int?,
      customer_name: map['customer_name'] ?? '',
      order_id: map['order_id'],
      amount: map['amount'],
      orderStatus: map['order_status'] ?? '',
      store: map['store'] as int?,
      products: List.from(
        (map['products'] ?? []),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
