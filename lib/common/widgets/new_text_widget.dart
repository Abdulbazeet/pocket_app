import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewTextWidget extends StatelessWidget {
  final String hintText;
  final TextInputType? type;
  final TextEditingController controller;
  const NewTextWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.type = TextInputType.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF7F8F9),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.5.sp,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(7.sp),
      ),
      elevation: 0,
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 10.sp,
              color: Color.fromARGB(255, 159, 161, 164),
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
