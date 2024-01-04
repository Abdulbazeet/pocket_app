import 'package:flutter/material.dart';
import 'package:shopping_app/features/sales_rep/sales_approval_page/repository/sales_approval_repository.dart';
import 'package:shopping_app/features/sales_rep/sales_approval_page/repository/sales_approval_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/models/order.dart';

final salesRepApprovalController = Provider((ref) {
  final salesRepryProvider = ref.read(salesRepositoryProvider);
  return SalesApprovalController(salesRepository: salesRepryProvider);
});

class SalesApprovalController {
  final SalesRepository salesRepository;

  SalesApprovalController({required this.salesRepository});

  Future<List<Order>>  getAllOrders({required BuildContext context}) {
    return salesRepository.getallOrders(context: context);
  }
}
