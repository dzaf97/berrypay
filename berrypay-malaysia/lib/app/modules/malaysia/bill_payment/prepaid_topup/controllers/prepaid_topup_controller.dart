import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/remitx/bill.dart';
import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:get/get.dart';

class PrepaidTopupController extends GetxController {
  final BillRepo billRepo;
  PrepaidTopupController(this.billRepo);

  List<DataPrepaid>? dataPrepaid = [];
  List<DataPostpaid> dataPostpaid = [];
  RxBool isLoading = false.obs;
  String? page;

  List<Telco> telco = [
    Telco(
      'Maxis',
      'https://www.maxis.com.my/content/dam/mxs/images/global-images/maxislogo.jpg',
    ),
    Telco(
      'Digi',
      'https://www.businesstoday.com.my/wp-content/uploads/2020/05/Digi-Logo-1280x906.jpg',
    ),
    Telco(
      'Celcom',
      'https://1000logos.net/wp-content/uploads/2020/11/Celcom-Logo.jpg',
    ),
  ];
  String? routes;

  final count = 0.obs;

  @override
  void onInit() {
    routes = Get.arguments['route'];
    page = Get.arguments['page'];

    if (page == 'prepaid') {
      getPrepaidList();
    } else if (page == 'postpaid') {
      logger('start');
      getPostpaidList();
    }

    super.onInit();
  }

  getPrepaidList() async {
    isLoading(true);
    var response = await billRepo.getPrepaidList();

    if (verifyResponse(response)) {
      logger(response);
      isLoading(false);

      return;
    }

    response as PrepaidListResponse;

    dataPrepaid = response.data ?? [];

    logger(dataPrepaid);

    isLoading(false);
  }

  getPostpaidList() async {
    isLoading(true);
    var response = await billRepo.getPostpaidList();

    if (verifyResponse(response)) {
      isLoading(false);
      logger('get postpaid list error');
      return;
    }

    response as PostpaidListResponse;
    dataPostpaid = response.data ?? [];
    isLoading(false);
  }
}

class Telco {
  final String? title;
  final String? imageUrl;

  Telco(this.title, this.imageUrl);
}
