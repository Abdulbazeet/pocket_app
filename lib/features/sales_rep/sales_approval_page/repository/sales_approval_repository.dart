import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/models/order.dart';

final salesRepositoryProvider = Provider(
  (ref) => SalesRepository(),
);

class SalesRepository {
  Future<List<Order>> getallOrders({required BuildContext context}) async {
    try {
      List<Order> allOrders = [];

      final token = await getToken();

      http.Response response = await http.get(
          Uri.parse('https://smonitor.onrender.com/api/order/list/'),
          headers: <String, String>{
            'Authorization': 'Token 93f6b835b62dc71bab5c28c6b666231a230f1d15',
          });
      if (response.statusCode == 200) {
        http.Response res = await http.get(
          Uri.parse('https://smonitor.onrender.com/api/product/list/'),
          headers: <String, String>{
            'Authorization': 'Token $token',
          },
        );
        if (res.statusCode == 200) {
          for (var items in jsonDecode(response.body)) {
            if (items['store'] == jsonDecode(res.body)[0]['product_store_id']) {
              allOrders.add(Order.fromMap(items));
              print(items);
            }
          }
          // print('objectsssssssssssss');
          // print(jsonDecode(response.body));
          // print(jsonDecode(res.body));
        } else {
          return [];
        }
      } else {
        return [];
      }
      return allOrders;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
