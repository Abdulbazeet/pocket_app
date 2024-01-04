// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/features/sales_rep/cart/cartController/cartController.dart';
import 'package:shopping_app/models/product_group.dart';
import 'package:shopping_app/screens/sales_rep_main-page.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../common/widgets/text_widget.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  double addedPrice = 0.0;
  int allQuantity = 1;
  double getTotal() {
    double total = 0.0;
    for (Item item in itemList) {
      total += item.price.toDouble() * item.quantity.toDouble();
    }
    return total;
  }

  void removeItem(int index) {
    // Use setState to update the UI
    // and trigger a rebuild with the updated list
    itemList.removeAt(index);
  }

  List<TextEditingController> product =
      List.generate(itemList.length, (index) => TextEditingController());
  List<FocusNode> focus =
      List.generate(itemList.length, (index) => FocusNode());

  final TextEditingController customrname = TextEditingController();
  final TextEditingController customerLocation = TextEditingController();
  final TextEditingController customerPhone = TextEditingController();
  final TextEditingController officePhone = TextEditingController();
  final TextEditingController deliveryCharges = TextEditingController();
  final TextEditingController bankTransfer = TextEditingController();
  final TextEditingController deliveryfEES = TextEditingController();
  final TextEditingController paymentRefAmount = TextEditingController();
  int netAmount = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    customerLocation.dispose();
    customerPhone.dispose();
    customrname.dispose();
    officePhone.dispose();
    deliveryCharges.dispose();
    bankTransfer.dispose();
    deliveryfEES.dispose();
    paymentRefAmount.dispose();
  }

  void uploadCart({
    required int orderId,
    required int price,
    required List productId,
  }) async {
    ref.read(cartControllerProvider).uploadCart(
          productId: productId,
          officePhoneNo: '',
          hasDeliveryCharge: getFormattedValue(),
          bankTransf: bankTransfer.text.isEmpty ? 'Nil' : bankTransfer.text,
          customerLocation: customerLocation.text,
          customerName: customrname.text,
          customerPhoneNo: customerPhone.text,
          deliveryCharge: isDeliveryFeesEnabled ? deliveryCharges.text : '0',
          context: context,
          orderId: orderId,
          price: price,
        );

    print(ID);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        // canPop: true,
        // onPopInvoked: (didPop) {
        //   Navigator.pop(context);
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, SalesRepMainPage.routeName, (route) => false);
        // },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.sp,
              vertical: 20.sp,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cart',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '${itemList.length} ITEMS',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 13.sp,
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 20.sp),
                SizedBox(
                  height: 430.sp,
                  child: ListView.builder(
                    itemCount: itemList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (itemList.isEmpty ||
                          itemList == [] ||
                          itemList.length == 0) {
                        return Center(
                          child: Text(
                            'Your cart is Empty',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 13.sp, color: Colors.black),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 112.sp,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.sp),
                                  SizedBox(
                                    width: 102.sp,
                                    child: Image.network(
                                      imageList[index],
                                      height: 102.sp,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 90.sp,
                                              child: Text(
                                                itemList[index].productName,
                                                maxLines: 5,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(fontSize: 10.sp),
                                              ),
                                            ),
                                            Text(
                                              'X ${itemList[index].quantity}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(fontSize: 10.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.sp,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₦${formatNumberWithCommas(itemList[index].price.toString())}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 10.sp),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                  'Do you want to remove the product ${itemList[index].productName} from the cart',
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
                                                              fontSize: 12.sp,
                                                              color: Colors
                                                                  .blueAccent),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        removeItem(index);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.sp),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'Do you want to clear cart?',
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
                                                fontSize: 12.sp,
                                                color: Colors.blueAccent,
                                              ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            itemList = [];
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text(
                                          'Yes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontSize: 12.sp,
                                                color: Colors.red,
                                              ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          Row(
                            children: [
                              Text(
                                'Payable Amount:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.grey, fontSize: 13.sp),
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                              Text(
                                '₦${formatNumberWithCommas(getTotal().toString())}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.grey, fontSize: 13.sp),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.sp),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                double.infinity,
                                38.sp,
                              ),
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            dispose() {}
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  List<TextEditingController> product = [];
                                  // List.generate(itemList.length, (index) {
                                  //   List<TextEditingController> control = [];
                                  //   return TextEditingController();
                                  // }, growable: true);
                                  List<FocusNode> focus = List.generate(
                                      itemList.length, (index) => FocusNode(),
                                      growable: true);
                                  // @override
                                  // void dispose() {
                                  //   product.forEach((element) {
                                  //     element.dispose();
                                  //   });
                                  //   super.dispose();
                                  // }

                                  return Dialog(
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 500.sp,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10.sp,
                                              ),
                                              Center(
                                                child: Text(
                                                  "Details",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontSize: 11.sp,
                                                      ),
                                                ),
                                              ),
                                              TextWidget(
                                                controller: customrname,
                                                hintText:
                                                    "Enter the cutomer's name",
                                              ),
                                              SizedBox(
                                                height: 15.sp,
                                              ),
                                              TextWidget(
                                                controller: customerLocation,
                                                hintText:
                                                    "Enter the cutomer's location",
                                              ),
                                              SizedBox(
                                                height: 15.sp,
                                              ),
                                              TextWidget(
                                                controller: customerPhone,
                                                hintText:
                                                    "Cutomer's contact: 23480...9",
                                              ),
                                              SizedBox(
                                                height: 15.sp,
                                              ),
                                              // TextWidget(
                                              //   controller: officePhone,
                                              //   hintText:
                                              //       "Office contact: 23480...9",
                                              // ),
                                              // SizedBox(
                                              //   height: 15.sp,
                                              // ),
                                              isDeliveryFeesEnabled
                                                  ? TextWidget(
                                                      controller:
                                                          deliveryCharges,
                                                      hintText:
                                                          "Enter Delivery fee",
                                                    )
                                                  : const SizedBox.shrink(),
                                              isDeliveryFeesEnabled
                                                  ? SizedBox(
                                                      height: 15.sp,
                                                    )
                                                  : const SizedBox.shrink(),
                                              TextWidget(
                                                controller: bankTransfer,
                                                hintText:
                                                    "OPIONAL: Enter bank details",
                                              ),
                                              SizedBox(
                                                height: 15.sp,
                                              ),
                                              ListView.separated(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    List<TextEditingController>
                                                        txt = List.generate(
                                                            itemList.length,
                                                            (index) =>
                                                                TextEditingController());
                                                    product = txt;
                                                    List<Widget>
                                                        editItems = List
                                                            .generate(
                                                                itemList[index]
                                                                    .quantity,
                                                                (NEWindex) =>
                                                                    SizedBox(
                                                                      width:
                                                                          40.w,
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            20.sp,
                                                                        width: 60
                                                                            .sp,
                                                                        child:
                                                                            TextField(
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge
                                                                              ?.copyWith(
                                                                                fontSize: 7.5.sp,
                                                                              ),
                                                                          focusNode:
                                                                              focus[index],
                                                                          controller:
                                                                              txt[NEWindex],
                                                                          decoration:
                                                                              InputDecoration(
                                                                            contentPadding:
                                                                                EdgeInsets.only(top: 4.sp).copyWith(left: 4.sp),
                                                                            hintText:
                                                                                'Enter productID',
                                                                            border:
                                                                                const OutlineInputBorder(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ));
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 8.0.sp,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 40.w,
                                                            child: Text(
                                                              itemList[index]
                                                                  .productName,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        8.5.sp,
                                                                  ),
                                                            ),
                                                          ),
                                                          Column(
                                                            children: editItems,
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const Divider(
                                                            color: Colors.grey,
                                                          ),
                                                  itemCount: itemList.length),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Delivery charges',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          fontSize: 10.sp,
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    width: 20.sp,
                                                  ),
                                                  Switch(
                                                    value:
                                                        isDeliveryFeesEnabled,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isDeliveryFeesEnabled =
                                                            value;
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(
                                                    double.infinity,
                                                    43.sp,
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xFF1422FF),
                                                ),
                                                onPressed: () {
                                                  print('done');
                                                  // productIdStrings = product
                                                  //     .map((e) => e.)
                                                  //     .toList();

                                                  // int balance = getTotal()
                                                  //         .toInt() -
                                                  //     int.parse(
                                                  //         paymentRefAmount.text);
                                                  // setState(() {
                                                  //   netAmount = balance;
                                                  // });
                                                  print('next');
                                                  uploadCart(
                                                      productId:
                                                          productIdStrings,
                                                      orderId: ID,
                                                      price:
                                                          getTotal().toInt());

                                                  print(customrname.text);
                                                },
                                                child: Text(
                                                  'Check out',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontSize: 12.sp,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          child: Text(
                            ' Pay ₦${formatNumberWithCommas(getTotal().toString())}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
