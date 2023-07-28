import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transfer/transfer_model.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';

class TransferRepo {
  final FasspayProvider _fasspayProvider = FasspayProvider();

  verifyP2P(String walletId, List<String> phoneNumbers) => _fasspayProvider.performVerifyP2P(walletId, phoneNumbers);
  verifyP2PBarcode(VerifyP2PBarcodeRequest request) => _fasspayProvider.performVerifyP2PBarcode(request);
  requestP2P(Requestp2p request) => _fasspayProvider.performRequestP2P(request);
  transferP2P(TransferP2PRequest request) => _fasspayProvider.performTransferP2P(request);
  getProfileBarcode(String walletId) => _fasspayProvider.performGetProfileBarcode(walletId);
  requestHistory(String walletId, String cardId) => _fasspayProvider.performRequestHistory(walletId, cardId);
}
