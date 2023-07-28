import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';

class TransactionRepo {
  final FasspayProvider _fasspayProvider = FasspayProvider();

  getTransactionHistory(String walletId, String cardId, String pagingNo) => _fasspayProvider.performGetTransactionHistory(walletId, cardId, pagingNo);
}
