import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/utils.dart';
import '../../../../common/widgets/curved_card.dart';
import '../../../../common/widgets/orders.dart';
import '../controller/storeController.dart';

class ApprovedStoreWidget extends ConsumerStatefulWidget {
  const ApprovedStoreWidget({super.key});

  @override
  ConsumerState<ApprovedStoreWidget> createState() =>
      _ApprovedStoreWidgetState();
}

String setDate(var dataDate) {
  String timestampString = dataDate;
  DateTime timestamp = DateTime.parse(timestampString);

  String formattedDate = DateFormat('dd/MM/yy').format(timestamp.toLocal());
  return formattedDate;
}

class _ApprovedStoreWidgetState extends ConsumerState<ApprovedStoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                curved_card(
                  height: 130.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.sp,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.sp,
                          ),
                          Text(
                            'Approval Page',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12.sp,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.sp,
                    ),
                    Text(
                      'New Orders',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 5.sp),
                            SizedBox(
                              width: 35.sp,
                              child: Center(
                                child: Text(
                                  ' Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
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
                                  'Order ID',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 65.sp,
                              child: Center(
                                child: Text(
                                  'Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
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
                                  'Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
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
                                  'Status',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        FutureBuilder(
                            future: ref
                                .read(adminStoreControllerProvider)
                                .getApprovedOrders(
                                    context: context, id: storeID.toString()),
                            builder: (context, snapshot) {
                              print(storeID);
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty &&
                                  snapshot.data != null) {
                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!;
                                    var customername =
                                        data[index].customer_name;
                                    var orderId = data[index].order_id;
                                    var amount = data[index].amount;
                                    var date = setDate(data[index].timestamp);

                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 5.sp,
                                        ),
                                        Orders(
                                          amount: format
                                              .format(double.parse(amount)),
                                          customername: customername,
                                          orderId: orderId,
                                          date: date,
                                        ),
                                      ],
                                    );
                                  },
                                );
                                // return Center(
                              } else {
                                return Center(
                                  child: Text(
                                    'No Active Orders',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 9.sp),
                                  ),
                                );
                              }
                              // return Center(
                              //   return Text(
                              //     'No Active Orders',
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .bodyLarge
                              //         ?.copyWith(fontSize: 9.sp),
                              //   ),
                              // );
                              // },
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
