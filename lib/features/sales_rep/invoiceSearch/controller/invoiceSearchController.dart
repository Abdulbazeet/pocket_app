// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/features/sales_rep/invoiceSearch/repository/invoiceSearchRepository.dart';
import 'package:shopping_app/models/invoiceModel.dart';

final invoiceSearchControllerProvider = Provider((ref) {
  final invoiceSearchRepository = ref.read(invoiceSearchRepositoryProvider);
  return InvoiceSearchController(
      invoiceSearchRepository: invoiceSearchRepository);
});

class InvoiceSearchController {
  final InvoiceSearchRepository invoiceSearchRepository;
  InvoiceSearchController({
    required this.invoiceSearchRepository,
  });

  Future<List<InvoiceModel>> searchInvoice({required String orderId}) {
    return invoiceSearchRepository.getInvoiceData(orderId: orderId);
  }
}
