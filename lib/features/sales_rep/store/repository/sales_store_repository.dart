import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/models/productModel.dart';
import 'package:shopping_app/models/product_group.dart';

import '../../../../models/newProoductModel.dart';
import '../controller/sales_store_controller.dart';

final salesStoreRepositoryProvider = Provider(
  (ref) => SalesProductRepository(),
);

class SalesProductRepository {
  Future<List<NewProdutModel>> getProduct(
      BuildContext context, WidgetRef ref) async {
    try {
      List<NewProdutModel> newProductModel = [];
      final token = await getToken();

      http.Response response = await http.get(
          Uri.parse(
            'https://smonitor.onrender.com/api/product/list/',
          ),
          headers: <String, String>{
            'Authorization': 'Token $token',
          });
      // ignore: use_build_context_synchronously
      errorHandling(
        context: context,
        response: response,
        onSuccess: () async {
          // List<dynamic> data = jsonDecode(response.body);
          List<dynamic> data = jsonDecode(response.body);
          // print(data);
          String storeName = data[0]['product_store'];
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('storeName', storeName);

          if (data.isEmpty) {
            return null;
          } else {
            print(data);
            newProductModel.addAll(
              data
                  .map(
                    (e) => NewProdutModel.fromMap(e),
                  )
                  .toList(),
            );
            // print(newProductModel).;
          }
        },
      );
      return newProductModel;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return [];
  }

  List<Item> addToCart(
      {required BuildContext context,
      required String productName,
      required int amount,
      required List productId,
      required int quantity}) {
    try {
      Item item = Item(
        productId: productId,
        productName: productName,
        price: amount,
        quantity: quantity,
      );
      itemList.add(item);
      print(itemList);
      showSnackBar(context, 'Item successfully added');
      return itemList;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      print(e);
    }
    return itemList;
  }
}
