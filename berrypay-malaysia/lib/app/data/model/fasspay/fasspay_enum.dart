// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum CardAccountType {
  @JsonValue(-1)
  Unknown(-1),
  @JsonValue(0)
  EMoney(0),
  @JsonValue(1)
  CreditDebit(1),
  @JsonValue(2)
  CASA(2),
  @JsonValue(-2)
  Frozen(-2);

  const CardAccountType(this.value);

  final num? value;
}

enum CardType {
  @JsonValue(0)
  CardTypeVisa(0),
  @JsonValue(1)
  CardTypeMaster(1),
  @JsonValue(2)
  CardTypeAmex(2),
  @JsonValue(3)
  CardTypeJcb(3),
  @JsonValue(4)
  CardTypeMaestro(4),
  @JsonValue(5)
  CardTypeCIMBNiagaDebit(5),
  @JsonValue(6)
  CardTypeCIMBNiagaBizcard(6),
  @JsonValue(7)
  CardTypeUnionPay(7),
  @JsonValue(8)
  CardTypeMccs(8),
  @JsonValue(9)
  CardTypeEwallet(9);

  const CardType(this.value);

  final num? value;
}

enum CdcvmTransactionType {
  Unknown,
  Spending,
  Withdrawal,
  ChangeMobileNo,
  InAppPurchase,
  Misc,
  Detach,
  LinkSupCard,
  UnlinkSupCard,
  ConfigureSupCard,
  P2PSendMoney,
  P2PRequestMoney,
  QRRequest
}

enum ChannelType {
  @JsonValue(0)
  Unknown(0),
  @JsonValue(100)
  SpendingMerchantPresentedStatic(100),
  @JsonValue(101)
  SpendingMerchantPresentedDynamic(101),
  @JsonValue(102)
  SpendingCustomerPresentedStatic(102),
  @JsonValue(103)
  SpendingCustomerPresentedDynamic(103),
  @JsonValue(104)
  SpendingInAppPurchase(104),
  @JsonValue(105)
  SpendingPaymentGateway(105),
  @JsonValue(106)
  SpendingEcommerceLogin(106),
  @JsonValue(107)
  SpendingEcommerceQrDynamic(107),
  @JsonValue(108)
  SpendingCreditDebitCard(108),
  @JsonValue(109)
  SpendingCASA(109),
  @JsonValue(110)
  SpendingPhysicalCard(110),
  @JsonValue(200)
  TopUpCreditDebitCard(200),
  @JsonValue(201)
  TopUpCASA(201),
  @JsonValue(202)
  TopUpMPOS(202),
  @JsonValue(205)
  TopUpCredit(205),
  @JsonValue(206)
  TopUpDebit(206),
  @JsonValue(209)
  TopUpPayNow(209),
  @JsonValue(300)
  WithdrawalOwnCasa(300),
  @JsonValue(301)
  WithdrawalOtherCasa(301),
  @JsonValue(400)
  FundTransfer(400),
  @JsonValue(401)
  FundTransferP2p(401),
  @JsonValue(-1)
  PreAuthCreditCard(-1);

  const ChannelType(this.value);

  final num value;
}

enum IdentificationType {
  @JsonValue(0)
  IdentificationTypeNRIC(0),
  @JsonValue(1)
  IdentificationTypePassport(1);

  const IdentificationType(this.value);

  final num value;
}

enum LoginType {
  @JsonValue(-1)
  Unknown(-1),
  @JsonValue(0)
  WalletId(0),
  @JsonValue(1)
  MobileNo(1),
  @JsonValue(2)
  Email(2);

  const LoginType(this.value);

  final num value;
}

enum LoginMode {
  @JsonValue(-1)
  Unknown(-1),
  @JsonValue(10)
  Normal(10),
  @JsonValue(40)
  ChangePassword(40),
  @JsonValue(20)
  Otp(20);

  const LoginMode(this.value);

  final num value;
}

enum OtpType {
  @JsonValue(-1)
  Unknown(-1),
  @JsonValue(10)
  Registration(10),
  @JsonValue(20)
  Login(20),
  @JsonValue(21)
  LoginSwitchDevice(21),
  @JsonValue(30)
  ForgotPassword(30),
  @JsonValue(40)
  ForgotCdcvmPin(40),
  @JsonValue(50)
  ChangeMobileNo(50),
  @JsonValue(60)
  ResetCardPin(60),
  @JsonValue(70)
  UnbindCard(70),
  @JsonValue(80)
  Withdrawal(80);

  const OtpType(this.value);

  final num value;
}

