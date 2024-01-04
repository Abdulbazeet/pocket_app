import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/common/widgets/curved_card.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/approval.dart';
import '../controller/approvalpageController.dart';

class ApprovalPage extends ConsumerStatefulWidget {
  const ApprovalPage({super.key});

  @override
  ConsumerState<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends ConsumerState<ApprovalPage> {
  void approveOrder() {
    ref
        .read(approvalpageControllerProvider)
        .approveOrder(context: context, order_id: newOrderId);
  }

  void declineOrder() {
    ref
        .read(approvalpageControllerProvider)
        .declineOrder(context: context, order_id: newOrderId);
  }

  void restoreStatus() {
    ref
        .read(approvalpageControllerProvider)
        .restoreStatus(context: context, order_id: newOrderId);
  }

  String setDate(var dataDate) {
    String timestampString = dataDate;
    DateTime timestamp = DateTime.parse(timestampString);

    String formattedDate = DateFormat('dd/MM/yy').format(timestamp.toLocal());
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    SizedBox(
                      height: 40.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.sp,
                      ),
                      child: Text(
                        'Approval Page',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                            ),
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
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Order ID',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Order',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 58.sp,
                                height: 12.sp,
                                child: Center(
                                  child: Text(
                                    'Approval',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15.sp,
                        )
                      ],
                    ),
                    FutureBuilder(
                      future: ref
                          .watch(approvalpageControllerProvider)
                          .getAllProducts(context: context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!.isNotEmpty &&
                              snapshot.data != []) {
                            // var data = snapshot.data![0];
                            // var orderId = data.order_id;
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index];
                                var orderId = data.order_id;
                                var date = setDate(data.timestamp);
                                // var order = data['store'];
                                // var date = data.time;
                                var amount = data.amount;

                                return Approval(
                                  oderId: orderId,
                                  oder: data.products.length,
                                  date: date,
                                  amount: formatNumberWithCommas(amount),
                                  childWidget: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            newOrderId =
                                                int.parse(orderId).toInt();
                                            print(newOrderId);
                                            approveOrder();
                                          });
                                        },
                                        child: Container(
                                          width: 20.sp,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF23CC79),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            newOrderId =
                                                int.parse(orderId).toInt();
                                            declineOrder();
                                          });
                                        },
                                        child: Container(
                                          width: 20.sp,
                                          decoration: const BoxDecoration(
                                            color: Color(
                                              0xFFFF6B6B,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.close,
                                              size: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No new orders',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 9.sp,
                                    ),
                              ),
                            );
                          }
                        }
                      },
                    ),

                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      'Declined Orders',
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
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Order ID',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Order',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 58.sp,
                              child: Center(
                                child: Text(
                                  'Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 58.sp,
                                height: 12.sp,
                                child: Center(
                                  child: Text(
                                    'Approval',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15.sp,
                        )
                      ],
                    ),
                    FutureBuilder(
                      future: ref
                          .watch(approvalpageControllerProvider)
                          .getDeclined(context: context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!.isNotEmpty &&
                              snapshot.data != []) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index];
                                var orderId = data.order_id;
                                print(orderId);
                                var date = setDate(data.timestamp);
                                // var order = data['store'];
                                // var date = data.time;
                                var amount = data.amount;

                                return Approval(
                                  oderId: orderId,
                                  oder: data.products.length,
                                  date: date,
                                  amount: formatNumberWithCommas(amount),
                                  childWidget: InkWell(
                                    onTap: () {
                                      setState(() {
                                        newOrderId = int.parse(orderId).toInt();
                                        print(newOrderId);
                                        restoreStatus();
                                      });
                                    },
                                    child: Container(
                                      width: 20.sp,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF23CC79),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: Text(
                              'No declined order ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 9.sp,
                                  ),
                            ));
                          }
                        }
                      },
                    ),

                    ///
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
