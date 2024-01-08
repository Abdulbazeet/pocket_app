// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/widgets/curved_card.dart';
import 'package:shopping_app/features/admin/add/controller/adminAddController.dart';
import 'package:sizer/sizer.dart';
import 'package:shopping_app/common/widgets/text_box.dart';

import '../../../../common/utils.dart';
import '../../../../common/widgets/text_widget.dart';

class Add extends ConsumerStatefulWidget {
  const Add({super.key});

  @override
  ConsumerState<Add> createState() => _AddState();
}

class _AddState extends ConsumerState<Add> {
  void addStore() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 40.sp,
            width: 40.sp,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ),
        );
      },
    );
    ref.read(adminAddControllerProvider).addStore(
        secondAddress: _secondLocationController.text.isEmpty
            ? 'Nil'
            : _secondLocationController.text,
        secondNumber: _secondStoreNumberController.text.isEmpty
            ? 'Nil'
            : _secondStoreNumberController.text,
        password: _passwordController.text,
        context: context,
        storename: _nameController.text,
        storeAddress: _locationController.text,
        ref: ref,
        username: _salesRepNameController.text,
        email: _emailController.text,
        image: image,
        storePhoneNumber: _storeNumberController.text);
    Navigator.pop(context);
  }

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
  // void chooseImage() async {
  //   image = await pick(context);
  //   setState(() {});
  //   print(image);
  // }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _secondLocationController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _salesRepNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _productIDController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _storeNumberController = TextEditingController();
  final TextEditingController _secondStoreNumberController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _locationController.dispose();
  }

  // List<String> _id = [];
  //     final _id = _id.add(_productIDController.text);

  void addProduct() {
    print('add');
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 40.sp,
            width: 40.sp,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ),
        );
      },
    );
    String _id = _productIDController.text;
    List<String> _productID = [];
    _productID.add(_id);
    ref.read(adminAddControllerProvider).addProduct(
          productID: _productID,
          quantity: _quantityController.text,
          context: context,
          ref: ref,
          storeId: storeID,
          price: double.parse(_priceController.text),
          productName: _productNameController.text,
          productImage: image,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: store
          ? SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    curved_card(
                      height: 130.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        15.sp,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.sp,
                          ),
                          Text(
                            'Create a store',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          SizedBox(
                            height: 70.sp,
                          ),
                          SizedBox(
                            height: 350.sp,
                            child: ListView(
                              // shrinkWrap: true,
                              children: [
                                Center(
                                  child: Stack(
                                    children: [
                                      image == null
                                          ? Container(
                                              height: 120.sp,
                                              width: 140.sp,
                                              decoration: BoxDecoration(
                                                // image:DecorationImage(image: image),
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
                                SizedBox(height: 20.sp),
                                TextWidget(
                                    hintText: 'Enter Store name',
                                    controller: _nameController),
                                SizedBox(height: 10.sp),
                                TextWidget(
                                    hintText: 'Enter Sales rep name',
                                    controller: _salesRepNameController),
                                SizedBox(height: 10.sp),
                                TextWidget(
                                    hintText: 'Enter location',
                                    controller: _locationController),
                                SizedBox(height: 10.sp),
                                TextWidget(
                                    hintText:
                                        'OPTIONAL:  Enter second location     ',
                                    controller: _secondLocationController),
                                SizedBox(height: 10.sp),
                                TextWidget(
                                    hintText: 'Enter Store Phone Number',
                                    type: TextInputType.phone,
                                    controller: _storeNumberController),
                                SizedBox(height: 10.sp),
                                TextWidget(
                                    hintText: 'OPTIONAL: Enter Second Number',
                                    type: TextInputType.phone,
                                    controller: _secondStoreNumberController),
                                SizedBox(height: 10.sp),
                                TextWidget(
                                    hintText: 'Enter email',
                                    controller: _emailController),
                                SizedBox(height: 10.sp),
                                TextWidget(
                                    hintText: 'Enter password',
                                    controller: _passwordController),
                                SizedBox(height: 20.sp),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                      double.infinity,
                                      43.sp,
                                    ),
                                    backgroundColor: const Color(0xFF1422FF),
                                  ),
                                  onPressed: () {
                                    if (_nameController.text.isEmpty ||
                                        _locationController.text.isEmpty ||
                                        _priceController.text.isEmpty ||
                                        _storeNumberController.text.isEmpty ||
                                        _emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty) {
                                      showSnackBar(context,
                                          'All necessary field needs to be filled');
                                    } else {
                                      addStore();
                                    }
                                  },
                                  child: Text(
                                    'Create Store',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    curved_card(
                      height: 130.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        15.sp,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.sp,
                          ),
                          Text(
                            'Create a product',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          SizedBox(
                            height: 70.sp,
                          ),
                          Center(
                            child: Stack(
                              children: [
                                image == null
                                    ? Container(
                                        height: 120.sp,
                                        width: 140.sp,
                                        decoration: BoxDecoration(
                                          // image:DecorationImage(image: image),
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
                          SizedBox(height: 20.sp),
                          TextWidget(
                              hintText: 'Enter Product name',
                              controller: _productNameController),
                          SizedBox(height: 10.sp),
                          TextWidget(
                              hintText: 'Enter price',
                              type: TextInputType.number,
                              controller: _priceController),
                          SizedBox(height: 10.sp),
                          TextWidget(
                              hintText: 'Enter Quantity',
                              type: TextInputType.number,
                              controller: _quantityController),
                          SizedBox(height: 10.sp),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                double.infinity,
                                43.sp,
                              ),
                              backgroundColor: const Color(0xFF1422FF),
                            ),
                            onPressed: () {
                              if (_productNameController.text.isEmpty ||
                                  _priceController.text.isEmpty ||
                                  _quantityController.text.isEmpty) {
                                showSnackBar(context,
                                    'All necessary fields needs to be filled ');
                              } else {
                                addProduct();
                              }
                            },
                            child: Text(
                              'Create Product',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
