import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class store_widget extends StatelessWidget {
  final VoidCallback tap;
  final String storeName;
  final String storeAddress;
  final String image;
  final String text1;
  final String text2;
  final String? quantty;
  final Widget childWidget;
  final VoidCallback tapText;
  const store_widget({
    super.key,
    required this.tap,
    required this.storeName,
    required this.storeAddress,
    required this.childWidget,
    required this.tapText,
    required this.text1,
    required this.text2,
    required this.image,
    this.quantty = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: 50.sp,
        // height: 30.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              7,
            ),
            color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(
            2.w,
          ).copyWith(bottom: 0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      image,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(
                    6.26,
                  ),
                  color: const Color(
                    0xFFCED1D6,
                  ),
                ),
              ),
              SizedBox(
                height: .2.h,
              ),
              Text(
                storeName,
                maxLines: 1,
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 7.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                height: .2.h,
              ),
              Text(
                storeAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 7.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                height: .2.h,
              ),
              Text(
                "$quantty",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 7.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              InkWell(onTap: tapText, child: childWidget),
            ],
          ),
        ),
      ),
    );
  }
}
