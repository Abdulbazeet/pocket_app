import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/common/widgets/text_box.dart';
import 'package:shopping_app/features/admin/auth/screens/signIn.dart';
import 'package:shopping_app/features/sales_rep/auth/sales_authService/sales_authService.dart';
import 'package:shopping_app/features/sales_rep/auth/screens/signUpSales.dart';
import 'package:shopping_app/screens/sales_rep_main-page.dart';
import 'package:sizer/sizer.dart';

class SignISales extends StatefulWidget {
  const SignISales({super.key});
  static const String routeName = '/sales-signIn';

  @override
  State<SignISales> createState() => _SignISalesState();
}

class _SignISalesState extends State<SignISales> {
  bool _obscureText = true;
  SalesAuthService salesAuthService = SalesAuthService();
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  void signIn() {
    salesAuthService.signIn(
      context,
      _nameController.text,
      _passwordController.text,
    );
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 28.sp,
                      ),
                ),
                SizedBox(
                  height: 3.sp,
                ),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Color(0xFF1422FF),
                        Color(0xFF4960F9),
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    'Sales Rep!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 28.sp,
                        ),
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Text(
                  'Sign in',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      TextBox(
                        hintText: 'Enter your name',
                        controller: _nameController,
                        bool: false,
                        icon: const SizedBox.shrink(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBox(
                        icon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: _obscureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Color(0xFFCED1D6),
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Color(0xFFCED1D6),
                                ),
                        ),
                        bool: _obscureText,
                        hintText: 'Enter your password',
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      SignInScreen.routeName, (route) => false),
                              child: Text(
                                'Login as Admin?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 58),
                          backgroundColor: const Color(0xFF4960F9),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            signIn();
                          }
                        },
                        child: Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
