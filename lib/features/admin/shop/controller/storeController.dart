// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping_app/features/admin/shop/repository/shopRepository.dart';
import 'package:shopping_app/models/productModel.dart';
import 'package:shopping_app/models/store2model.dart';

import '../../../../models/order.dart';

final adminStoreControllerProvider = Provider((ref) {
  final adminStoreRepository = ref.read(storeRepositoryProvider);
  return AdminStoreController(adminStoreRepository: adminStoreRepository);
});

class AdminStoreController {
  final AdminStoreRepository adminStoreRepository;
  AdminStoreController({
    required this.adminStoreRepository,
  });
  Future<List<Store2Model>> getStores(
    BuildContext context,
    WidgetRef ref,
  ) {
    return adminStoreRepository.getStores(
      context,
      ref,
    );
  }

  //product
  Future<List<ProductModel>> getProducts(
      BuildContext context, WidgetRef ref, String storename) {
    return adminStoreRepository.getProduct(context, ref, storename);
  }

  void editStore({
    required BuildContext context,
    required String storename,
    required int id,
    required String storeAddress,
    required String secondAddres,
    required String number,
    required String secondNumber,
    required String repname,
    required File? image,
  }) {
    return adminStoreRepository.editStore(
      repname: repname,
      secondAddress: secondAddres,
      secondNumber: secondNumber,
      number: number,
      context: context,
      storename: storename,
      id: id,
      storeAddress: storeAddress,
      image: image,
    );
  }

  void deleteStore({required String id, required BuildContext context}) {
    return adminStoreRepository.deleteStore(id: id, context: context);
  }

  void deleteProduct({required String id, required BuildContext context}) {
    return adminStoreRepository.deleteProduct(id: id, context: context);
  }

  Future<List<Order>> getApprovedOrders(
      {required BuildContext context, required String id}) {
    return adminStoreRepository.getApprovedOrders(context: context, id: id);
  }

  void updateProduct(
      {required BuildContext context,
      required String name,
      required String storeId,
      required String price,
      required String quantity,
      required String productId,
      required File? img_url}) {
    return adminStoreRepository.updateProduct(
        storeId: storeId,
        img_url: img_url,
        name: name,
        productId: productId,
        price: price,
        quantity: quantity,
        context: context);
  }
}
