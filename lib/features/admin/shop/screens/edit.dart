import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/common/utils.dart';
import 'package:shopping_app/common/widgets/new_text_widget.dart';
import 'package:shopping_app/features/admin/shop/controller/storeController.dart';
import 'package:shopping_app/screens/admin_main_page.dart';
import 'package:sizer/sizer.dart';

class Edit extends ConsumerStatefulWidget {
  const Edit({super.key});

  @override
  ConsumerState<Edit> createState() => _EditState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _salesRepnameController = TextEditingController();
final TextEditingController _locationController = TextEditingController();
final TextEditingController _secAddressCotroller = TextEditingController();
final TextEditingController _phonNumber = TextEditingController();
final TextEditingController _secondphonNumber = TextEditingController();

File? image;

class _EditState extends ConsumerState<Edit> {
  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
    String newImage = image!.path;
    print(newImage);
    setState(() {
      image = image;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async{
          setState(() {
            // Navigator.pop(context, true);
            Navigator.pushNamedAndRemoveUntil(
                context, AdminMainPage.routeName, (route) => false);
            store = true;
          });
          return false;
        },
        child: Card(
          elevation: 0,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.sp,
                vertical: 20.sp,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 60.sp,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        image == null
                            ? Container(
                                height: 100.sp,
                                width: 120.sp,
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
                                height: 100.sp,
                                width: 120.sp,
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
                            height: 30.sp,
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
                  NewTextWidget(
                      hintText: 'Enter Rep name',
                      controller: _salesRepnameController),
                  SizedBox(height: 10.sp),
                  NewTextWidget(
                      hintText: 'Enter Storename', controller: _nameController),
                  SizedBox(height: 10.sp),
                  NewTextWidget(
                      hintText: 'Enter Phone number',
                      type: TextInputType.phone,
                      controller: _phonNumber),
                  SizedBox(height: 10.sp),
                  NewTextWidget(
                      hintText: 'OPTIONAL:  Second number',
                      type: TextInputType.phone,
                      controller: _secondphonNumber),
                  SizedBox(height: 10.sp),
                  NewTextWidget(
                      hintText: 'Enter Address ',
                      controller: _locationController),
                  SizedBox(height: 10.sp),
                  NewTextWidget(
                      hintText: 'OPTIONAL:  Second Address',
                      controller: _secAddressCotroller),
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
                      saveStore();
                    },
                    child: Text(
                      'Create Store',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
