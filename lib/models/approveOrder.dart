// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Approve {
  final int order_id;
  final String status;
  Approve({
    required this.order_id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': order_id,
      'status': status,
    };
  }

  factory Approve.fromMap(Map<String, dynamic> map) {
    return Approve(
      order_id: map['order_id'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Approve.fromJson(String source) =>
      Approve.fromMap(json.decode(source) as Map<String, dynamic>);
}
