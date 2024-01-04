import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/common/widgets/curved_card.dart';
import 'package:shopping_app/common/widgets/status.dart';
import 'package:shopping_app/features/sales_rep/sales_approval_page/controller/sales_approval_controller.dart';
import 'package:shopping_app/features/sales_rep/store/controller/sales_store_controller.dart';
import 'package:shopping_app/models/order.dart';
import 'package:sizer/sizer.dart';

class SalesRepApproval extends ConsumerStatefulWidget {
  const SalesRepApproval({super.key});

  @override
  ConsumerState<SalesRepApproval> createState() => _SalesRepApprovalState();
}

String setDate(var dataDate) {
  String timestampString = dataDate;
  DateTime timestamp = DateTime.parse(timestampString);

  String formattedDate = DateFormat('dd/MM/yy').format(timestamp.toLocal());
  return formattedDate;
}

class _SalesRepApprovalState extends ConsumerState<SalesRepApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                curved_card(
                  height: 140.sp,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 40.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.sp,
                      ),
                      child: Text(
                        'ALL ORDERS',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 22.sp,
                            ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50.sp,
                        child: Text(
                          'Order ID',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 9.sp,
                                  ),
                        ),
                      ),

                      SizedBox(
                        width: 50.sp,
                        child: Center(
                          child: Text(
                            'Date',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 9.sp,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.sp,
                        child: Center(
                          child: Text(
                            'Price',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 9.sp,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.sp,
                        child: Center(
                          child: Text(
                            'Status',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 9.sp,
                                    ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 50.sp,
                      //   child: Text(
                      //     'Order ID',

                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  FutureBuilder<List<Order>>(
                    future: ref
                        .read(salesRepApprovalController)
                        .getAllOrders(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            SizedBox(height: 20.sp),
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        );
                      } else if (snapshot.hasData && snapshot.data! != null ||
                          snapshot.data! != []) {
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = snapshot.data![index];
                              var orderStatus = data.orderStatus;
                              print(orderStatus);
                              print('meee');
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50.sp,
                                    child: Text(
                                      data.order_id,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 8.sp,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50.sp,
                                    child: Center(
                                      child: Text(
                                        setDate(data.timestamp),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontSize: 8.sp,
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70.sp,
                                    child: Center(
                                      child: Text(
                                        "₦${formatNumberWithCommas(data.amount)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontSize: 8.sp,
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 50.sp,
                                      child: Status(
                                          outerColor: data.orderStatus ==
                                                  'approved'
                                              ? Colors.green
                                              : data.orderStatus == 'declined'
                                                  ? Colors.red
                                                  : Colors.orange,
                                          innerColor: data.orderStatus ==
                                                  'approved'
                                              ? Colors.greenAccent
                                              : data.orderStatus == 'declined'
                                                  ? Colors.redAccent
                                                  : Colors.orangeAccent,
                                          status: data.orderStatus == 'approved'
                                              ? 'Approved'
                                              : data.orderStatus == 'declined'
                                                  ? 'Declined'
                                                  : 'Pending',
                                          textColor: Colors.white)),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: snapshot.data!.length);
                      } else {
                        return Text('No orders');
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
