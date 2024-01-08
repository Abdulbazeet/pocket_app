// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/features/sales_rep/store/repository/sales_store_repository.dart';
import 'package:shopping_app/models/newProoductModel.dart';
import 'package:shopping_app/models/productModel.dart';
import 'package:shopping_app/models/product_group.dart';

final salesStorecontrollerProvider = Provider((ref) {
  final salesProductRepository = ref.read(salesStoreRepositoryProvider);
  return SalesStoreController(salesProductRepository: salesProductRepository);
});

class SalesStoreController {
  final SalesProductRepository salesProductRepository;
  SalesStoreController({
    required this.salesProductRepository,
  });
  Future<List<NewProdutModel>> getProducts(
      BuildContext context, WidgetRef ref) {
    return salesProductRepository.getProduct(context, ref);
  }



  List<Item> itemList(
      {required BuildContext context,
      required String productName,
      required int price,
      required List productId,
      required int quantity}) {
    return salesProductRepository.addToCart(
      productId: productId,
      context: context,
      productName: productName,
      amount: price,
      quantity: quantity,
    );
  }
}
