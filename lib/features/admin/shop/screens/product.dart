// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/widgets/text_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/utils.dart';
import '../controller/storeController.dart';

class EditProduct extends ConsumerStatefulWidget {
  final data;
  const EditProduct({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  ConsumerState<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends ConsumerState<EditProduct> {
  File? image;
  String? pickedImage;
  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
    String newImage = image!.path;
    print(newImage);
    setState(() {
      image = image;
    });
  }

  void updateProduct() {
    ref.read(adminStoreControllerProvider).updateProduct(
        context: context,
        name: nameController.text.isEmpty
            ? widget.data.product_name
            : nameController.text,
        storeId: widget.data.id.toString(),
        price: priceCotroller.text.isEmpty
            ? widget.data.price.toString()
            : priceCotroller.text,
        quantity: quanttyController.text,
        productId: widget.data.product_id.toString(),
        img_url: image);
  }

  Future<void> rebuildState(BuildContext context) async {
    setState(() {});
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceCotroller = TextEditingController();
  final TextEditingController quanttyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          setState(() {
            Navigator.pop(context, true);
            store = false;
          });
          return true;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                children: [
                  SizedBox(height: 50.sp),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Edit Product: ${widget.data.product_name}',
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        image == null
                            ? Container(
                                height: 120.sp,
                                width: 140.sp,
                                decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: NetworkImage(
                                  //       widget.data.img_url,
                                  //     ),
                                  //     fit: BoxFit.cover),
                                  color: const Color(0xFF1422FF),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10.sp,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 120.sp,
                                width: 140.sp,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover,
                                  ),
                                  color: const Color(0xFF1422FF),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10.sp,
                                    ),
                                  ),
                                ),
                              ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: double.infinity,
                            height: 50.sp,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.5),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                  10.sp,
                                ),
                                bottomLeft: Radius.circular(
                                  10.sp,
                                ),
                              ),
                            ),
                            child: IconButton(
                              onPressed: selectImage,
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28.sp,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  TextWidget(
                      hintText: widget.data.product_name,
                      controller: nameController),
                  SizedBox(
                    height: 10.sp,
                  ),
                  TextWidget(
                      hintText:
                          '₦${formatNumberWithCommas(widget.data.price.toString())}',
                      controller: priceCotroller),
                  SizedBox(
                    height: 10.sp,
                  ),
                  TextWidget(
                      hintText: '${widget.data.quantity}',
                      controller: quanttyController),
                  SizedBox(height: 25.sp),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1422FF),
                          minimumSize: const Size(double.infinity, 58)),
                      onPressed: () {
                        updateProduct();
                        setState(() {});
                      },
                      child: Text(
                        'Update Product',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
