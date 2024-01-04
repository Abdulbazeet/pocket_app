// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/common/userProvider.dart';
import 'package:shopping_app/features/admin/auth/screens/signIn.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/features/sales_rep/auth/screens/signInSales.dart';
import 'package:shopping_app/screens/admin_main_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/utils.dart';
import '../../../../models/userModel.dart';

class AuthService {
  void signUp(BuildContext context, String username, String email,
      String password) async {
    try {
      UserModel usermodel = UserModel(
        username: username,
        storeName: '',
        email: email,
        password: password,
        id: '',
        token: '',
        AdminStatus: true,
      );
      var token = usermodel.token;
      http.Response response = await http.post(
          Uri.parse('https://smonitor.onrender.com/api/register/'),
          body: usermodel.toMap(),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-API-Key': token
          });
      // showLoading();

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Success');
        // ignore: use_build_context_synchronously
        showSnackBar(
          context,
          'Account created successfully. Proceed to login',
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
      } else {
        showSnackBar(context, jsonDecode(response.body));
        print(response.statusCode);
      }
    } catch (e) {
      if (e ==
          "ClientException with SocketException: Failed host lookup: 'smonitor.onrender.com' (OS Error: No address associated with hostname, errno = 7), uri=https://smonitor.onrender.com/api/login/") {
        showSnackBar(context, 'You are not connected to the internet');
      }
      print(e);
    }
  }

  //signIn
  void signIn(
      BuildContext context, String name, String password, WidgetRef ref) async {
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
      UserModel usermodel = UserModel(
          username: name,
          storeName: '',
          email: '',
          password: password,
          id: '',
          token: '',
          AdminStatus: true);

      http.Response response = await http.post(
        Uri.parse(
          'https://smonitor.onrender.com/api/login/',
        ),
        body: usermodel.toMap(),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body,
        );
        print(data);
        var adminStatus = data['AdminStaus'];
        print(adminStatus);
        if (adminStatus == true) {
          String? t = data['token'];
          String? name = data['username'];
          // print(t);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('token', t!);
          await sharedPreferences.setBool('admin', adminStatus);
          SharedPreferences sharedName = await SharedPreferences.getInstance();
          await sharedName.setString('name', name!);
          ref.read(userProviderClass).setUser(response.body);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil(
            AdminMainPage.routeName,
            (route) => false,
          );
        } else {
          showSnackBar(
            context,
            'User is not an admin, proceed to login as a Sales Rep',
          );
          Navigator.of(context)
              .pushNamedAndRemoveUntil(SignISales.routeName, (route) => false);
        }
      } else if (response.statusCode == 400) {
        Navigator.pop(context);
        showSnackBar(context, jsonDecode(response.body)['error']);
      } else {
        Navigator.pop(context);
        showSnackBar(context, jsonDecode(response.body));
      }

      // ignore: use_build_context_synchronously
      // errorHandling(
      //   context: context,
      //   response: response,
      //   onSuccess: () async {
      //     // showDialog(
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
      //     // var data = jsonDecode(
      //     //   response.body,
      //     // );
      //     // print(data);
      //     // var adminStatus = data['AdminStaus'];
      //     // print(adminStatus);
      //     // if (adminStatus == true) {
      //     //   String? t = data['token'];
      //     //   String? name = data['username'];
      //     //   // print(t);
      //     //   SharedPreferences sharedPreferences =
      //     //       await SharedPreferences.getInstance();
      //     //   await sharedPreferences.setString('token', t!);
      //     //   await sharedPreferences.setBool('admin', adminStatus);
      //     //   SharedPreferences sharedName =
      //     //       await SharedPreferences.getInstance();
      //     //   await sharedName.setString('name', name!);
      //     //   ref.read(userProviderClass).setUser(response.body);

      //     //   // ignore: use_build_context_synchronously
      //     //   Navigator.of(context).pushNamedAndRemoveUntil(
      //     //     AdminMainPage.routeName,
      //     //     (route) => false,
      //     //   );
      //     // } else {
      //     //   showSnackBar(
      //     //     context,
      //     //     'User is not an admin, proceed to login as a Sales Rep',
      //     //   );
      //     //   Navigator.of(context).pushNamedAndRemoveUntil(
      //     //       SignISales.routeName, (route) => false);
      //     // }
      //   },
    } catch (e) {
      // showSnackBar(context, e.toString());
      if (e.toString() ==
          "ClientException with SocketException: Failed host lookup: 'smonitor.onrender.com' (OS Error: No address associated with hostname, errno = 7), uri=https://smonitor.onrender.com/api/login/") {
        showSnackBar(context, 'You are not connected to the internet');
      }
      print(e);
    }
  }
}
