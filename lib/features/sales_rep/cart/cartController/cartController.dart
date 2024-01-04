// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/features/sales_rep/cart/cartRepository/cartRepository.dart';

final cartControllerProvider = Provider(
  (ref) {
    final cartRepository = ref.read(cartRepositoryProvider);
    return CartController(cartRepository: cartRepository);
  },
);

class CartController {
  final CartRepository cartRepository;
  CartController({
    required this.cartRepository,
  });
  void uploadCart({
    required BuildContext context,
    required int orderId,
    required String customerLocation,
    required String customerName,
    required String customerPhoneNo,
    required String officePhoneNo,
    required String bankTransf,
    required List productId,
    required String deliveryCharge,
    required String hasDeliveryCharge,
    required int price,
  }) {
    return cartRepository.uploadCart(
      productIds: productId,
      hasDeliveryCharge: hasDeliveryCharge,
      bankTransf: bankTransf,
      deliveryCharge: deliveryCharge,
      customerLocation: customerLocation,
      customerName: customerName,
      officePhoneNo: officePhoneNo,
      customerPhoneNo: customerPhoneNo,
      context: context,
      orderId: orderId,
      price: price,
    );
  }
}
