import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderStatus extends StatelessWidget {
  final Color color;
  final String status;
  const OrderStatus({super.key, required this.color, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.sp,
      height: 10.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          1.sp,
        ),
        color: color,
      ),
      child: Center(
        child: Text(
          status,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 7.sp,
                fontWeight: FontWeight.w400,
                color: const Color(
                  0xFF23CC79,
                ),
              ),
        ),
      ),
    );
  }
}
