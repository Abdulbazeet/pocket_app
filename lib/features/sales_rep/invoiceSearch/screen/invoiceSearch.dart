import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/utils.dart';
import '../../../../models/invoiceModel.dart';
import '../controller/invoiceSearchController.dart';

class InvoiceSearch extends ConsumerStatefulWidget {
  const InvoiceSearch({super.key});

  @override
  ConsumerState<InvoiceSearch> createState() => _InvoiceSearchState();
}

final TextEditingController orderIdController = TextEditingController();

class _InvoiceSearchState extends ConsumerState<InvoiceSearch> {
  @override
  Widget build(BuildContext context) {
    void searchInvoice() {
      ref
          .read(invoiceSearchControllerProvider)
          .searchInvoice(orderId: orderIdController.text);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.sp,
            vertical: 10.sp,
          ),
          child: Column(children: [
            SizedBox(
              height: 10.sp,
            ),
            Container(
              height: 35.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    12.sp,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: orderIdController,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: 'Enter invoiceID',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold),
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 60.sp),
            FutureBuilder<List<InvoiceModel>>(
              future: ref
                  .read(invoiceSearchControllerProvider)
                  .searchInvoice(orderId: orderIdController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: double.infinity,
                    height: 40.sp,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null ||
                    snapshot.data != []) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1422FF),
                              minimumSize: Size(
                                double.infinity,
                                36.sp,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 30.sp),
                                    child: Container(
                                      height: 350.sp,
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20.sp,
                                          ),
                                          Center(
                                            child: Container(
                                              height: 150.sp,
                                              width: 150.sp,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.sp),
                                                image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data![index]
                                                      .productImageURL),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.sp,
                                          ),
                                          SizedBox(
                                            width: 200.sp,
                                            child: Center(
                                              child: Text(
                                                snapshot
                                                    .data![index].productName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.sp,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'ProductID:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                              ),
                                              SizedBox(width: 15.sp),
                                              Text(
                                                snapshot.data![index].productId,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.sp,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Quantity Ordered:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                              ),
                                              SizedBox(width: 15.sp),
                                              Text(
                                                snapshot.data![index]
                                                    .productQuantity
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.sp,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Date:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                              ),
                                              SizedBox(width: 15.sp),
                                              Text(
                                                snapshot
                                                    .data![index].productTime,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                    ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(snapshot.data![index].productName),
                          ),
                          SizedBox(
                            height: 20.sp,
                          )
                        ],
                      );
                    },
                  );
                }
                return Text(
                  'No invoice found',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 10.sp),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
