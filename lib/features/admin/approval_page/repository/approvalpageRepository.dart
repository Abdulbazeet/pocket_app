// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/models/approveOrder.dart';
import 'package:shopping_app/models/order.dart';
import 'package:url_launcher/url_launcher.dart';

final approvalpageRepositoryProvider = Provider(
  (ref) => ApprovalPageRepository(),
);

class ApprovalPageRepository {
  Future<List<Order>> getAllOrders({
    required BuildContext context,
  }) async {
    try {
      List<Order> allOrders = [];
      var token = await getToken();
      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/order/list/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      errorHandling(
        context: context,
        response: response,
        onSuccess: () {
          List<dynamic> data = jsonDecode(
            response.body,
          );
          print(data);

          if (data != null || data.isNotEmpty) {
            for (var order in data) {
              if (order['order_status'] != "approved" &&
                  order['order_status'] != "declined") {
                allOrders.add(
                  Order.fromMap(order),
                );
                print(order);
                print('object');
              }
            }
          } else {
            print('null');
            return null;
          }
        },
      );
      return allOrders;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return [];
  }

  void approveOrder({
    required BuildContext context,
    required int order_id,
  }) async {
    try {
      var token = await getToken();
      Approve approve = Approve(order_id: order_id, status: 'accepted');
      http.Response response = await http.post(
        Uri.parse(
          'https://smonitor.onrender.com/api/order/status/update/',
        ),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
        body: {"order_id": order_id.toString(), "status": "approved"},
      );
      errorHandling(
          context: context,
          response: response,
          onSuccess: () async {
            showSnackBar(
                context, 'Order of orderId $order_id has been approved');

            if (await canLaunchUrl(Uri.parse(
                'https://smonitor.onrender.com/api/order/report/$order_id/download/Reciept'))) {
              await launchUrl(Uri.parse(
                  'https://smonitor.onrender.com/api/order/report/$order_id/download/Reciept'));
            } else {
              showSnackBar(context, 'Error In generatig receipt');
            }
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      print(e);
    }
  }

  void declineOrder({
    required BuildContext context,
    required int order_id,
  }) async {
    try {
      var token = await getToken();
      http.Response response = await http.post(
        Uri.parse(
          'https://smonitor.onrender.com/api/order/status/update/',
        ),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
        body: {"order_id": order_id.toString(), "status": 'declined'},
      );
      // print(jsonDecode(response.body));
      print(response.statusCode);
      errorHandling(
          context: context,
          response: response,
          onSuccess: () {
            showSnackBar(
                context, 'Order of orderId $order_id has been declined');
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      print(e);
    }
  }

  void restoreStatus({
    required BuildContext context,
    required int order_id,
  }) async {
    try {
      var token = await getToken();
      Approve approve = Approve(order_id: order_id, status: 'pending');
      http.Response response = await http.post(
        Uri.parse(
          'https://smonitor.onrender.com/api/order/status/update/',
        ),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
        body: {"order_id": order_id.toString(), "status": "pending"},
      );
      errorHandling(
          context: context,
          response: response,
          onSuccess: () {
            showSnackBar(context,
                'Order of orderId $order_id has been added to new orders');
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      print(e);
    }
  }

  Future<List<Order>> getApprovedOrders({
    required BuildContext context,
  }) async {
    try {
      List<Order> allOrders = [];
      var token = await getToken();
      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/order/list/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      errorHandling(
        context: context,
        response: response,
        onSuccess: () {
          List<dynamic> data = jsonDecode(
            response.body,
          );
          print(data);

          if (data != null || data.isNotEmpty) {
            for (var order in data) {
              if (order['order_status'] == 'approved') {
                allOrders.add(
                  Order.fromMap(order),
                );
                print(order);
                print('object');
              }
            }
          } else {
            print('null');
            return null;
          }
        },
      );
      return allOrders;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return [];
  }

  Future<List<Order>> getDeclined({
    required BuildContext context,
  }) async {
    try {
      List<Order> allOrders = [];
      var token = await getToken();
      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/order/list/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      errorHandling(
        context: context,
        response: response,
        onSuccess: () {
          List<dynamic> data = jsonDecode(
            response.body,
          );
          print(data);

          if (data != null || data.isNotEmpty) {
            for (var order in data) {
              if (order['order_status'] == 'declined') {
                allOrders.add(
                  Order.fromMap(order),
                );
                print(order);
                print('object');
              }
            }
          } else {
            print('null');
            return null;
          }
        },
      );
      return allOrders;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return [];
  }
}
