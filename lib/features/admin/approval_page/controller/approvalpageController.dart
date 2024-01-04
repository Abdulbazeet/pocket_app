// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/models/order.dart';

import '../repository/approvalpageRepository.dart';

final approvalpageControllerProvider = Provider((ref) {
  final approvalpageRepository = ref.read(approvalpageRepositoryProvider);
  return ApprovalpageController(approvalpageRepository: approvalpageRepository);
});

class ApprovalpageController {
  final ApprovalPageRepository approvalpageRepository;
  ApprovalpageController({
    required this.approvalpageRepository,
  });
  Future<List<Order>> getAllProducts({required BuildContext context}) {
    return approvalpageRepository.getAllOrders(context: context);
  }

  void approveOrder({required BuildContext context, required int order_id}) {
    return approvalpageRepository.approveOrder(
        context: context, order_id: order_id);
  }

  void declineOrder({required BuildContext context, required int order_id}) {
    return approvalpageRepository.declineOrder(
        context: context, order_id: order_id);
  }

  void restoreStatus({required BuildContext context, required int order_id}) {
    return approvalpageRepository.restoreStatus(
        context: context, order_id: order_id);
  }

  Future<List<Order>> getApprovedOrders({
    required BuildContext context,
  }) {
    return approvalpageRepository.getApprovedOrders(context: context);
  }

  Future<List<Order>> getDeclined({
    required BuildContext context,
  }) {
    return approvalpageRepository.getDeclined(context: context);
  }
}