enum ProfileType {
  @JsonValue(0)
  Personal(0),
  @JsonValue(1)
  Business(1),
  @JsonValue(2)
  PersonalVerified(2),
  @JsonValue(3)
  PersonalAdvance(3),
  @JsonValue(4)
  PersonalPremium(4),
  @JsonValue(-1)
  PersonalUnverified(-1);

  const ProfileType(this.value);

  final num value;
}

enum TopUpMethodType {
  @JsonValue(-1)
  TopUpMethodTypeUnknown(-1),
  @JsonValue(0)
  TopUpMethodTypeOnlineBanking(0),
  @JsonValue(1)
  TopUpMethodTypeVisa(1),
  @JsonValue(2)
  TopUpMethodTypeMastercard(2),
  @JsonValue(3)
  TopUpMethodTypeAmex(3),
  @JsonValue(5)
  TopUpMethodTypeCreditDebitCard(5),
  @JsonValue(6)
  TopUpMethodTypePayNow(6);

  const TopUpMethodType(this.value);

  final num value;
}

enum SpendingPassthroughMethodType {
  @JsonValue(-1)
  SpendingPassthroughMethodTypeUnknown(-1),
  @JsonValue(0)
  SpendingPassthroughMethodTypeOnlineBanking(0),
  @JsonValue(1)
  SpendingPassthroughMethodTypeVisa(1),
  @JsonValue(2)
  SpendingPassthroughMethodTypeMastercard(2),
  @JsonValue(3)
  SpendingPassthroughMethodTypeAmex(3),
  @JsonValue(4)
  SpendingPassthroughMethodTypeCreditDebitCard(4);

  const SpendingPassthroughMethodType(this.value);

  final num value;
}

enum TransactionStatusType {
  @JsonValue(0)
  Unknown(0),
  @JsonValue(100)
  Approved(100),
  @JsonValue(101)
  Processing(101),
  @JsonValue(102)
  Declined(102),
  @JsonValue(104)
  Settled(104),
  @JsonValue(105)
  Cancelled(105),
  @JsonValue(106)
  Open(106),
  @JsonValue(107)
  Voided(107),
  @JsonValue(113)
  Refunded(113),
  @JsonValue(-1)
  Authorized(-1);

  const TransactionStatusType(this.value);

  final num value;
}

enum TransactionType {
  @JsonValue(0)
  Unknown(0),
  @JsonValue(10)
  Spending(10),
  @JsonValue(20)
  TopUp(20),
  @JsonValue(30)
  Withdrawal(30),
  @JsonValue(31)
  WithdrawalCharges(31),
  @JsonValue(40)
  FundTransfer(40),
  @JsonValue(80)
  Cashback(80),
  @JsonValue(90)
  Refund(90),
  @JsonValue(-1)
  AuthCapture(-1);

  const TransactionType(this.value);

  final num value;
}

enum TransferInputType {
  @JsonValue(0)
  TransferInputTypeUnknown(0),
  @JsonValue(1)
  TransferInputTypeCredit(1),
  @JsonValue(2)
  TransferInputTypeDebit(2);

  const TransferInputType(this.value);

  final num value;
}

enum BillerPlatformType {
  @JsonValue(100)
  BillerPlatformTypeUnknown(100),
  @JsonValue(101)
  BillerPlatformTypeMobilePrepaid(101),
  @JsonValue(103)
  BillerPlatformTypeBillPayment(103);

  const BillerPlatformType(this.value);

  final num value;
}

enum BillPaymentFieldInputType {
  @JsonValue(-1)
  BillPaymentFieldInputTypeUnknown(-1),
  @JsonValue(0)
  BillPaymentFieldInputTypeAlphaNumeric(0),
  @JsonValue(1)
  BillPaymentFieldInputTypeNumeric(1),
  @JsonValue(2)
  BillPaymentFieldInputTypeMobileNumeric(2),
  @JsonValue(3)
  BillPaymentFieldInputTypeNRIC(3);

  const BillPaymentFieldInputType(this.value);

  final num value;
}

enum BillPaymentTransactionType {
  @JsonValue(0)
  BillPaymentTransactionTypeUnknown(0),
  @JsonValue(1)
  BillPaymentTransactionTypePIN(1),
  @JsonValue(2)
  BillPaymentTransactionTypeETU(2);

  const BillPaymentTransactionType(this.value);

  final num value;
}

enum BillPaymentAmountType {
  @JsonValue(0)
  BillPaymentAmountTypeUnknown(0),
  @JsonValue(1)
  BillPaymentAmountTypeStatic(1),
  @JsonValue(2)
  BillPaymentAmountTypeDynamic(2);

  const BillPaymentAmountType(this.value);

  final num value;
}

