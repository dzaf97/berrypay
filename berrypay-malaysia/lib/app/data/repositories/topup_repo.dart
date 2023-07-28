import 'package:berrypay_global_x/app/data/model/fasspay/topup/topup.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';

class TopupRepo {
  final FasspayProvider _fasspayProvider = FasspayProvider();

  topupCheckStatus(TopUpCheckStatusRequest request) => _fasspayProvider.performTopUpCheckStatus(request);
  performTopUp(TopUpRequest request) => _fasspayProvider.performTopUp(request);
}
