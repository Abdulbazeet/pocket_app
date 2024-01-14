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
      ref.read(invoiceSearchControllerProvider).searchInvoice(
            orderId: orderIdController.text,
            controller: orderIdController,
          );
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
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSubmitted: (value) {
                          setState(() {});
                        },
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
            FutureBuilder(
              future: ref.read(invoiceSearchControllerProvider).searchInvoice(
                  orderId: orderIdController.text,
                  controller: orderIdController),
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
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data != []) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: PRODUCTID.length,
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
                              String extractInvoiceId(String text) {
                                // Split the string by the colon
                                List<String> parts = text.split(":");

                                // Check if the format is valid
                                if (parts.length != 2 ||
                                    parts[0].trim().toLowerCase() !=
                                        "invoice id") {
                                  return '';
                                }

                                // Extract and remove "TP" prefix
                                String invoiceId = parts[1].trim();
                                // if (invoiceId.startsWith("TP")) {
                                //   invoiceId = invoiceId.substring(2);
                                // }
                                print(invoiceId);
                                return invoiceId;
                              }

                              if (extractInvoiceId(PRODUCTID[index]['Res']) ==
                                  '') {
                                return null;
                              } else {
                                print(
                                    extractInvoiceId(PRODUCTID[index]['Res']));
                                // showFuction(
                                //     context: context,
                                //     orderId: extractInvoiceId(
                                //         PRODUCTID[index]['Res']));
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          horizontal: 20.sp, vertical: 10.sp),
                                      child: Container(
                                        height: 450.sp,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.sp, vertical: 10.sp),
                                        child: FutureBuilder(
                                          future: ref
                                              .read(
                                                  invoiceSearchControllerProvider)
                                              .getData(
                                                context: context,
                                                orderid: extractInvoiceId(
                                                  PRODUCTID[index]['Res'],
                                                ),
                                              ),
                                          builder: (context, snapshot) {
                                            print(snapshot.data);
                                            print('2');
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.data != null &&
                                                    snapshot.data != [] &&
                                                    snapshot.hasData) {
                                                  return ListView.separated(
                                                    itemCount:
                                                        snapshot.data.length,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const Divider(),
                                                    itemBuilder:
                                                        (context, listIndex) {
                                                      List<Text> widget =
                                                          List.generate(
                                                        snapshot
                                                            .data[index]
                                                                ['productId']
                                                            .length,
                                                        (newIndex) => Text(
                                                          snapshot.data[index]
                                                                  ['productId']
                                                              [newIndex],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                        ),
                                                      );
                                                      return Column(children: [
                                                        Center(
                                                          child: Container(
                                                            height: 150.sp,
                                                            width: 150.sp,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.sp),
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                    snapshot.data[
                                                                            listIndex]
                                                                        [
                                                                        'productImageURL']),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 200.sp,
                                                          child: Center(
                                                            child: Text(
                                                              snapshot.data[
                                                                      listIndex]
                                                                  [
                                                                  'productName'],
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.sp,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'ProductID:',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                                width: 15.sp),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: widget,
                                                            )
                                                            // SizedBox(
                                                            //   height: 80.w,
                                                            //   child: SizedBox(
                                                            //     child: ListView.builder(
                                                            //         shrinkWrap: true,
                                                            // itemCount: snapshot
                                                            //     .data![index]
                                                            //         ['productId']
                                                            //     .entries
                                                            //     .length,
                                                            //         itemBuilder: (context,
                                                            //             entryIndex) {
                                                            // final entry = snapshot
                                                            //     .data![index][
                                                            //         'productId']
                                                            //     .entries
                                                            //     .elementAt(
                                                            //         entryIndex);
                                                            // final value =
                                                            //     entry.value;
                                                            // final valueString =
                                                            //     value
                                                            //         .toString();
                                                            // print(
                                                            //   snapshot
                                                            //       .data![index][
                                                            //           'productId']
                                                            //       .entries
                                                            //       .length,
                                                            // );
                                                            //   return Text(
                                                            //     valueString,
                                                            //     style: Theme.of(
                                                            //             context)
                                                            //         .textTheme
                                                            //         .bodyLarge
                                                            //         ?.copyWith(
                                                            //           fontSize:
                                                            //               10.sp,
                                                            //         ),
                                                            //   );
                                                            // }),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.sp,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Quantity Ordered:',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                                width: 15.sp),
                                                            Text(
                                                              snapshot.data[
                                                                      listIndex]
                                                                      [
                                                                      'productQuantity']
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.sp,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Date:',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                                width: 15.sp),
                                                            Text(
                                                              snapshot.data[
                                                                      listIndex]
                                                                  [
                                                                  'productTime'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]);
                                                    },
                                                  );
                                                } else {}
                                              }
                                            }
                                            return SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }

                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     List<Text> widget = List.generate(
                              //         snapshot.data![index]['productId'].entries
                              //             .length, (entryIndex) {
                              //       final entry = snapshot
                              //           .data![index]['productId'].entries
                              //           .elementAt(entryIndex);
                              //       final value = entry.value;
                              //       final valueString = value.toString();
                              //       print(
                              //         snapshot.data![index]['productId'].entries
                              //             .length,
                              //       );
                              //       return Text(
                              //         valueString,
                              //         style: Theme.of(context)
                              //             .textTheme
                              //             .bodyLarge
                              //             ?.copyWith(
                              //               fontSize: 10.sp,
                              //             ),
                              //       );
                              //     });
                              //     print('object');
                              //     return Dialog(
                              //       insetPadding: EdgeInsets.symmetric(
                              //           horizontal: 30.sp, vertical: 10.sp),
                              //       child: Container(
                              //         height: 350.sp,
                              //         width: double.infinity,
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 10.sp),
                              //         child: SingleChildScrollView(
                              //           child: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //             children: [

                              //                 ],
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                            },
                            child: Text(
                              PRODUCTID[index]['Res'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 9.sp,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Text(
                    'No invoice found',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 10.sp),
                  );
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
