import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';

class SpendingRepo {
  final FasspayProvider _fasspayProvider = FasspayProvider();

  spending(SpendingRequest request) =>
      _fasspayProvider.performSpending(request);
  confirmSpending(SpendingRequest request) =>
      _fasspayProvider.performConfirmSpending(request);

  performSpendingQrRequest(SpendingQrRequest request) =>
      _fasspayProvider.performSpendingQrRequest(request);

  performSpendingQRCheckStatus(SpendingQrRequest request) =>
      _fasspayProvider.performSpendingQRCheckStatus(request);
}
