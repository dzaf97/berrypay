import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
// import 'package:dart_amqp/dart_amqp.dart';
import 'package:get/get.dart';

class ExchangeRateMyController extends GetxController {
  final RemittanceRepo remittanceRepo;
  final RegisterRepo registerRepo;
  final ProfileRepo profileRepo;
  ExchangeRateMyController(
      this.remittanceRepo, this.registerRepo, this.profileRepo);

  ExchangeRateResponse? exchangeRateResponse;

  final RxList<Country> countries = <Country>[].obs;
  List<RxDouble> foreignExchangesRate = [];
  RxBool isForExLoading = true.obs;
  List<Datum> dataExchange = [];

  final count = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    // getExchangeRate();

    // getExchangeRateRemit();
    getCountryList();

    // mq();
  }

  getCountryList() async {
    countries.value = await registerRepo.getCountry();

    getExchangeRateRemit();
  }

  // mq() async {
  //   logger("Setup mq");
  //   var client = Client(
  //     settings: ConnectionSettings(
  //       host: "mq.berrypay.dev",
  //       port: 25671,
  //       authProvider: const PlainAuthenticator("arsyad", "arsyad"),
  //       virtualHost: "bpg",
  //       onBadCertificate: (p0) => true,
  //       tlsContext: SecurityContext(withTrustedRoots: true),
  //     ),
  //   );

  //   bool isReceived = false;
  //   Channel channel = await client.channel();
  //   Queue queue = await channel.queue("dzaff"); //remitx.${transactionI}D
  //   Consumer consumer = await queue.consume();
  //   consumer.listen(
  //     (event) {
  //       isReceived = true;
  //       logger(event.payloadAsString);
  //       if (isReceived) {
  //         consumer.cancel();
  //         Get.back();
  //       }
  //     },
  //     onDone: () => queue.delete(),
  //   );
  // }

  getExchangeRateRemit() async {
    var response = await remittanceRepo.getExchangeRate();

    if (verifyResponse(response)) {
      isForExLoading(false);
      exchangeRateResponse = null;
      return;
    } else {
      response as ExchangeRateResponse;

      exchangeRateResponse = response;

      dataExchange = response.data ?? [];

      for (var element in dataExchange) {
        // logger(element.ReceiveCountry);

        var list =
            countries.firstWhere((e) => e.cca3 == element.ReceiveCountry);

        element.flag = list.flag;
        element.flags = list.flags;
      }

      logger('dataExchange ${jsonEncode(dataExchange)}');
    }

    isForExLoading(false);
  }
}
