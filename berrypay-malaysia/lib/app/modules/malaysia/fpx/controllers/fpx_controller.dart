import 'dart:async';
import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/fpx_model.dart';
import 'package:berrypay_global_x/app/data/model/remitx/transaction.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:crypto/crypto.dart';
// import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class FpxMyController extends GetxController {
  final RemittanceRepo remittanceRepo;
  FpxMyController(this.remittanceRepo);

  FpxModel? fpxModel;

  String? newRoute;

  String? fpxMerchantApiKey;
  String? fpxMerchantPublicKey;
  String? fpxSecretKey;

  Uri? url;
  PayResult? payResult;
  RxBool isLoading = false.obs;
  List<PaymentRequeryData>? paymentRequery = [];

  Uri triggerUrl = Uri.parse(dotenv.env['triggerUrl']!);
  Uri triggerUrlAffin = Uri.parse(dotenv.env['triggerUrlAffin']!);

  double progress = 0;
  int countdown = 5;
  Timer? timer;
  bool isCountdown = false;
  bool isCanGoBack = true;
  String? category;

  @override
  void onInit() async {
    category = Get.arguments['category'];
    if (category == 'Biller') {
      fpxMerchantApiKey = dotenv.env['billFpxMerchantApiKey']!;
      fpxMerchantPublicKey = dotenv.env['billerFpxMerchantPublicKey']!;
      fpxSecretKey = dotenv.env['billFpxSecretKey']!;

      logger(fpxMerchantPublicKey);
    } else {
      fpxMerchantApiKey = dotenv.env['fpxMerchantApiKey']!;
      fpxMerchantPublicKey = dotenv.env['fpxMerchantPublicKey']!;
      fpxSecretKey = dotenv.env['fpxSecretKey']!;
    }

    url = Uri.parse('${dotenv.env['UrlFpx']!}/$fpxMerchantPublicKey');
    fpxModel = Get.arguments['fpxModel'];
    // logger(fpxModel!.txnBuyerName);
    newRoute = Get.arguments['newRoute'];
    logger('category ::$category');

    logger('start 1');
    // var client = Client(
    //   settings: ConnectionSettings(
    //     host: "mq.berrypay.dev",
    //     port: 25671,
    //     authProvider: const PlainAuthenticator("arsyad", "arsyad"),
    //     virtualHost: "bpg",
    //     onBadCertificate: (p0) => true,
    //     tlsContext: SecurityContext(withTrustedRoots: true),
    //   ),
    // );

    // bool isReceived = false;
    // Channel channel = await client.channel();

    // Queue queue = await channel.queue(
    //   "REMITX.${fpxModel!.txnOrderId}",
    // ); //remitx.${transactionI}D

    // logger('que: $queue');
    // Consumer consumer = await queue.consume();
    // consumer.listen(
    //   (event) {
    //     logger('mq listeningggggg');
    //     isReceived = true;
    //     var response = jsonDecode(event.payloadAsString);
    //     logger(event.payloadAsString);

    //     payResult = PayResult.fromJson(response);

    //     logger(payResult?.toJson());

    //     // PayResult payResult;

    //     if (isReceived) {
    //       consumer.cancel();
    //       // Get.back();

    //       Get.offAndToNamed(newRoute!, arguments: {
    //         'amount': fpxModel!.txnAmount.toStringAsFixed(2),
    //         'txnId': fpxModel!.txnOrderId,
    //         'status': 'SUCCESS',
    //         'statusRemit': payResult?.Result,
    //         'message': payResult?.Message
    //       });
    //     }
    //   },
    //   // onDone: () => queue.delete(),
    // );

    super.onInit();

    // mq();
  }

  String getSignature() {
    String signature;

    List<int> key = utf8.encode(fpxSecretKey!);
    List<int> bytes = utf8.encode('$fpxMerchantApiKey|'
        '${fpxModel!.txnAmount.toStringAsFixed(2)}|'
        '${fpxModel!.txnBuyerEmail}|'
        '${fpxModel!.txnBuyerName}|'
        '${fpxModel!.txnBuyerPhone}|'
        '${fpxModel!.txnOrderId}|'
        '${fpxModel!.txnProductDesc}|'
        '${fpxModel!.txnProductName}');

    Hmac hmacSha256 = Hmac(sha256, key);
    Digest digest = hmacSha256.convert(bytes);

    signature = digest.toString();

    return signature;
  }

  getFpxTransaction() async {
    logger('start getFpxTransaction');
    isLoading(true);

    var response = await remittanceRepo.getFpxTransaction(PaymentRequeryRequest(
      BpgTxnId: fpxModel!.txnOrderId,
    ));

    if (verifyResponse(response)) {
      isLoading(false);
      logger('cannot get');
      return;
    }
    isLoading(false);

    response as PaymentRequeryResponse;

    paymentRequery = response.data;
    logger('paymentRequery ${jsonEncode(paymentRequery)}');
    logger('category1:: $category');

    Get.offAndToNamed(newRoute!, arguments: {
      'amount': fpxModel!.txnAmount.toStringAsFixed(2),
      'txnId': fpxModel!.txnOrderId,
      'status': paymentRequery![0].paymentModeStatus,
      'message': paymentRequery![0].paymentModeStatusMsg,
      'description': paymentRequery![0].bizSysStatusMsg,
      'statusRemit': paymentRequery![0].bizSysStatus,
      'paymentMode': paymentRequery![0].paymentMode,
      'category': category
    });
  }
}
