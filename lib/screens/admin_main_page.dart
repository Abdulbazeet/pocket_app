import 'package:flutter/material.dart';
import 'package:shopping_app/features/admin/approval_page/screens/approval_page.dart';
import 'package:shopping_app/features/admin/home/screens/home.dart';
import 'package:shopping_app/features/admin/shop/screens/shop.dart';
import 'package:sizer/sizer.dart';

import '../common/utils.dart';
import '../features/admin/add/screens/add.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});
  static const String routeName = '/admin-main-page';

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  void onTap(int index) {
    setState(() {
      seletedIndex = index;
    });
  }
  final List _pages = [
    const Home(),
    const Shop(),
    const Add(),
    const ApprovalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: _pages[seletedIndex],
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
                        color: Color(0xFF1422FF), shape: BoxShape.circle),
                  )
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
                  Image.asset('assets/add 1.jpg'),
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
                  Image.asset('assets/add 1.jpg'),
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
                  Image.asset(
                    'assets/test 1.jpg',
                  ),
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
