// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class edit_store_widget extends StatelessWidget {
  final VoidCallback edit;
  final VoidCallback delete;
  final String storeName;
  final String image;
  final String storeAddress;
  const edit_store_widget({
    Key? key,
    required this.edit,
    required this.delete,
    required this.storeName,
    required this.image,
    required this.storeAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
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
              height: 12.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(
                  6.26,
                ),
                color: const Color(
                  0xFFCED1D6,
                ),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Text(
              storeName,
              maxLines: 1,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Text(
              storeAddress,
              maxLines: 1,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 7.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: edit,
                  child: Container(
                    height: 10.sp,
                    width: 30.sp,
                    child: const Icon(Icons.edit, color: Colors.black),
                  ),
                ),
                InkWell(
                  onTap: delete,
                  child: Container(
                    height: 10.sp,
                    width: 30.sp,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
