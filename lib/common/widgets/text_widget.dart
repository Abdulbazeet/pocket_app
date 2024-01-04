// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextWidget extends StatelessWidget {
  final String hintText;
  final TextInputType? type;
  final int? max;
  final TextEditingController controller;
  const TextWidget({
    Key? key,
    required this.hintText,
    this.type = TextInputType.name,
    this.max = 1,
    required this.controller,
  }) : super(key: key);

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
        maxLines: max,
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
