import 'dart:convert';

import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/models/invoiceModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final invoiceSearchRepositoryProvider =
    Provider((ref) => InvoiceSearchRepository());

class InvoiceSearchRepository {
  Future<List<InvoiceModel>> getInvoiceData({
    required String orderId,
  }) async {
    try {
      List<InvoiceModel> invoiceModel = [];
      var token = await getToken();
      http.Response response = await http.get(
          Uri.parse(
              'https://smonitor.onrender.com/api/invoice-product/TP$orderId/'),
          headers: <String, String>{
            'Authorization': 'Token $token',
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);

        if (data != null || data != []) {
          for (var item in data) {
            invoiceModel.add(
              InvoiceModel.fromMap(item),
            );
          }
          return invoiceModel;
        } else {
          print(jsonDecode(response.body));
          return [];
        }
      } else {
        print(jsonDecode(response.body));

        return [];
      }
    } catch (e) {
      print(e.toString());
      print(e);
      return [];
    }
  }
}
