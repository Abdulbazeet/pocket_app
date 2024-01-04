import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/features/admin/auth/screens/signIn.dart';
import 'package:sizer/sizer.dart';
import 'package:shopping_app/common/widgets/text_box.dart';

import '../authService/authService.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});
  static const String routeName = '/sign-Up-Admin';

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  bool _obscureText = true;
  // final AuthService authService = AuthService()
  AuthService authservice = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  // void signUpNow() {
  //   signUpClick(
  //     context: context,
  //     name: _nameController.text,
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //   );
  // }
  void signUpNow() {
    // ref.read(adminAuthControllerProvider).signUp(
    //       context,
    //       _nameController.text.trim(),
    //       _emailController.text.trim(),
    //       _passwordController.text.trim(),
    //     );
    authservice.signUp(
      context,
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );

    // Future<UserModel>? user = signUpUser();
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
                      const SizedBox(
                        height: 10,
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
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      SignInScreen.routeName, (route) => false),
                              child: Text(
                                'Login?',
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
                            signUpNow()
                            ;
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
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1.sp,
                              color: const Color.fromARGB(255, 170, 172, 176),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            child: Text(
                              'Or Login wih',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: const Color(0xFF6F747D),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.sp,
                              color: const Color.fromARGB(255, 170, 172, 176),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.sp),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 79,
                              height: 42.46,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFCED1D6)),
                                borderRadius: BorderRadius.circular(6.45),
                              ),
                              child: Image.asset('assets/Facebook-jpeg.jpg'),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Container(
                              width: 79,
                              height: 42.46,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(
                                    0xFFCED1D6,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(6.45),
                              ),
                              child: Image.asset('assets/Google-jpeg.jpg'),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Container(
                              width: 79,
                              height: 42.46,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFCED1D6),
                                ),
                                borderRadius: BorderRadius.circular(6.45),
                              ),
                              child: Image.asset('assets/Apple-jpeg.jpg'),
                            ),
                          ),
                        ],
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
