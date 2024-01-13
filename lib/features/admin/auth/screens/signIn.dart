import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/widgets/text_box.dart';
import 'package:shopping_app/features/admin/auth/authService/authService.dart';
import 'package:shopping_app/features/admin/auth/screens/signUp.dart';
import 'package:sizer/sizer.dart';

import '../../../sales_rep/auth/screens/signInSales.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signIn';

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool obscureText = true;
  AuthService authservice = AuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  void signIn() {
    authservice.signIn(
      context,
      nameController.text,
      passwordController.text,
      ref,
    );
    // Navigator.pop(context);
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 15.sp, right: 15.sp, top: 35.sp, bottom: 25.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 28.sp),
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
                    'Admin!',
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
                        icon: const SizedBox.shrink(),
                        bool: false,
                        hintText: 'Enter your name',
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBox(
                        icon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: obscureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Color(0xFFCED1D6),
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Color(0xFFCED1D6),
                                ),
                        ),
                        bool: obscureText,
                        hintText: 'Enter your password',
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              '',
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
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      SignISales.routeName, (route) => false),
                              child: Text(
                                'Login as Sales Rep?',
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
                      )
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
