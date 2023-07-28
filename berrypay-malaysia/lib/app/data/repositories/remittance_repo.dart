import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/model/remitx/sender.dart';
import 'package:berrypay_global_x/app/data/model/remitx/transaction.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';
import 'package:berrypay_global_x/app/data/providers/temp_provider.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class RemittanceRepo {
  final FasspayProvider _fasspayProvider = FasspayProvider();
  final TempProvider _tempProvider = TempProvider();
  final BpgMyProvider _bpgMyProvider = Get.find<BpgMyProvider>();

  performInAppPurchase(InAppPurchaseRequest request) =>
      _fasspayProvider.performInAppPurchase(request);

  getExchangerate(String from, String to, double amount) =>
      _tempProvider.getExchangeRate(from, to, amount);

  getExchangeRate() => _bpgMyProvider.getExchangeRate();

  transferOfFunds() => _bpgMyProvider.transferofFunds();

  getBeneficiary(String beneficiaryId) =>
      _bpgMyProvider.getBeneficiary(beneficiaryId);

  getBankList(String country) => _bpgMyProvider.getBankList(country);

  getTransactionPurpose() => _bpgMyProvider.getTransactionPurpose();

  getAvailableCountry() => _bpgMyProvider.getAvailableCountry();

  getRelationship() => _bpgMyProvider.getRelationship();

  getCustomerDocType() => _bpgMyProvider.getCustomerDocType();

  getOccupation() => _bpgMyProvider.getOccupation();

  agent(AgentRequest request) => _bpgMyProvider.agent(request);

  transferFee(TransferFeeRequest request) =>
      _bpgMyProvider.transferFee(request);

  senderRegister(SenderRegisterRequest request) =>
      _bpgMyProvider.registerSender(request);

  getPaymentMode(String country) => _bpgMyProvider.getPaymentMode(country);

  addBeneficiary(AddBeneficiaryRequest request) =>
      _bpgMyProvider.addBeneficiary(request);

  initiateTransaction(PayRequest request) =>
      _bpgMyProvider.initiateTransaction(request);

  updateBeneficary(String beneficiaryId, UpdateBeneficiaryRequest request) =>
      _bpgMyProvider.updateBeneficiary(beneficiaryId, request);

  getFpxTransaction(PaymentRequeryRequest request) =>
      _bpgMyProvider.getFpxTransaction(request);

  getSenderDetails(String senderId) =>
      _bpgMyProvider.getSenderDetails(senderId);

  displayTransferFee(String country, String currency) =>
      _bpgMyProvider.displayTransferFee(currency, country);

  commitRemit(ComitRemit comitRemit) => _bpgMyProvider.commitRemit(comitRemit);
  commitBillers(ComitRemit comitBiller) =>
      _bpgMyProvider.commitBiller(comitBiller);

  getBranchCode(String districtName, String bankName, String q) =>
      _bpgMyProvider.getBranchCode(districtName, bankName, q);

  getDistrict(String bankName, String q) =>
      _bpgMyProvider.getDistrict(bankName, q);
}
