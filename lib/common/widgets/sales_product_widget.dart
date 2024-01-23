// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Sales_Product_widget extends StatelessWidget {
  final String productName;
  final String price;
  final String productImage;
  final String quantity;
  final VoidCallback? tapAction;

  const Sales_Product_widget({
    Key? key,
    required this.productName,
    required this.price,
    required this.productImage,
    required this.quantity,
    this.tapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapAction,
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              7,
            ),
            color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(
            2.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 11.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: productImage == null
                          ? const NetworkImage(
                              'https://images.unsplash.com/photo-1593421970636-570fcb157915?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGJsZW5kZXJ8ZW58MHx8MHx8fDA%3D')
                          : NetworkImage(productImage),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(
                    6.26,
                  ),
                  // color: const Color(
                  //   0xFFCED1D6,
                  // ),
                ),
              ),
              SizedBox(
                height: .4.h,
              ),
              Text(
                productName,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                height: .2.h,
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 7.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                height: .2.h,
              ),
              Text(
                quantity,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 7.5.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
