import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/features/sales_rep/store/screens/store_sales.dart';
import 'package:shopping_app/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/screens/admin_main_page.dart';
import 'package:shopping_app/screens/sales_rep_main-page.dart';

import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'common/utils.dart';
import 'features/sales_rep/auth/screens/signInSales.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool? status = await getAdminStatus();

  String? token = await getToken();
  runApp(
    ProviderScope(
      child: MyApp(
        token: token,
        status: status,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;
  final bool? status;
  const MyApp({super.key, this.token, this.status});
  // This widget is the root of printyour application.
  @override
  Widget build(BuildContext context) {
    print(token);
    print(token);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade300,

          textTheme: TextTheme(
            bodyLarge: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
        ),
        onGenerateRoute: (settings) => screenRoute(settings),
        home: token != null
            ? status == false
                ? const SalesRepMainPage()
                : const AdminMainPage()
            : const SignISales(),
      );
    });
  }
}
