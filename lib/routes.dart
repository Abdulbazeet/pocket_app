import 'package:flutter/material.dart';
import 'package:shopping_app/features/admin/auth/screens/signIn.dart';
import 'package:shopping_app/features/sales_rep/auth/screens/signUpSales.dart';
import 'package:shopping_app/screens/admin_main_page.dart';

import 'features/admin/auth/screens/signUp.dart';
import 'features/admin/shop/screens/create_store.dart';
import 'features/sales_rep/auth/screens/signInSales.dart';

Route<dynamic> screenRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );
    case AdminMainPage.routeName:
      return MaterialPageRoute(
        builder: (context) => const AdminMainPage(),
      );
    case CreateStore.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateStore(),
      );
    case SignISales.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignISales(),
      );

    case SignUpSales.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignUpSales(),
      );
    case SignUp.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignUp(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Invalid Page'),
          ),
        ),
      );
  }
}
