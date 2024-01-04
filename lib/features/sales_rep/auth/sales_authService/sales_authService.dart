// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/common/userProvider.dart';
import 'package:shopping_app/features/admin/auth/screens/signIn.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/features/sales_rep/auth/screens/signInSales.dart';
import 'package:shopping_app/features/sales_rep/store/screens/store_sales.dart';
import 'package:shopping_app/screens/sales_rep_main-page.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/utils.dart';
import '../../../../models/userModel.dart';

class SalesAuthService {
  void signIn(BuildContext context, String name, String password) async {
    try {
      UserModel usermodel = UserModel(
          username: name,
          storeName: '',
          email: '',
          password: password,
          id: '',
          token: '',
          AdminStatus: false);

      http.Response response = await http.post(
        Uri.parse(
          'https://smonitor.onrender.com/api/login/',
        ),
        body: usermodel.toMap(),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      if (response.statusCode == 200) {
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
        var data = jsonDecode(
          response.body,
        );
        print(data);
        var adminStatus = data['AdminStaus'];
        print(adminStatus);
        if (adminStatus == false) {
          String? t = data['token'];
          String? name = data['username'];
          // print(t);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('token', t!);
          SharedPreferences sharedName = await SharedPreferences.getInstance();
          await sharedName.setString('name', name!);
          await sharedPreferences.setBool('admin', adminStatus);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const SalesRepMainPage(),
              ),
              (route) => false);
        } else {
          showSnackBar(
            context,
            'User is an admin, proceed to login as a Admin',
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
              SignInScreen.routeName, (route) => false);
        }
      } else if (response.statusCode == 400) {
        Navigator.pop(context);
        showSnackBar(context, jsonDecode(response.body)['error']);
      }

      // ignore: use_build_context_synchronously
      // errorHandling(
      //   context: context,
      //   response: response,
      //   onSuccess: () async {
      //     //  showDialog(
      //     //   barrierDismissible: false,
      //     //   context: context,
      //     //   builder: (context) {
      //     //     return AlertDialog(
      //     //       content: SizedBox(
      //     //         height: 40.sp,
      //     //         width: 40.sp,
      //     //         child: const Center(
      //     //           child: CircularProgressIndicator(
      //     //             backgroundColor: Colors.blueAccent,
      //     //           ),
      //     //         ),
      //     //       ),
      //     //     );
      //     //   },
      //     // );
      //     var data = jsonDecode(
      //       response.body,
      //     );
      //     print(data);
      //     var adminStatus = data['AdminStaus'];
      //     print(adminStatus);
      //     if (adminStatus == false) {
      //       String? t = data['token'];
      //       String? name = data['username'];
      //       // print(t);
      //       SharedPreferences sharedPreferences =
      //           await SharedPreferences.getInstance();
      //       await sharedPreferences.setString('token', t!);
      //       SharedPreferences sharedName =
      //           await SharedPreferences.getInstance();
      //       await sharedName.setString('name', name!);
      //       await sharedPreferences.setBool('admin', adminStatus);

      //       // ignore: use_build_context_synchronously
      //       Navigator.of(context).pushAndRemoveUntil(
      //           MaterialPageRoute(
      //             builder: (context) => const StoreSales(),
      //           ),
      //           (route) => false);
      //     } else {
      //       showSnackBar(
      //         context,
      //         'User is an admin, proceed to login as a Admin',
      //       );
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           SignInScreen.routeName, (route) => false);
      //     }
      //   },
      // );
    } catch (e) {
      Navigator.pop(context);
      // showSnackBar(context, e.toString());
      if (e.toString() ==
          "ClientException with SocketException: Failed host lookup: 'smonitor.onrender.com' (OS Error: No address associated with hostname, errno = 7), uri=https://smonitor.onrender.com/api/login/") {
        showSnackBar(context, 'You are not connected to the internet');
      }
      print(e);
    }
  }

  void signUp(
    BuildContext context,
    String name,
    String password,
    String email,
  ) async {
    try {
      UserModel usermodel = UserModel(
          username: name,
          storeName: '',
          email: '',
          password: password,
          id: '',
          token: '',
          AdminStatus: false);

      http.Response response = await http.post(
        Uri.parse(
          'https://smonitor.onrender.com/api/register/',
        ),
        body: usermodel.toMap(),
        // body:
        headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      // ignore: use_build_context_synchronously
      // errorHandling(
      //     context: context,
      //     response: response,
      //     onSuccess: () async {
      //       showDialog(
      //         barrierDismissible: false,
      //         context: context,
      //         builder: (context) {
      //           return AlertDialog(
      //             content: SizedBox(
      //               height: 40.sp,
      //               width: 40.sp,
      //               child: const Center(
      //                 child: CircularProgressIndicator(
      //                   backgroundColor: Colors.blueAccent,
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //       var data = jsonDecode(
      //         response.body,
      //       );
      //       Navigator.pop(context);
      //     });
      if (response.statusCode == 200) {
        showSnackBar(context, 'User Created successfully');

        Navigator.pop(context);
      } else {
        showSnackBar(context, response.reasonPhrase.toString());
        Navigator.pop(context);
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
      if (e.toString() ==
          "ClientException with SocketException: Failed host lookup: 'smonitor.onrender.com' (OS Error: No address associated with hostname, errno = 7), uri=https://smonitor.onrender.com/api/login/") {
        showSnackBar(context, 'You are not connected to the internet');
      }
      showSnackBar(context, e.toString());
      print(e);
    }
  }
}
