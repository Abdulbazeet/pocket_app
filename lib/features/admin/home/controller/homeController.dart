// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/features/admin/home/repository/homRepository.dart';

final homeControllerProvider = Provider(
  (ref) {
    final homeRepository = ref.read(homeepositoryProvider);
    return HomeController(homeRepository: homeRepository);
  },
);

class HomeController {
  final HomeRepository homeRepository;
  HomeController({
    required this.homeRepository,
  });
  Future<String?> getRevenue() {
    return homeRepository.getRevenue();
  }

  Future<String?> getOrder() {
    return homeRepository.getOrders();
  }

  Future<String?> getRep() {
    return homeRepository.getRep();
  }

  Future<String?> getOrderBalance() {
    return homeRepository.getOrderBalance();
  }

  Future searchProduct(
      {required List productID, required BuildContext context}) {
    return homeRepository.searchProduct(productID: productID, context: context);
  }
}
