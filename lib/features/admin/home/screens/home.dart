// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/common/widgets/curved_card.dart';
import 'package:shopping_app/common/widgets/orders.dart';
import 'package:shopping_app/features/admin/home/controller/homeController.dart';
import 'package:shopping_app/features/sales_rep/auth/screens/signInSales.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/widgets/store_widget.dart';
import '../../approval_page/controller/approvalpageController.dart';
import '../../shop/controller/storeController.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    super.key,
  });

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  void logOut() async {
    try {
      var token = await getToken();
      print(token);
      http.Response response = await http.post(
        Uri.parse('https://smonitor.onrender.com/api/logout/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      if (response.statusCode == 200) {
        // SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // final token = sharedPreferences.setString('token', '');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SignISales.routeName, (route) => false);
      } else {
        showSnackBar(context, response.reasonPhrase!);
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  var ID = '';

  void deleteProduct() {
    ref
        .read(adminStoreControllerProvider)
        .deleteProduct(id: ID, context: context);
  }

  String setDate(var dataDate) {
    String timestampString = dataDate;
    DateTime timestamp = DateTime.parse(timestampString);

    String formattedDate = DateFormat('dd/MM/yy').format(timestamp.toLocal());
    return formattedDate;
  }

  final TextEditingController text = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    text.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(text.text);
    String productIDsString = text.text;
    var stringList = productIDsString.split(',').map((e) => e.trim()).toList();

    newID = stringList;
    // List<String>

    return Scaffold(
      body: search == false
          ? SafeArea(
              child: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.loose,
                children: [
                  curved_card(
                    height: 147.sp,
                  ),

                  //approved orders
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.sp),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Good Day',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                ),
                                // 5517148947(EU)
                              ),
                              // IconButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         search = true;
                              //       });
                              //     },
                              //     icon: const Icon(
                              //       Icons.search,
                              //       color: Colors.white,
                              //     )),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Do you want to log out?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontSize: 10.sp,
                                              ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'No',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 13.sp,
                                                      color: Colors.blueAccent),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: SizedBox(
                                                      height: 40.sp,
                                                      width: 40.sp,
                                                      child: const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              Colors.blueAccent,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      SignISales.routeName,
                                                      (route) => false);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 13.sp,
                                                      color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.logout_outlined,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          FutureBuilder(
                            future: getName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text('-');
                              } else {
                                return Text(
                                  snapshot.data!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Container(
                            height: 25.76.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.sp),
                                topRight: Radius.circular(
                                  12.sp,
                                ),
                              ),
                              color: const Color(0xFF000FFF),
                            ),
                            child: Center(
                              child: Text(
                                'Approved Orders',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                              ),
                            ),
                          ),
                          Container(
                            height: 165.24.sp,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.sp),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 5.sp),
                                          SizedBox(
                                            width: 45.sp,
                                            child: Center(
                                              child: Text(
                                                ' Name',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45.sp,
                                            child: Center(
                                              child: Text(
                                                'Amount',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      SizedBox(
                                        height: 120.sp,
                                        child: FutureBuilder(
                                            future: ref
                                                .read(
                                                    approvalpageControllerProvider)
                                                .getApprovedOrders(
                                                    context: context),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (snapshot.hasData &&
                                                  snapshot.data!.isNotEmpty &&
                                                  snapshot.data != null) {
                                                return ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const Divider(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var data = snapshot.data!;
                                                    var customername =
                                                        data[index]
                                                            .customer_name;
                                                    var orderId =
                                                        data[index].order_id;
                                                    var amount =
                                                        data[index].amount;
                                                    var date = setDate(
                                                        data[index].timestamp);

                                                    return Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 5.sp,
                                                        ),
                                                        Orders(
                                                          amount:
                                                              formatNumberWithCommas(
                                                                  amount),
                                                          customername:
                                                              customername,
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
                                                        ?.copyWith(
                                                            fontSize: 9.sp),
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              crossAxisSpacing: 15.sp,
                              mainAxisSpacing: 15.sp,
                              children: [
                                //total revenue
                                Container(
                                  // width: 163,
                                  // height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.sp),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Revenue',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: const Color(
                                                    0xFF4960F9,
                                                  ),
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        FutureBuilder(
                                          future: ref
                                              .read(homeControllerProvider)
                                              .getRevenue(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Text('-');
                                            } else {
                                              String revenue = snapshot.data!;
                                              print(revenue);
                                              return Text(
                                                '₦${formatNumberWithCommas(revenue)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              );
                                            }
                                          },
                                        ),
                                        // SizedBox(height: 5.sp),
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                                width: 100.sp,
                                                height: 100.sp,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.sp),
                                                    image:
                                                        const DecorationImage(
                                                            image: NetworkImage(
                                                              'https://images.unsplash.com/photo-1534951009808-766178b47a4f?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                                            ),
                                                            fit:
                                                                BoxFit.cover))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //total orders
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.sp),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Orders',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: const Color(
                                                    0xFF4960F9,
                                                  ),
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        FutureBuilder(
                                          future: ref
                                              .read(homeControllerProvider)
                                              .getOrder(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Text('-');
                                            } else {
                                              String order = snapshot.data!;
                                              print(order);
                                              return Text(
                                                order,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              );
                                            }
                                          },
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                                width: 100.sp,
                                                height: 100.sp,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.sp),
                                                    image:
                                                        const DecorationImage(
                                                            image: NetworkImage(
                                                              'https://plus.unsplash.com/premium_photo-1670863088251-500151f2117b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8b3JkZXJzfGVufDB8fDB8fHww',
                                                            ),
                                                            fit:
                                                                BoxFit.cover))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                //Total customers
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.sp),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Shop',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: const Color(
                                                    0xFF4960F9,
                                                  ),
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        FutureBuilder(
                                          future: ref
                                              .read(homeControllerProvider)
                                              .getRep(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Text('-');
                                            } else {
                                              String rep = snapshot.data!;
                                              print(rep);
                                              return Text(
                                                rep,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              );
                                            }
                                          },
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                                width: 100.sp,
                                                height: 100.sp,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.sp),
                                                    image:
                                                        const DecorationImage(
                                                            image: NetworkImage(
                                                              'https://images.unsplash.com/photo-1521790797524-b2497295b8a0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y3VzdG9tZXJzfGVufDB8fDB8fHww',
                                                            ),
                                                            fit:
                                                                BoxFit.cover))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //Total amount
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.sp),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: const Color(
                                                    0xFF4960F9,
                                                  ),
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        FutureBuilder(
                                          future: ref
                                              .read(homeControllerProvider)
                                              .getOrderBalance(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Text('-');
                                            } else {
                                              String orderBalance =
                                                  snapshot.data!;
                                              return Text(
                                                '₦${formatNumberWithCommas(orderBalance)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              );
                                            }
                                          },
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                                width: 100.sp,
                                                height: 100.sp,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.sp),
                                                    image:
                                                        const DecorationImage(
                                                            image: NetworkImage(
                                                              'https://images.unsplash.com/photo-1604156425963-9be03f86a428?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTJ8fHxlbnwwfHx8fHw%3D',
                                                            ),
                                                            fit:
                                                                BoxFit.cover))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Container(
                height: double.infinity,
                color: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: Colors.white),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    search = false;
                                  });
                                },
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.grey),
                              ),
                              SizedBox(width: 10.sp),
                              Expanded(
                                child: TextField(
                                  onEditingComplete: () {
                                    setState(() {
                                      newID = stringList;
                                    });
                                    setState(() {});
                                  },
                                  autofocus: true,
                                  controller: text,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter productID',
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40.sp),
                      Center(
                        child: Text(
                          'Product searched',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(height: 10.sp),
                      FutureBuilder(
                          future: ref
                              .read(homeControllerProvider)
                              .searchProduct(
                                  productID: stringList, context: context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              ));
                            } else if (snapshot.data != [] ||
                                snapshot.data != null) {
                              return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.sp,
                                        mainAxisSpacing: 10.sp),
                                itemCount: snapshot.data.length,
                                // itemCount: 2,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data[index];
                                  if (data['productId'] != null) {
                                    if (data.containsKey('Res')) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.sp),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.sp),
                                          child: Text(
                                              "Product with the id ${data['productId']} doesn't exist",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontSize: 10.sp,
                                                  )),
                                        ),
                                      );
                                    } else {
                                      return SizedBox(
                                        height: 100.sp,
                                        width: 100.sp,
                                        child: store_widget(
                                          tap: () {},
                                          storeName: data['productName'],
                                          storeAddress:
                                              '₦${formatNumberWithCommas(data["productPrice"].toString())}',
                                          childWidget: Center(
                                            child: Text(
                                              'Delete Product',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Colors.red,
                                                    fontSize: 7.sp,
                                                  ),
                                            ),
                                          ),
                                          // 5517148847
                                          tapText: () {
                                            setState(() {
                                              // ID = data[0]['productId'];
                                            });
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(
                                                    'Do you want to delete product',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          fontSize: 10.sp,
                                                        ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'No',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                              color: Colors
                                                                  .blueAccent,
                                                              fontSize: 13.sp,
                                                            ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          deleteProduct();
                                                        });
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Text(
                                                        'Yes',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                              color: Colors.red,
                                                              fontSize: 13.sp,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          text1: 'Product',
                                          text2: 'Amount',
                                          image: data['imgUrl'],
                                        ),
                                      );
                                    }
                                  } else {
                                    return Center(
                                      child: Text(
                                        'No product found',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontSize: 10.sp,
                                            ),
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                            return Center(
                              // 5517148847(EU)
                              child: Text(
                                'No product found',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 10.sp,
                                    ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
