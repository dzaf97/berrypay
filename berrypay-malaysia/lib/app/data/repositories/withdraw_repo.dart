import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';

class WithdrawRepo {
  final FasspayProvider _fasspayProvider = FasspayProvider();

  withdrawalCheck(String walletId, String cardId) => _fasspayProvider.performWithdrawalCheck(walletId, cardId);
  withdrawal(String walletId, String cardId, SSWithdrawalDetailVO request) => _fasspayProvider.performWithdrawal(walletId, cardId, request);
  confirmWithdrawal(String walletId, String cardId, String transactionRequestId) =>
      _fasspayProvider.performConfirmWithdrawal(walletId, cardId, transactionRequestId);
}
