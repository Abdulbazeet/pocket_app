// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../common/utils.dart';

final homeepositoryProvider = Provider(
  (ref) => HomeRepository(),
);

class HomeRepository {
  Future<String?> getRevenue() async {
    try {
      String? token = await getToken();

      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/order/total_revenue/'),
        headers: <String, String>{'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['Total'];
        print(data);
        return data.toString();
      } else {
        return '';
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future<String?> getOrders() async {
    try {
      String? token = await getToken();

      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/order/total/'),
        headers: <String, String>{'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['Total'];
        print(data);
        return data.toString();
      } else {
        return '';
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future<String?> getRep() async {
    try {
      String? token = await getToken();

      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/store/total/'),
        headers: <String, String>{'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['Total'];
        print(data);
        return data.toString();
      } else {
        return '';
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future<String?> getOrderBalance() async {
    try {
      String? token = await getToken();

      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/order/balance/'),
        headers: <String, String>{'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['Total'];
        print(data);
        return data.toString();
      } else {
        return '';
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future searchProduct(
      {required List productID, required BuildContext context}) async {
    try {
      String? token = await getToken();
      var headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
        'X-API-Key': 'token'
      };
      var request = http.Request('POST',
          Uri.parse('https://smonitor.onrender.com/api/product/search'));
      request.body = json.encode({"productIds": productID});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        productSearchData = jsonMap;

        // for (int i = 0; i < jsonMap.length; i++) {
        //   var product = jsonMap[i];
        //   if (product.containsKey("Res")) {
        //     // Replace the dictionary at index i with a default product dictionary
        //     jsonMap[i] = {
        //       "productName": "",
        //       "imgUrl": "",
        //       "productId": "",
        //       "productPrice": 0,
        //       "productQuantity": 0
        //     };
        //   }
        // }
        if (jsonMap != null || jsonMap != []) {
          return jsonMap;
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
