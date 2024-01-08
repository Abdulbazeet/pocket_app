// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/features/sales_rep/receipt/screens/receipt.dart';
import 'package:shopping_app/models/product_group.dart';
import 'package:sizer/sizer.dart';

final cartRepositoryProvider = Provider(
  (ref) => CartRepository(),
);

class CartRepository {
  void uploadCart({
    required BuildContext context,
    required int orderId,
    required String customerName,
    required String customerLocation,
    required String customerPhoneNo,
    required String hasDeliveryCharge,
    required String deliveryCharge,
    // required List productIds,
    required String bankTransf,
    required String officePhoneNo,
    required int price,
  }) async {
    try {
      var newItemList = [];
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 40.sp,
              width: 40.sp,
              child: const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          );
        },
      );
      String? token = await getToken();
      String? name = await getName();

      // for (int i = 0; i < itemList.length; i++) {
      //   itemList[i].productId = [];
      //   itemList[i].productId = productIdStrings[i];
      //   newItemList.add(itemList[i]);
      // }
      var headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
        'X-API-Key': '{{token}}'
      };
      print(itemList);
      var request = http.Request(
        'POST',
        Uri.parse('https://smonitor.onrender.com/api/order/report/'),
      );

      request.body = json.encode({
        "customerLocation": customerLocation,
        "customerPhoneNo": customerPhoneNo,
        "officePhoneNo": 2348162487349,
        "hasDeliveryCharge": hasDeliveryCharge,
        "deliveryCharge": deliveryCharge,
        "bankTransf": bankTransf,
        "customerName": customerName,
        "orderId": orderId.toString(),
        "paymentRefAmt": 0.toString(),
        "paymentRef": 'debt',
        "amount": price,
        "product_group": [itemList]
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      print(jsonMap);


      if (response.statusCode == 200) {
        print('Order placed');
        print('object');
        // showSnackBar(context, jsonMap);

        http.Response newResponse = await http.get(
            Uri.parse('https://smonitor.onrender.com/api/invoice/TP$orderId/'),
            headers: <String, String>{'Authorization': 'Token $token'});
        if (newResponse.statusCode == 200) {
          var data = jsonDecode(newResponse.body);
          print(data);
          receipt = data;
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReceiptPage(
                  salesRep: name!,
                ),
              ));
          itemList = [];
          // itemList = [];
        } else {
          itemList = [];

          Navigator.pop(context);
          print('naah');

          showSnackBar(context, 'Error generating Receipt');
        }
      } else {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        showSnackBar(context, 'Error placing order');
        print(jsonMap);
        print(response.statusCode);

        Navigator.pop(context);

        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
      print('naope');
      Navigator.pop(context);
    }
  }
}
