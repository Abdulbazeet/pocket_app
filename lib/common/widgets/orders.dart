import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'order_status.dart';

class Orders extends StatelessWidget {
  final String customername;
  final String orderId;
  final String amount;
  final String date;
  const Orders(
      {super.key,
      required this.customername,
      required this.orderId,
      required this.amount, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 5.sp),
        SizedBox(
          width: 45.sp,
          child: Center(
            child: Text(
              customername,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        SizedBox(
          width: 45.sp,
          child: Center(
            child: Text(
              orderId,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 7.sp, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(
          width: 45.sp,
          child: Center(
            child: Text(
              '₦$amount',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
        SizedBox(
          width: 45.sp,
          child: Center(
            child: Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 7.sp, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(
          width: 45.sp,
          child: const Center(
            child: OrderStatus(
              color: Colors.greenAccent,
              status: 'Approved',
            ),
          ),
        )
      ],
    );
  }
}
