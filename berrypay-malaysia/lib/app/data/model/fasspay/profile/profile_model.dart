import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SSUserProfileVO {
  final String? fullName;
  String? nickName;
  final String? identificationNo;
  final String? identificationImg;
  final IdentificationType? identificationType;
  final String? nationalityCountryCode;
  final String? mobileNo;
  final String? mobileNoCountryCode;
  String? email;
  final String? profilePicture;
  final List<SSWalletProfileVO>? walletProfileList;
  final String? referralCode;
  final String? superksId;
  final SSBiometricIdentificationVO? biometricIdentification;
  final SSProfileSettingsVO? profileSettings;
  final ProfileType? profileType;
  SSAddressVO? deliveryAddress;
  String? residentialAddress;
  SSAddressVO? address;
  final String? dateOfBirth;
  SSOccupationVO? occupation;
  GenderType? genderType;
  String? identificationIssuedDate;
  bool? isChecked;
  String? recentTransactionDateTime;
  bool? prepaidStatus;
  SSCardOrderVO? cardOrder;
  String? passportCountryCode;

  SSUserProfileVO({
    this.fullName,
    this.nickName,
    this.identificationNo,
    this.identificationImg,
    this.identificationType,
    this.nationalityCountryCode,
    this.mobileNo,
    this.mobileNoCountryCode,
    this.email,
    this.profilePicture,
    this.walletProfileList,
    this.referralCode,
    this.superksId,
    this.biometricIdentification,
    this.profileSettings,
    this.profileType,
    this.deliveryAddress,
    this.residentialAddress,
    this.dateOfBirth,
    this.occupation,
    this.genderType,
    this.identificationIssuedDate,
    this.isChecked,
    this.recentTransactionDateTime,
    this.prepaidStatus,
    this.cardOrder,
    this.passportCountryCode,
  });

  factory SSUserProfileVO.fromJson(Map<String, dynamic> json) =>
      _$SSUserProfileVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSUserProfileVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSProfileSettingsVO {
  final WalletAccountType? walletAccountType;
  final String? walletId;
  final String? fullName;
  final String? eMoneyMaxAmount;
  final String? maxTxnLimit;
  final String? maxDailyLimit;
  final String? maxMonthlyLimit;
  final bool? isAgentTopUpEnable;
  final bool? isTopUpEnable;
  final bool? isP2pEnable;
  final SSWalletCardVO? supplementCard;
  final String? profileBarcodeData;
  final List<SSMerchantCategoryVO>? supportedMerchantCategoryList;

  SSProfileSettingsVO(
      this.walletAccountType,
      this.walletId,
      this.fullName,
      this.eMoneyMaxAmount,
      this.maxTxnLimit,
      this.maxDailyLimit,
      this.maxMonthlyLimit,
      this.isAgentTopUpEnable,
      this.isTopUpEnable,
      this.isP2pEnable,
      this.supplementCard,
      this.profileBarcodeData,
      this.supportedMerchantCategoryList);

  factory SSProfileSettingsVO.fromJson(Map<String, dynamic> json) =>
      _$SSProfileSettingsVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSProfileSettingsVOToJson(this);
}

@JsonSerializable()
class SSBiometricIdentificationVO {
  final BiometricType? biometricType;
  final String? biometricValue;

  SSBiometricIdentificationVO(this.biometricType, this.biometricValue);

  factory SSBiometricIdentificationVO.fromJson(Map<String, dynamic> json) =>
      _$SSBiometricIdentificationVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSBiometricIdentificationVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSWalletProfileVO {
  final String? profileId;
  final String? profileName;
  final ProfileType? profileType;
  String? email;
  final String? address;
  final EKYCStatus? eKYCStatus;
  final String? profileMaxBalance;
  SSWalletProfileVO(this.profileId, this.profileName, this.profileType,
      this.email, this.address, this.eKYCStatus, this.profileMaxBalance);

  factory SSWalletProfileVO.fromJson(Map<String, dynamic> json) =>
      _$SSWalletProfileVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletProfileVOToJson(this);
}

@JsonSerializable()
class SSWalletCardVO {
  final String? cardId;
  final String? cardName;
  final String? cardNumber;
  final String? cardBalance;
  final CardAccountType? cardAccountType;
  final String? cardImage;
  final bool? isDefaultCard;
  final String? profileId;
  final CardType? cardType;
  final int? lastEditedDateTime;
  final CardStatusType? cardStatusType;
  final String? issuingBankName;
  final String? expiryDate;
  final String? cardSerialNo;
  final bool? isSharedBalance;
  final String? creditLimit;
  final String? issueCardId;

  SSWalletCardVO(
      this.cardId,
      this.cardName,
      this.cardNumber,
      this.cardBalance,
      this.cardAccountType,
      this.cardImage,
      this.isDefaultCard,
      this.profileId,
      this.cardType,
      this.lastEditedDateTime,
      this.cardStatusType,
      this.issuingBankName,
      this.expiryDate,
      this.cardSerialNo,
      this.isSharedBalance,
      this.creditLimit,
      this.issueCardId);

  factory SSWalletCardVO.fromJson(Map<String, dynamic> json) =>
      _$SSWalletCardVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletCardVOToJson(this);
}

@JsonSerializable()
class SSMerchantCategoryVO {
  final String? merchantCategoryId;
  final String? merchantCategoryName;
  final String? maxTxnLimit;
  final String? maxDailyLimit;

  SSMerchantCategoryVO(this.merchantCategoryId, this.merchantCategoryName,
      this.maxTxnLimit, this.maxDailyLimit);

  factory SSMerchantCategoryVO.fromJson(Map<String, dynamic> json) =>
      _$SSMerchantCategoryVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSMerchantCategoryVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSAddressVO {
  final String postalCode;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;

  SSAddressVO(this.postalCode, this.addressLine1, this.addressLine2, this.city,
      this.state);

  factory SSAddressVO.fromJson(Map<String, dynamic> json) =>
      _$SSAddressVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSAddressVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSOccupationVO {
  OccupationType occupationType;
  IndustryType industryType;
  String industryValue;

  SSOccupationVO(
    this.industryValue,
    this.occupationType,
    this.industryType,
  );

  factory SSOccupationVO.fromJson(Map<String, dynamic> json) =>
      _$SSOccupationVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSOccupationVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSCardOrderVO {
  int? issueCardId;
  String? cardName;
  String? industryTypeId;
  String? occupationTypeId;
  SSAddressVO? deliveryAddress;

  SSCardOrderVO(
    this.issueCardId,
    this.cardName,
    this.industryTypeId,
    this.occupationTypeId,
    this.deliveryAddress,
  );

  factory SSCardOrderVO.fromJson(Map<String, dynamic> json) =>
      _$SSCardOrderVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSCardOrderVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSUpdateProfileModelVO {
  bool? isRefreshAll = false;
  SSUserProfileVO? userProfile;
  SSUpgradeProgressVO? upgradeProgress;
  SSWalletCardVO? selectedWalletCard;
  SSEkycOcrVO? ekycOcrVO;
  bool? hasPassportInfoError = false;
  SSAnalyticVO? analytic;

  SSUpdateProfileModelVO();

  factory SSUpdateProfileModelVO.fromJson(Map<String, dynamic> json) =>
      _$SSUpdateProfileModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSUpdateProfileModelVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSUpgradeProgressVO {
  int? failCounter;
  String? failReasonMsg;

  SSUpgradeProgressVO({
    this.failCounter,
    this.failReasonMsg,
  });

  factory SSUpgradeProgressVO.fromJson(Map<String, dynamic> json) =>
      _$SSUpgradeProgressVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSUpgradeProgressVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSEkycOcrVO {
  String? ocrIdentificationNoFront;
  String? ocrFullName;
  String? ocrAddress;
  bool? ocrFrontFaceDetected;
  int? ocrRetryCounter;
  double? idMatchingScore;
  double? nameMatchingScore;

  SSEkycOcrVO({
    this.ocrIdentificationNoFront,
    this.ocrFullName,
    this.ocrAddress,
    this.ocrFrontFaceDetected,
    this.ocrRetryCounter,
    this.idMatchingScore,
    this.nameMatchingScore,
  });

  factory SSEkycOcrVO.fromJson(Map<String, dynamic> json) =>
      _$SSEkycOcrVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSEkycOcrVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSAnalyticVO {
  double? loadingTimeStamp;
  double? fireToServerTimeStamp;

  SSAnalyticVO({
    this.loadingTimeStamp,
    this.fireToServerTimeStamp,
  });

  factory SSAnalyticVO.fromJson(Map<String, dynamic> json) =>
      _$SSAnalyticVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSAnalyticVOToJson(this);
}
