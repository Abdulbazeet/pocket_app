// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/common/widgets/sales_product_widget.dart';
import 'package:shopping_app/features/sales_rep/auth/screens/signInSales.dart';
import 'package:shopping_app/features/sales_rep/cart/screen/cart.dart';
import 'package:shopping_app/features/sales_rep/receipt/screens/receipt.dart';
import 'package:shopping_app/features/sales_rep/store/controller/sales_store_controller.dart';
import 'package:shopping_app/models/productModel.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;
import '../../../../common/utils.dart';
import '../../../../common/widgets/curved_card.dart';
import '../../../../models/newProoductModel.dart';

class StoreSales extends ConsumerStatefulWidget {
  const StoreSales({super.key});

  @override
  ConsumerState<StoreSales> createState() => _StoreSalesState();
}

class _StoreSalesState extends ConsumerState<StoreSales> {
  Future<int> checkId() async {
    try {
      int newId;

      http.Response response = await http.get(
          Uri.parse('https://smonitor.onrender.com/api/order/list/'),
          headers: <String, String>{
            'Authorization': 'Token 64df0db05bb71eeb0ddf9b64fd438abd5d3715ba',
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Random random = Random();

        do {
          newId = random.nextInt(90000) + 10000;
        } while (data.any((item) => item['order_id'] == newId));

        return newId;
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  void addToCart(
      {required List productID,
      required String productName,
      required int nPrice,
      required int quantity}) {
    ref.read(salesStorecontrollerProvider).itemList(
          productId: productID,
          context: context,
          productName: productName,
          price: nPrice,
          quantity: quantity,
        );
    updateBadgeContent();
  }

  String number = '';
  String itemCount() {
    String s = itemList.length.toString();
    setState(() {
      number = s;
    });
    return s;
  }

  void logOut() async {
    try {
      var token = await getToken();
      var status = await getAdminStatus();
      // print(token);
      // print(status);
      http.Response response = await http.post(
        Uri.parse('https://smonitor.onrender.com/api/logout/'),
        headers: <String, String>{
          'Authorization': 'Token $token',
        },
      );
      if (response.statusCode == 200) {
        SharedPreferences shared = await SharedPreferences.getInstance();
        shared.remove('token');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SignISales.routeName, (route) => false);
      } else {
        showSnackBar(context, response.reasonPhrase!);
        print(response.statusCode);
      }
    } catch (e) {}
  }

  String badgeContent = '';
  void updateBadgeContent() {
    setState(() {
      badgeContent =
          // ignore: prefer_is_empty
          (itemList.length == null ? '' : itemList.length.toString())!;
    });
  }

  @override
  void initState() {
    // itemList.length;
    // TODO: implement initState
    super.initState();
    updateBadgeContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            curved_card(
              height: 200.sp,
            ),
            Padding(
              padding: EdgeInsets.all(
                15.0.sp,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      badges.Badge(
                        badgeContent: Text(badgeContent),
                        child: IconButton(
                          onPressed: () async {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ReceiptPage(),
                            //     ));
                            int? setId = await checkId();
                            setState(() {
                              ID = setId;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ));
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                                            color: Colors.blueAccent,
                                          ),
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
                                      logOut();
                                    },
                                    child: Text(
                                      'Yes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 13.sp,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   'Store 1',

                  // ),
                  SizedBox(
                    width: 60.w,
                    child: FutureBuilder<List<NewProdutModel>>(
                        future: ref
                            .read(salesStorecontrollerProvider)
                            .getProducts(context, ref),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              '----',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            );
                          } else {
                            if (snapshot.data!.isNotEmpty &&
                                snapshot.data != null &&
                                snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, index) => Text(
                                  // snapshot.data!,
                                  snapshot.data![index].product_store,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              );
                            } else {
                              return Text(
                                '_________',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              );
                            }
                          }
                        }),
                  ),

                  SizedBox(
                    height: 30.sp,
                  ),
                  FutureBuilder<List<NewProdutModel>>(
                      future:
                          ref.read(salesStorecontrollerProvider).getProducts(
                                context,
                                ref,
                              ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade100,
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              crossAxisSpacing: 20.sp,
                              mainAxisSpacing: 20.sp,
                              children: [
                                Sales_Product_widget(
                                  quantity: '',
                                  tapAction: () {},
                                  price: '',
                                  productImage: '',
                                  productName: '',
                                ),
                                Sales_Product_widget(
                                  quantity: '',
                                  tapAction: () {},
                                  price: '',
                                  productImage: '',
                                  productName: '',
                                ),
                                Sales_Product_widget(
                                  quantity: '',
                                  tapAction: () {},
                                  price: '',
                                  productImage: '',
                                  productName: '',
                                ),
                                Sales_Product_widget(
                                  quantity: '',
                                  tapAction: () {},
                                  price: '',
                                  productImage: '',
                                  productName: '',
                                ),
                              ],
                            ),
                          );
                        } else {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!.isNotEmpty) {
                            return Expanded(
                                child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 20.sp,
                                mainAxisSpacing: 20.sp,
                                crossAxisCount: 2,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var storedata = snapshot.data![index];
                                var storeName = storedata.product_store;

                                newStoreName = storeName;
                                var productName = storedata.prdouct_name;
                                var quantity = storedata.product_quantity;
                                var productID = storedata.product_id;

                                var price = storedata.product_price;
                                var nPrice = price.toInt();
                                var image = storedata.product_image_url;
                                print(nPrice);
                                return Sales_Product_widget(
                                  price:
                                      // '₦${formatNumberWithCommas(price.toString())}',
                                      format.format(
                                    price,
                                  ),
                                  productImage: image,
                                  productName: productName,
                                  tapAction: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        int quantity = 1;

                                        return StatefulBuilder(
                                          builder: (context, setState) =>
                                              Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16.sp,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: 335.sp,
                                              height: 335.sp,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                    16.sp,
                                                  ),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 5.sp,
                                                  bottom: 3.sp,
                                                  right: 4.sp,
                                                  left: 15.sp,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 10.sp),
                                                    Center(
                                                      child: Container(
                                                        width: 160.sp,
                                                        height: 120.sp,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8.sp,
                                                          ),
                                                          image: DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                      image),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    const Spacer(),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          productName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15.sp),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Amount :',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                        SizedBox(width: 10.sp),
                                                        Text(
                                                          // '₦${formatNumberWithCommas(price.toString())}',
                                                          format.format(
                                                            price,
                                                          ),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 15.sp),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Quantity :',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                        SizedBox(width: 10.sp),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              4.sp,
                                                            ),
                                                            border: Border.all(
                                                              color:
                                                                  const Color(
                                                                0xffCED1D6,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (quantity >=
                                                                        1) {
                                                                      quantity =
                                                                          quantity -
                                                                              1;
                                                                      newQuantity =
                                                                          quantity;
                                                                    } else {
                                                                      quantity =
                                                                          0;
                                                                      newQuantity =
                                                                          quantity;
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 5.sp,
                                                                    bottom:
                                                                        3.sp,
                                                                    top: 3.sp,
                                                                  ),
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  width: 27.sp,
                                                                  height: 14.sp,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: quantity ==
                                                                            0
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            247,
                                                                            185,
                                                                            222,
                                                                            255)
                                                                        : const Color
                                                                            .fromARGB(
                                                                            247,
                                                                            96,
                                                                            178,
                                                                            249),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      4.sp,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5.sp,
                                                              ),
                                                              Text(
                                                                '$quantity',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge
                                                                    ?.copyWith(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                  width: 5.sp),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    quantity =
                                                                        quantity +
                                                                            1;
                                                                    newQuantity =
                                                                        quantity;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 5.sp,
                                                                    bottom:
                                                                        3.sp,
                                                                    top: 3.sp,
                                                                  ),
                                                                  width: 27.sp,
                                                                  height: 14.sp,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        247,
                                                                        96,
                                                                        178,
                                                                        249),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      4.sp,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // )
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                quantity == 0
                                                                    ? const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        163,
                                                                        173,
                                                                        238)
                                                                    : const Color(
                                                                        0xFF4960F9,
                                                                      ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed:
                                                              quantity == 0
                                                                  ? null
                                                                  : () {
                                                                      addToCart(
                                                                          productID:
                                                                              productID,
                                                                          productName:
                                                                              productName,
                                                                          nPrice:
                                                                              nPrice,
                                                                          quantity:
                                                                              quantity);
                                                                      // ref
                                                                      //     .read(
                                                                      //         salesStorecontrollerProvider)
                                                                      //     .itemList(
                                                                      //       productId:
                                                                      //           productID,
                                                                      //       context:
                                                                      //           context,
                                                                      //       productName:
                                                                      //           productName,
                                                                      //       price:
                                                                      //           nPrice,
                                                                      //       quantity:
                                                                      //           quantity,
                                                                      //     );
                                                                      // setState(
                                                                      //   () {
                                                                      //     number = itemList
                                                                      //         .length
                                                                      //         .toString();
                                                                      //   },
                                                                      // );

                                                                      Navigator.pop(
                                                                          context);
                                                                      imageList.add(
                                                                          image);
                                                                    },
                                                          child: Text(
                                                            'Add to Cart',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  quantity: 'QUANTITY: ${quantity.toString()} ',
                                );
                              },
                            ));
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150.sp,
                                  ),
                                  Text(
                                    'No Product',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      }
                      // },
                      )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