enum WalletAccountType {
  @JsonValue(0)
  WalletAccountTypeUnknown(0),
  @JsonValue(100)
  WalletAccountTypePrincipal(100),
  @JsonValue(-1)
  WalletAccountTypeSupplementary(-1);

  const WalletAccountType(this.value);

  final num value;
}

enum TransferRequestStatus {
  @JsonValue(100)
  Pending(100),
  @JsonValue(101)
  Approve(101),
  @JsonValue(102)
  Decline(102),
  @JsonValue(-1)
  Void(-1);

  const TransferRequestStatus(this.value);

  final num value;
}

enum TransferRequestType {
  @JsonValue(-1)
  TransferRequestTypeUnknown(-1),
  @JsonValue(0)
  TransferRequestTypePayer(0),
  @JsonValue(1)
  TransferRequestTypePayee(1),
  @JsonValue(2)
  TransferRequestTypeSplitBill(2);

  const TransferRequestType(this.value);

  final num value;
}

enum PreAuthMethodType {
  @JsonValue(-1)
  PreAuthMethodTypeUnknown(-1),
  @JsonValue(0)
  PreAuthMethodTypeCreditDebitCard(0);

  const PreAuthMethodType(this.value);

  final num value;
}

enum BiometricType {
  @JsonValue(-1)
  BiometricTypeUnknown(-1),
  @JsonValue(0)
  BioMetricTypeFace(0),
  @JsonValue(1)
  BiometricTypeFingerprint(1),
  @JsonValue(2)
  BiometricTypeVoice(2),
  @JsonValue(3)
  BiometricTypeIris(3);

  const BiometricType(this.value);

  final num value;
}

enum CdcvmPinStatusType {
  NotDetermined,
  Blocked,
  Active;
}

enum ComponentAlignmentType { Left, Middle, Right }

enum CardStatusType {
  @JsonValue(-1)
  CardStatusTypeUnknown(-1),
  @JsonValue(0)
  CardStatusTypeInactive(0),
  @JsonValue(2)
  CardStatusTypePendingActivation(2),
  @JsonValue(3)
  CardStatusTypeActive(3),
  @JsonValue(4)
  CardStatusTypeSuspended(4),
  @JsonValue(5)
  CardStatusTypeTerminated(5),
  @JsonValue(6)
  CardStatusTypePendingIssue(6);

  const CardStatusType(this.value);

  final num value;
}

enum OccupationType {
  Corporate(0),
  Consultant(1),
  Manager(2),
  MedicalWorker(3),
  Professional(4),
  PublicOfficial(5),
  Retiree(6),
  Sales(7),
  SelfEmployed(8),
  Student(9),
  Other(10),
  ;

  const OccupationType(this.value);

  final num value;
}

enum IndustryType {
  Agriculture,
  Architecture,
  ArmsManufacturer,
  ArtsDesign,
  Automobiles,
  Banking,
  Chemicals,
  Constructions,
  Education,
  Healthcare,
  ECOM,
  ElectronicRetail,
  Energy,
  Engineering,
  Entertainment,
  Charities,
  Business,
  Gaming,
  Government,
  Hospitality,
  Trade,
  Legal,
  Manufacturing,
  Media,
  Mining,
  Petroleum,
  PersonalAssistance,
  Goods,
  Professional,
  RealEstate,
  UsedDealers,
  SocialService,
  Culture,
  Sports,
  Fintech,
  Textiles,
  Retail,
  Transportation,
  Tourism,
  Utilities,
  Wholesale,
  Others;

  // const OccupationType(this.value);

  // final num value;
}

enum GenderType {
  @JsonValue(0)
  Female(0),
  @JsonValue(1)
  Male(1);

  const GenderType(this.value);

  final num value;
}

enum GatewayType {
  @JsonValue(-1)
  Unknown(-1),
  @JsonValue(0)
  IPay88(0),
  @JsonValue(1)
  TypeNapas(1),
  @JsonValue(2)
  VietinBank(2);

  const GatewayType(this.value);

  final num value;
}

enum FasspayBaseEnum {
  Default,
  Otp,
  Withdrawal,
  TopupCancel,
  TransferP2P,
  RequestP2P,
}

enum EKYCStatus {
  @JsonValue(101)
  NotVerify(101),
  @JsonValue(102)
  Verified(102),
  @JsonValue(103)
  Pending(103),
  @JsonValue(104)
  AdminVerified(104),
  @JsonValue(105)
  AdminRejected(105),
  @JsonValue(106)
  Failed(106),
  @JsonValue(107)
  AdminRejectedPremium(107),
  @JsonValue(108)
  AdminRejectedAdvance(108);

  const EKYCStatus(this.value);

  final num value;
}
