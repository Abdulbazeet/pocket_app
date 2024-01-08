import 'package:flutter/material.dart';
import 'package:shopping_app/features/sales_rep/sales_approval_page/screen/salesrep_approval_page.dart';

import 'package:sizer/sizer.dart';

import '../features/sales_rep/invoiceSearch/screen/invoiceSearch.dart';
import '../features/sales_rep/store/screens/store_sales.dart';

class SalesRepMainPage extends StatefulWidget {
  const SalesRepMainPage({super.key});
  static const String routeName = '/sales-rep-main-page';

  @override
  State<SalesRepMainPage> createState() => _SalesRepMainPageState();
}

class _SalesRepMainPageState extends State<SalesRepMainPage> {
  final List body = [
    StoreSales(),
    SalesRepApproval(),
    const InvoiceSearch(),
  ];
  int seletedIndex = 0;
  void onTap(int index) {
    setState(
      () {
        seletedIndex = index;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[seletedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 33.sp,
        elevation: 0,
        currentIndex: seletedIndex,
        onTap: (value) => onTap(value),
        items: [
          BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  Image.asset(
                    'assets/system-regular-41-home 1.jpg',
                  ),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Container(
                    height: 4.sp,
                    width: 4.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1422FF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              icon: Column(
                children: [
                  Image.asset('assets/system-regular-41-home 1.jpg'),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Container(
                    height: 4.sp,
                    width: 4.sp,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  Image.asset('assets/shop 1.jpg'),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Container(
                    height: 4.sp,
                    width: 4.sp,
                    decoration: const BoxDecoration(
                        color: Color(0xFF1422FF), shape: BoxShape.circle),
                  )
                ],
              ),
              icon: Column(
                children: [
                  Image.asset(
                    'assets/shop 1.jpg',
                  ),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Container(
                    height: 4.sp,
                    width: 4.sp,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  Image.asset('assets/test 1.jpg'),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Container(
                    height: 4.sp,
                    width: 4.sp,
                    decoration: const BoxDecoration(
                        color: Color(0xFF1422FF), shape: BoxShape.circle),
                  )
                ],
              ),
              icon: Column(
                children: [
                  Image.asset(
                    'assets/test 1.jpg',
                  ),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Container(
                    height: 4.sp,
                    width: 4.sp,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                  )
                ],
              ),
              label: ''),
        ],
      ),
    );
  }
}
