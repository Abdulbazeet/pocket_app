import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class curved_card extends StatelessWidget {
  final double height;
  const curved_card({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            32.sp,
          ),
          bottomRight: Radius.circular(
            32.sp,
          ),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1422FF),
            Color(0xFF4960F9),
          ],
        ),
      ),
    );
  }
}
