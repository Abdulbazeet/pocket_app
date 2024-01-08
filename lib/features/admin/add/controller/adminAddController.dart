// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/features/admin/add/repository/adminAddRepository.dart';

final adminAddControllerProvider = Provider(
  (ref) {
    final adminAddRepository = ref.read(adminAddRepositoryProvider);
    return AdminAddController(adminAddRepository: adminAddRepository);
  },
);

class AdminAddController {
  final AdminAddRepository adminAddRepository;
  AdminAddController({
    required this.adminAddRepository,
  });
  void addStore({
    required BuildContext context,
    required String storename,
    required String username,
    required storeAddress,
    required String email,
    required String password,
    required String storePhoneNumber,
    required String secondNumber,
    required String secondAddress,
    required WidgetRef ref,
    required File? image,
  }) async {
    adminAddRepository.createStore(
      secondAddress: secondAddress,
      secondNumber: secondNumber,
      image: image,
      context: context,
      ref: ref,
      storename: storename,
      storeaddress: storeAddress,
      username: username,
      password: password,
      email: email,
      storePhoneNumber: storePhoneNumber,
    );
  }

  void addProduct({
    required BuildContext context,
    required WidgetRef ref,
    required int storeId,
    required double price,
    required String productName,
    required List productID,
    required String quantity,
    required File? productImage,
  }) {
    adminAddRepository.createProduct(
        productID: productID,
        productQuantity: quantity,
        context: context,
        ref: ref,
        storeId: storeId,
        price: price,
        productName: productName,
        productImage: productImage);
  }
}
