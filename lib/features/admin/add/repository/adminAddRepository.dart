// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/userProvider.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/models/product1.dart';
import 'package:shopping_app/models/storeModels.dart';
import 'package:http/http.dart' as http;

final adminAddRepositoryProvider = Provider(
  (ref) => AdminAddRepository(),
);

class AdminAddRepository {
  void createStore({
    required BuildContext context,
    required WidgetRef ref,
    required String storename,
    required String username,
    required String email,
    required String password,
    required String storeaddress,
    required File? image,
    required String storePhoneNumber,
    required String secondNumber,
    required String secondAddress,
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

      // var username = await getName();
      http.Response user = await http.post(
          Uri.parse('https://smonitor.onrender.com/api/register/'),
          body: {"username": username, "email": email, "password": password});
      var token = await getToken();
      var data = jsonDecode(user.body);
      if (user.statusCode == 200) {
//add image

        var headers = {
          'X-API-Key': 'Token $token',
        };
        var request = http.MultipartRequest('POST',
            Uri.parse('https://api.cloudinary.com/v1_1/smonitor/image/upload'));
        request.fields.addAll(
            {'upload_preset': 'smonitor_', 'api_key': '591373175821121'});
        request.files
            .add(await http.MultipartFile.fromPath('file', image!.path));
        request.headers.addAll(headers);

        http.StreamedResponse imageUrl = await request.send();

        if (imageUrl.statusCode == 200) {
          print('CAN O $imageUrl.request');
          final responseData = await imageUrl.stream.toBytes();
          final responseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(responseString);
          final imageURL = jsonMap['url'];
          print('success');

          StoreModel storeModel = StoreModel(
              storeSecAddress: secondAddress,
              storeSecPhoneNo: secondNumber,
              username: username,
              storeName: storename,
              storeMainAddress: storeaddress,
              storeLogoUrl: imageURL,
              storeMainPhoneNo: storePhoneNumber);
          http.Response response = await http.post(
              Uri.parse(
                'https://smonitor.onrender.com/api/store/create/',
              ),
              body: storeModel.toMap(),
              headers: <String, String>{
                'Authorization': 'Token $token',
              });
          errorHandling(
            context: context,
            response: response,
            onSuccess: () {
              Navigator.pop(context);
              showSnackBar(context, jsonDecode(response.body)['Response']);
            },
          );
        } else {
          Navigator.pop(context);
          showSnackBar(context, 'Error occurred while processing image');
        }

        // StoreModel storeModel = StoreModel(
        //   username: username,
        //   store_name: storename,
        //   store_address: storeaddress,
        // );
      } else if (user.statusCode == 400) {
        Navigator.pop(context);
        showSnackBar(context, user.body);
      }
    } catch (e) {
      Navigator.pop(context);

      showSnackBar(
        context,
        e.toString(),
      );
      print(e);
    }
  }

  ///product
  ///
  ///
  Future<void> createProduct({
    required BuildContext context,
    required WidgetRef ref,
    required int storeId,
    required double price,
    required String productName,
    required List productID,
    required String productQuantity,
    required File? productImage,
  }) async {
    try {
      int newId;
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
      var headers = {
        'X-API-Key': 'Token $token',
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://api.cloudinary.com/v1_1/smonitor/image/upload'));
      request.fields
          .addAll({'upload_preset': 'smonitor_', 'api_key': '591373175821121'});
      request.files
          .add(await http.MultipartFile.fromPath('file', productImage!.path));
      request.headers.addAll(headers);

      http.StreamedResponse imageUrl = await request.send();

      if (imageUrl.statusCode == 200) {
        print('CAN O $imageUrl.request');
        final responseData = await imageUrl.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final imageURL = jsonMap['url'];
        print('success');
        http.Response req = await http.get(
            Uri.parse('https://smonitor.onrender.com/api/product/all/list/v1/'),
            headers: <String, String>{'Authorization': 'Token $token'});
        if (req.statusCode == 200) {
          var data = jsonDecode(req.body);
          Random random = Random();

          do {
            newId = random.nextInt(90000) + 10000;
          } while (data.any((item) => item['product_id'] == newId));
          List id = [];
          id.add(newId);
          // print(newID);
          print(id);

          var headers = {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
            'X-API-Key': '{{token}}'
          };
          var request = http.Request(
            'POST',
            Uri.parse('https://smonitor.onrender.com/api/product/create/'),
          );
          request.body = json.encode({
            "store_id": storeId, // shop id,  data_type = int
            "name": productName, // product name,  data_type = string
            "image_url":
                imageURL, // shop image url, must be an url,  data_type = string
            "productId": id, // PRODUCT designated ID,  data_type = string
            "price": price, // product price,  data_type = float/decimal
            "quantity": productQuantity
          });
          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();

          if (response.statusCode == 200) {
            Navigator.pop(context);
            showSnackBar(context, 'Product added successfully to store');
            print(await response.stream.bytesToString());
          } else {
            Navigator.pop(context);
            showSnackBar(context, response.reasonPhrase.toString());
            print(response.reasonPhrase);
          }
        } else {
          print(req.reasonPhrase);
        }
      } else {
        print(imageUrl.statusCode);
        print('image_error');
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      print(e);
    }
  }

  void deleteProduct(
      {required String productID, required BuildContext context}) async {
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
      http.Response response = await http.get(Uri.parse(
          'https://smonitor.onrender.com/api/product/$productID/delete/'));
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
}
