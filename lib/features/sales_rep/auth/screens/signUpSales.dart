import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/widgets/text_box.dart';
import 'package:shopping_app/features/admin/auth/screens/signIn.dart';
import 'package:shopping_app/features/sales_rep/auth/sales_authService/sales_authService.dart';
import 'package:sizer/sizer.dart';

class SignUpSales extends ConsumerStatefulWidget {
  const SignUpSales({super.key});
  static const String routeName = '/sign-Up-Sale';

  @override
  ConsumerState<SignUpSales> createState() => _SignUpSalesState();
}

class _SignUpSalesState extends ConsumerState<SignUpSales> {
  bool _obscureText = true;
  SalesAuthService salesAuth = SalesAuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
  }

  void signUp() {
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
    print('usl');
    salesAuth.signUp(
      context,
      _nameController.text,
      _passwordController.text,
      _emailController.text,
    );
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
                SizedBox(
                  height: 30.sp,
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
                    'Register',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 28.sp,
                        ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Name',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      TextBox(
                        hintText: 'Enter your name',
                        controller: _nameController,
                        bool: false,
                        icon: const SizedBox.shrink(),
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      TextBox(
                        hintText: 'Enter your email',
                        controller: _emailController,
                        bool: false,
                        icon: const SizedBox.shrink(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 12.sp,
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
                        children: [],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4960F9),
                            minimumSize: const Size(
                              double.infinity,
                              58,
                            )),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
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
