import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/widgets/editStore.dart';
import 'package:shopping_app/common/widgets/newProductWidget.dart';
import 'package:shopping_app/common/widgets/product_widget.dart';
import 'package:shopping_app/common/widgets/store_widget.dart';
import 'package:shopping_app/features/admin/shop/controller/storeController.dart';
import 'package:shopping_app/features/admin/shop/screens/edit.dart';
import 'package:shopping_app/features/admin/shop/screens/product.dart';
import 'package:shopping_app/models/productModel.dart';
import 'package:shopping_app/models/store2model.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/utils.dart';
import '../../../../common/widgets/curved_card.dart';
import '../../../../common/widgets/new_text_widget.dart';
import '../../../sales_rep/auth/screens/signUpSales.dart';
import 'approvedStoreOrders.dart';

class Shop extends ConsumerStatefulWidget {
  const Shop({super.key});

  @override
  ConsumerState<Shop> createState() => _ShopState();
}

class _ShopState extends ConsumerState<Shop> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salesRepnameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _secAddressCotroller = TextEditingController();
  final TextEditingController _phonNumber = TextEditingController();
  final TextEditingController _secondphonNumber = TextEditingController();
  int index = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void saveStore() {
    ref.read(adminStoreControllerProvider).editStore(
        number: _phonNumber.text,
        repname: _salesRepnameController.text,
        secondAddres: _secAddressCotroller.text.isEmpty
            ? 'Nil'
            : _secAddressCotroller.text,
        secondNumber:
            _secondphonNumber.text.isEmpty ? 'Nil' : _secondphonNumber.text,
        image: image,
        context: context,
        storename: _nameController.text,
        id: storeID,
        storeAddress: _locationController.text);
  }

  void deleteStore() {
    ref
        .read(adminStoreControllerProvider)
        .deleteStore(id: storeID.toString(), context: context);
  }

  void deleteProduct() {
    ref
        .read(adminStoreControllerProvider)
        .deleteProduct(id: newProductId.toString(), context: context);
  }



  File? image;
  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
    String newImage = image!.path;
    print(newImage);
    setState(() {
      image = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: store
          ? SafeArea(
              child: Stack(
                fit: StackFit.loose,
                children: [
                  curved_card(
                    height: 200.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0.sp),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.sp,
                        ),
                        edit
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Edit Stores',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          edit = false;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ))
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Stores',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 30.sp,
                        ),
                        FutureBuilder<List<Store2Model>>(
                          future: ref
                              .read(adminStoreControllerProvider)
                              .getStores(context, ref),
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
                                    store_widget(
                                      image: '',
                                      text1: '',
                                      text2: '',
                                      childWidget: const SizedBox.shrink(),
                                      tapText: () {},
                                      tap: () {},
                                      storeName: '',
                                      storeAddress: '',
                                    ),
                                    store_widget(
                                      image: '',
                                      text1: '',
                                      text2: '',
                                      childWidget: const SizedBox.shrink(),
                                      tapText: () {},
                                      tap: () {},
                                      storeName: '',
                                      storeAddress: '',
                                    ),
                                    store_widget(
                                      image: '',
                                      text1: '',
                                      text2: '',
                                      childWidget: const SizedBox.shrink(),
                                      tapText: () {},
                                      tap: () {},
                                      storeName: '',
                                      storeAddress: '',
                                    ),
                                    store_widget(
                                      image: '',
                                      text1: '',
                                      text2: '',
                                      childWidget: const SizedBox.shrink(),
                                      tapText: () {},
                                      tap: () {},
                                      storeName: '',
                                      storeAddress: '',
                                    ),
                                  ],
                                ),
                              );
                            } else

                            // if (snapshot.connectionState ==
                            //     ConnectionState.) {
                            if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              return Expanded(
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10.sp,
                                    mainAxisSpacing: 10.sp,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var storedata = snapshot.data![index];
                                    var storename = storedata.name;
                                    var storeid = storedata.id;

                                    newStoreName = storename;

                                    var storeAddress = storedata.main_address;
                                    var storeImage = storedata.img_url;
                                    return InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          edit = true;
                                        });
                                      },
                                      child: edit
                                          ? edit_store_widget(
                                              image: storeImage,
                                              edit: () {
                                                storeID = storeid;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Edit(),
                                                    ));
                                                setState(() {});
                                              },
                                              delete: () {
                                                storeID = storeid;

                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                        'Do you want to delete store',
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
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'No',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  fontSize:
                                                                      13.sp,
                                                                ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              deleteStore();
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Text(
                                                            'Yes',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      13.sp,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                setState(() {});
                                              },
                                              storeName: storename.toString(),
                                              storeAddress:
                                                  storeAddress.toString())
                                          : store_widget(
                                              image: storeImage,
                                              text1: 'Name',
                                              text2: 'Store Name',
                                              tapText: () {},
                                              childWidget:SizedBox.shrink(),
                                              tap: () {
                                                setState(() {
                                                  storeID = storeid;

                                                  newStoreName = storename;
                                                  store = false;
                                                });
                                              },
                                              storeName: storename.toString(),
                                              storeAddress:
                                                  storeAddress.toString(),
                                            ),
                                    );
                                  },
                                ),
                              );
                              // }
                            }
                            return Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150.sp,
                                  ),
                                  Text(
                                    'No Store',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : SafeArea(
              child: Stack(
                fit: StackFit.loose,
                children: [
                  curved_card(
                    height: 200.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0.sp),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 45.sp,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60.w,
                              child: Text(
                                newStoreName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ApprovedStoreWidget(),
                                            ));
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.store,
                                    color: Colors.white,
                                    // size: 32.sp,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        store = true;
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_backspace_outlined,
                                    color: Colors.white,
                                    // size: 32.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.sp,
                        ),
                        FutureBuilder<List<ProductModel>>(
                          future: ref
                              .read(adminStoreControllerProvider)
                              .getProducts(context, ref, newStoreName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.grey.shade100,
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  crossAxisSpacing: 10.sp,
                                  mainAxisSpacing: 10.sp,
                                  children: [
                                    store_widget(
                                        image: '',
                                        text1: '',
                                        text2: '',
                                        tap: () {},
                                        storeName: '',
                                        storeAddress: '',
                                        childWidget: const SizedBox.shrink(),
                                        tapText: () {}),
                                    store_widget(
                                        image: '',
                                        text1: '',
                                        text2: '',
                                        tap: () {},
                                        storeName: '',
                                        storeAddress: '',
                                        childWidget: const SizedBox.shrink(),
                                        tapText: () {}),
                                    store_widget(
                                        image: '',
                                        text1: '',
                                        text2: '',
                                        tap: () {},
                                        storeName: '',
                                        storeAddress: '',
                                        childWidget: const SizedBox.shrink(),
                                        tapText: () {}),
                                  ],
                                ),
                              );
                            } else {
                              if (snapshot.hasData &&
                                  snapshot.data != null &&
                                  snapshot.data!.isNotEmpty) {
                                return Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10.sp,
                                      mainAxisSpacing: 10.sp,
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      var storedata = snapshot.data![index];
                                      var productName = storedata.product_name;
                                      var price = storedata.price;
                                      var image = storedata.img_url;
                                      var id = storedata.product_id;
                                      // var quantity =  storedata.pr
                                      var pID = removeEUSubstring(id);
                                      return InkWell(
                                        onLongPress: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return EditProduct(
                                                data: storedata,
                                              );
                                            },
                                          ));
                                        },
                                        child: store_widget(
                                            quantty:
                                                'QUANTITIES: ${storedata.quantity} ',
                                            image: image,
                                            tap: () {},
                                            storeName: productName,
                                            storeAddress:
                                                '₦${formatNumberWithCommas(price.toString())}',
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
                                            tapText: () {
                                              setState(() {
                                                newProductId = id;
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontSize:
                                                                        13.sp,
                                                                  ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            deleteProduct();
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 13.sp,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              setState(() {});
                                            },
                                            text1: 'Product',
                                            text2: 'Amount'),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 150.sp,
                                      ),
                                      Text(
                                        'No Product',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
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
