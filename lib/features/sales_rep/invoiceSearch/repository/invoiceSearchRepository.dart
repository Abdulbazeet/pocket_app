import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/models/invoiceModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final invoiceSearchRepositoryProvider =
    Provider((ref) => InvoiceSearchRepository());

class InvoiceSearchRepository {
  Future getInvoiceData({
    required String orderId,
    required TextEditingController controller,
  }) async {
    try {
      var token = await getToken();

      List<String> processControllerText(String controllerText) {
        // Remove spaces and commas from the end of the text.
        controllerText = controllerText.trim().replaceAll(RegExp(r",\s*$"), "");

        // Split the text into individual strings.
        final strings = controllerText.split(",");

        // Process each string and remove spaces.
        final processedStrings = <String>[];
        for (String string in strings) {
          // Check if there's only one string.
          if (strings.length == 1) {
            // Remove trailing comma if present.
            string = string.replaceAll(RegExp(r",\s*$"), "");
          }

          processedStrings.add(string.replaceAll(" ", ""));
        }

        return processedStrings;
      }

      var newIdList = processControllerText(controller.text);
      http.Response response = await http.post(
          Uri.parse('https://smonitor.onrender.com/api/product/search'),
          body: jsonEncode({"productIds": newIdList}),
          headers: <String, String>{
            "Authorization": "Token $token",
            'Content-Type': 'application/json',
          });
      print('object');
      print(response.body);
      if (response.statusCode == 200) {
        PRODUCTID = jsonDecode(response.body);
        // print(PRODUCTID.length);
        // print(PRODUCTID[0]['Res']);
        return PRODUCTID;
      } else {
        return [];
      }
    } catch (e) {
      print('2');
      print(e.toString());
      print('object');
    }
  }

  Future getData(
      {required BuildContext context, required String orderid}) async {
    try {
      var token = await getToken();

      http.Response response = await http.get(
          Uri.parse(
              'https://smonitor.onrender.com/api/invoice-product/$orderid/'),
          headers: <String, String>{
            "Authorization": "Token $token",
            // 'Content-Type': 'application/json',
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
