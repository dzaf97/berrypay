import 'package:berrypay_global_x/app/data/model/remitx/bill.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:get/get.dart';

class BillRepo {
  final BpgMyProvider _bpgMyProvider = Get.find<BpgMyProvider>();

  getPrepaidList() => _bpgMyProvider.getPrepaidList();

  getPostpaidList() => _bpgMyProvider.getPostpaidList();

  billPurchase(BillPurchaseRequest request) =>
      _bpgMyProvider.billPurchase(request);

  initiateBiller(InitiateBillerRequest request) =>
      _bpgMyProvider.initiateBiller(request);
}
