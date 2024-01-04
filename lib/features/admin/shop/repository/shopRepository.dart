// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/models/productModel.dart';
import 'package:shopping_app/models/store2model.dart';
import 'package:sizer/sizer.dart';

import '../../../../models/order.dart';

final storeRepositoryProvider = Provider(
  (ref) => AdminStoreRepository(),
);

class AdminStoreRepository {
  Future<List<Store2Model>> getStores(
      BuildContext context, WidgetRef ref) async {
    try {
      List<Store2Model> storeModel = [];
      final token = await getToken();

      http.Response response = await http.get(
          Uri.parse(
            'https://smonitor.onrender.com/api/store/list/',
          ),
          headers: <String, String>{
            'Authorization': 'Token $token',
          });
      // ignore: use_build_context_synchronously
      errorHandling(
        context: context,
        response: response,
        onSuccess: () {
          List<dynamic> data = jsonDecode(response.body);

          if (data.isEmpty) {
            return null;
          } else {
            storeModel.addAll(
              data
                  .map(
                    (e) => Store2Model.fromMap(e),
                  )
                  .toList(),
            );
          }
        },
      );
      return storeModel;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return [];
  }

  //Produts
  Future<List<ProductModel>> getProduct(
      BuildContext context, WidgetRef ref, String storeName) async {
    try {
      List<ProductModel> productModel = [];
      final token = await getToken();

      http.Response response = await http.get(
          Uri.parse(
            'https://smonitor.onrender.com/api/product/all/list/v1/',
          ),
          headers: <String, String>{
            'Authorization': 'Token $token',
          });
      // ignore: use_build_context_synchronously
      errorHandling(
        context: context,
        response: response,
        onSuccess: () {
          // List<dynamic> data = jsonDecode(response.body);
          List<dynamic> data = jsonDecode(response.body);
          print(data);

          if (data.isEmpty) {
            return null;
          } else {
            for (var newData in data) {
              if (newData['store_name'] == storeName) {
                // productModel.addAll(data.map((e) => ProductModel.fromMap(e)));
                productModel.add(ProductModel.fromMap(newData));
              }
            }
            // productModel.addAll(
            //   data
            //       .map(
            //         (e) => ProductModel.fromMap(e),
            //       )
            //       .toList(),
            // );
          }
        },
      );
      return productModel;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return [];
  }

  void editStore({
    required BuildContext context,
    required String storename,
    required int id,
    required File? image,
    required String repname,
    required String secondAddress,
    required String number,
    required String secondNumber,
    required String storeAddress,
  }) async {
    try {
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
      final token = await getToken();
      final name = await getName();

      var headers = {
        'X-API-Key': 'Token $token',
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://api.cloudinary.com/v1_1/smonitor/image/upload'));
      request.fields
          .addAll({'upload_preset': 'smonitor_', 'api_key': '591373175821121'});
      request.files.add(await http.MultipartFile.fromPath('file', image!.path));
      request.headers.addAll(headers);

      http.StreamedResponse imageUrl = await request.send();

      if (imageUrl.statusCode == 200) {
        print('CAN O $imageUrl.request');
        final responseData = await imageUrl.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final imageURL = jsonMap['url'];
        print('success');

        http.Response response = await http.post(
            Uri.parse(
              'https://smonitor.onrender.com/api/store/edit/',
            ),
            headers: <String, String>{
              'Authorization': 'Token $token',
            },
            body: {
              "store_id": id
                  .toString(), // Store ID. can get from list of stores api, data_type: int
              "user": repname, // Store New User's username, data_type: str
              "name": storename, // Store New Name, data_type: str
              "img_url":
                  imageURL, // Store New image url, data_type: str, must be a url
              "main_address":
                  storeAddress, // Store New Main Address, data_type: str
              "main_phone_no":
                  number, // Store New Main Phone no, data_type: str
              "id": 1.toString(),
              "sec_address":
                  secondAddress, // Store New Secondary Address, data_type: str
              "sec_phone_no":
                  secondNumber // Store New Secondary Phone no, data_type: str
            });
        errorHandling(
            context: context,
            response: response,
            onSuccess: () {
              Navigator.pop(context);
              showSnackBar(context, jsonDecode(response.body)['Response']);
            });
      } else {
        Navigator.pop(context);
        showSnackBar(context, 'Image Processing error');
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteProduct(
      {required String id, required BuildContext context}) async {
    try {
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
      final token = await getToken();

      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/product/$id/delete/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      errorHandling(
          context: context,
          response: response,
          onSuccess: () {
            Navigator.pop(context);
            showSnackBar(context, jsonDecode(response.body)['Response']);
          });
    } catch (e) {
      print(e);
    }
  }

  void deleteStore({required String id, required BuildContext context}) async {
    try {
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
      final token = await getToken();

      http.Response response = await http.get(
        Uri.parse('https://smonitor.onrender.com/api/store/$id/delete/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      errorHandling(
          context: context,
          response: response,
          onSuccess: () {
            Navigator.pop(context);
            showSnackBar(context, jsonDecode(response.body)['Response']);
          });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Order>> getApprovedOrders({
    required BuildContext context,
    required String id,
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
          // print(data);

          if (data != null || data.isNotEmpty || data != []) {
            for (var order in data) {
              if (order['order_status'] == 'approved' &&
                  order['store'] == int.parse(id)) {
                allOrders.add(
                  Order.fromMap(order),
                );
                print('object');

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
    print('gggaggagag');
    return [];
  }

  void updateProduct(
      {required String storeId,
      required File? img_url,
      required String name,
      required String productId,
      required String price,
      required String quantity,
      required BuildContext context}) async {
    try {
      var itemNumber;
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
      var token = await getToken();
      http.Response req = await http.get(
          Uri.parse('https://smonitor.onrender.com/api/product/all/list/'),
          headers: <String, String>{
            'Authorization': 'Token $token',
          });

      var data = jsonDecode(req.body);
      for (var item in data) {
        if (item['productId'] == productId) {
          itemNumber = item['store'];
        }
      }
      print(itemNumber);

      if (req.statusCode == 200) {
        var headers = {
          'X-API-Key': 'Token $token',
        };
        var request = http.MultipartRequest('POST',
            Uri.parse('https://api.cloudinary.com/v1_1/smonitor/image/upload'));
        request.fields.addAll(
            {'upload_preset': 'smonitor_', 'api_key': '591373175821121'});
        request.files
            .add(await http.MultipartFile.fromPath('file', img_url!.path));
        request.headers.addAll(headers);

        http.StreamedResponse imageUrl = await request.send();

        if (imageUrl.statusCode == 200) {
          print('CAN O $imageUrl.request');
          final responseData = await imageUrl.stream.toBytes();
          final responseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(responseString);
          final imageURL = jsonMap['url'];
          print('success');
          http.Response response = await http.post(
              Uri.parse('https://smonitor.onrender.com/api/product/update/'),
              headers: <String, String>{
                'Authorization': 'Token $token',
              },
              body: ({
                "store_id": itemNumber.toString(), // shop id,  data_type = int
                "img_url":
                    imageURL, // shop image url, must be an url,  data_type = string
                "name": name, // product name,  data_type = string
                "productId":
                    productId, // product designated ID,  data_type = string
                "price": price
                    .toString(), // product price,  data_type = float/decimal
                "id": 1.toString(),
                "quantity":
                    quantity.toString() // product quantity,  data_type = int
              }));
          if (response.statusCode == 200) {
            Navigator.pop(context);
            showSnackBar(context, 'Prooduct Updated Successfully');
          } else {
            print(2);
            Navigator.pop(context);
            showSnackBar(
              context,
              'Error in updating product',
            );
          }
        }
        {}
      } else {
        print(3);
        Navigator.pop(context);
        print(req.statusCode);
      }
    } catch (e) {
      print(4);
      Navigator.pop(context);

      showSnackBar(context, 'Error inprocessing data');

      // showSnackBar(context, e.toString());
      print(e);
    }
  }
}
