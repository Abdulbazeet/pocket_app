import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextBox extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool;
  final Widget icon;
  const TextBox({
    super.key,
    required this.hintText,
    required this.controller,
    required this.bool,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF7F8F9),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.5.sp,
          color: const Color(
            0xFFEBEEF5,
          ),
        ),
        borderRadius: BorderRadius.circular(7.sp),
      ),
      elevation: 0,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return hintText;
          } else {
            return null;
          }
        },
        obscureText: bool,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: icon,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 10.sp,
              color: const Color(0xFFCED1D6),
              fontWeight: FontWeight.w500),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
        ),
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}
