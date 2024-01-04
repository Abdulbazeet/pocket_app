import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Status extends StatelessWidget {
  final Color outerColor;
  final Color innerColor;
  final Color textColor;
  final String status;
  const Status(
      {super.key,
      required this.outerColor,
      required this.innerColor,
      required this.status,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: innerColor,
        borderRadius: BorderRadius.circular(
          8.sp,
        ),
        border: Border.all(
          color: outerColor,
        ),
      ),
      child: Center(
        child: Text(
          status,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 8.sp, color: textColor),
        ),
      ),
    );
  }
}
