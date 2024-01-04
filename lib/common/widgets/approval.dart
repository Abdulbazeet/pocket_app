import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Approval extends StatelessWidget {
  final String oderId;
  final int oder;
  final String date;
  final String amount;
  // final VoidCallback approve;
  // final VoidCallback denie;
  final Widget childWidget;
  const Approval({
    super.key,
    required this.oderId,
    required this.oder,
    required this.date,
    required this.amount,
    // required this.approve,
    // required this.denie,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 58.sp,
              child: Center(
                child: Text(
                  oderId.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 58.sp,
              child: Center(
                child: Text(
                  oder.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 58.sp,
              child: Center(
                child: Text(
                  date,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 58.sp,
              child: Center(
                child: Text(
                  '₦${amount.toString()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 58.sp,
              height: 12.sp,
              child: Center(child: childWidget),
            )
          ],
        ),
        SizedBox(
          height: 15.sp,
        )
      ],
    );
  }
}
