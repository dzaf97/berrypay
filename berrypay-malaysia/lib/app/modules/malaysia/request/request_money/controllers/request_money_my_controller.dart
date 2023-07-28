import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';

class RequestMoneyMyController extends GetxController {
  final TransferRepo transferRepo;
  RequestMoneyMyController(this.transferRepo);

  String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";
  String cardId = Get.find<StorageProvider>()
          .getSSWalletCardModelVO()
          ?.walletCardList
          ?.first
          .cardId ??
      "";

  RxList<SSWalletTransferDetailVO> contactList = RxList();
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    getContactList();
    super.onInit();
  }

  getContactList() async {
    isLoading(true);
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    logger('verify p2p 2');

    List<String> phoneNumbers = contacts
        .where((element) => element.phones!.isNotEmpty)
        .map((e) => e.phones?.first.value ?? "")
        .toList();

    logger('phone number: $phoneNumbers');

    logger("Contact List: $phoneNumbers");
    FasspayBase response = await transferRepo.verifyP2P(walletId, phoneNumbers);

    SSWalletTransferModelVO walletTransferModelVO =
        SSWalletTransferModelVO.fromJson(jsonDecode(response.payload!));
    logger("Verify P2P: ${jsonEncode(walletTransferModelVO.p2pList)}");
    contactList.value = walletTransferModelVO.p2pList ?? [];
    for (var element in contactList) {
      element.isCheck = RxBool(false);
    }

    isLoading(false);

    logger('contactList :: ${jsonEncode(contactList)}');

    // Requestp2p requestp2p =
    //     Requestp2p(walletId: walletId, cardId: cardId, amount: '10');
  }

  // requestMoney() async {
  //   List<ContactDetail> p2pRequestList = contactList
  //       .map((element) => ContactDetail(
  //           walletId: element.userProfile!.profileSettings!.walletId,
  //           amount: "10"))
  //       .toList();
  //       // {
  //       //   "walletId": "",
  //       //   "cardId": "",
  //       //   "p2pRequestList": p2pRequestList
  //       // }
  //   Requestp2p requestp2p =
  //       Requestp2p(walletId: walletId, cardId: cardId, amount: '10');

  //   // var response = fasspayRepo.performRequestP2P(requestp2p, ssWalletTransferModelVO.p2pList![0].userProfile!)
  // }

  selectWallet(SSUserProfileVO userProfileVO) {
    Get.toNamed(Routes.WALLET_INFO_MY, arguments: userProfileVO);
  }
}
