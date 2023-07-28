// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSUserProfileVO _$SSUserProfileVOFromJson(Map<String, dynamic> json) =>
    SSUserProfileVO(
      fullName: json['fullName'] as String?,
      nickName: json['nickName'] as String?,
      identificationNo: json['identificationNo'] as String?,
      identificationImg: json['identificationImg'] as String?,
      identificationType: $enumDecodeNullable(
          _$IdentificationTypeEnumMap, json['identificationType']),
      nationalityCountryCode: json['nationalityCountryCode'] as String?,
      mobileNo: json['mobileNo'] as String?,
      mobileNoCountryCode: json['mobileNoCountryCode'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profilePicture'] as String?,
      walletProfileList: (json['walletProfileList'] as List<dynamic>?)
          ?.map((e) => SSWalletProfileVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      referralCode: json['referralCode'] as String?,
      superksId: json['superksId'] as String?,
      biometricIdentification: json['biometricIdentification'] == null
          ? null
          : SSBiometricIdentificationVO.fromJson(
              json['biometricIdentification'] as Map<String, dynamic>),
      profileSettings: json['profileSettings'] == null
          ? null
          : SSProfileSettingsVO.fromJson(
              json['profileSettings'] as Map<String, dynamic>),
      profileType:
          $enumDecodeNullable(_$ProfileTypeEnumMap, json['profileType']),
      deliveryAddress: json['deliveryAddress'] == null
          ? null
          : SSAddressVO.fromJson(
              json['deliveryAddress'] as Map<String, dynamic>),
      residentialAddress: json['residentialAddress'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      occupation: json['occupation'] == null
          ? null
          : SSOccupationVO.fromJson(json['occupation'] as Map<String, dynamic>),
      genderType: $enumDecodeNullable(_$GenderTypeEnumMap, json['genderType']),
      identificationIssuedDate: json['identificationIssuedDate'] as String?,
      isChecked: json['isChecked'] as bool?,
      recentTransactionDateTime: json['recentTransactionDateTime'] as String?,
      prepaidStatus: json['prepaidStatus'] as bool?,
      cardOrder: json['cardOrder'] == null
          ? null
          : SSCardOrderVO.fromJson(json['cardOrder'] as Map<String, dynamic>),
      passportCountryCode: json['passportCountryCode'] as String?,
    )..address = json['address'] == null
        ? null
        : SSAddressVO.fromJson(json['address'] as Map<String, dynamic>);

Map<String, dynamic> _$SSUserProfileVOToJson(SSUserProfileVO instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'nickName': instance.nickName,
      'identificationNo': instance.identificationNo,
      'identificationImg': instance.identificationImg,
      'identificationType':
          _$IdentificationTypeEnumMap[instance.identificationType],
      'nationalityCountryCode': instance.nationalityCountryCode,
      'mobileNo': instance.mobileNo,
      'mobileNoCountryCode': instance.mobileNoCountryCode,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'walletProfileList':
          instance.walletProfileList?.map((e) => e.toJson()).toList(),
      'referralCode': instance.referralCode,
      'superksId': instance.superksId,
      'biometricIdentification': instance.biometricIdentification?.toJson(),
      'profileSettings': instance.profileSettings?.toJson(),
      'profileType': _$ProfileTypeEnumMap[instance.profileType],
      'deliveryAddress': instance.deliveryAddress?.toJson(),
      'residentialAddress': instance.residentialAddress,
      'address': instance.address?.toJson(),
      'dateOfBirth': instance.dateOfBirth,
      'occupation': instance.occupation?.toJson(),
      'genderType': _$GenderTypeEnumMap[instance.genderType],
      'identificationIssuedDate': instance.identificationIssuedDate,
      'isChecked': instance.isChecked,
      'recentTransactionDateTime': instance.recentTransactionDateTime,
      'prepaidStatus': instance.prepaidStatus,
      'cardOrder': instance.cardOrder?.toJson(),
      'passportCountryCode': instance.passportCountryCode,
    };

const _$IdentificationTypeEnumMap = {
  IdentificationType.IdentificationTypeNRIC: 0,
  IdentificationType.IdentificationTypePassport: 1,
};

const _$ProfileTypeEnumMap = {
  ProfileType.Personal: 0,
  ProfileType.Business: 1,
  ProfileType.PersonalVerified: 2,
  ProfileType.PersonalAdvance: 3,
  ProfileType.PersonalPremium: 4,
  ProfileType.PersonalUnverified: -1,
};

const _$GenderTypeEnumMap = {
  GenderType.Female: 0,
  GenderType.Male: 1,
};

SSProfileSettingsVO _$SSProfileSettingsVOFromJson(Map<String, dynamic> json) =>
    SSProfileSettingsVO(
      $enumDecodeNullable(
          _$WalletAccountTypeEnumMap, json['walletAccountType']),
      json['walletId'] as String?,
      json['fullName'] as String?,
      json['eMoneyMaxAmount'] as String?,
      json['maxTxnLimit'] as String?,
      json['maxDailyLimit'] as String?,
      json['maxMonthlyLimit'] as String?,
      json['isAgentTopUpEnable'] as bool?,
      json['isTopUpEnable'] as bool?,
      json['isP2pEnable'] as bool?,
      json['supplementCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['supplementCard'] as Map<String, dynamic>),
      json['profileBarcodeData'] as String?,
      (json['supportedMerchantCategoryList'] as List<dynamic>?)
          ?.map((e) => SSMerchantCategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSProfileSettingsVOToJson(
        SSProfileSettingsVO instance) =>
    <String, dynamic>{
      'walletAccountType':
          _$WalletAccountTypeEnumMap[instance.walletAccountType],
      'walletId': instance.walletId,
      'fullName': instance.fullName,
      'eMoneyMaxAmount': instance.eMoneyMaxAmount,
      'maxTxnLimit': instance.maxTxnLimit,
      'maxDailyLimit': instance.maxDailyLimit,
      'maxMonthlyLimit': instance.maxMonthlyLimit,
      'isAgentTopUpEnable': instance.isAgentTopUpEnable,
      'isTopUpEnable': instance.isTopUpEnable,
      'isP2pEnable': instance.isP2pEnable,
      'supplementCard': instance.supplementCard?.toJson(),
      'profileBarcodeData': instance.profileBarcodeData,
      'supportedMerchantCategoryList': instance.supportedMerchantCategoryList
          ?.map((e) => e.toJson())
          .toList(),
    };

const _$WalletAccountTypeEnumMap = {
  WalletAccountType.WalletAccountTypeUnknown: 0,
  WalletAccountType.WalletAccountTypePrincipal: 100,
  WalletAccountType.WalletAccountTypeSupplementary: -1,
};

SSBiometricIdentificationVO _$SSBiometricIdentificationVOFromJson(
        Map<String, dynamic> json) =>
    SSBiometricIdentificationVO(
      $enumDecodeNullable(_$BiometricTypeEnumMap, json['biometricType']),
      json['biometricValue'] as String?,
    );

Map<String, dynamic> _$SSBiometricIdentificationVOToJson(
        SSBiometricIdentificationVO instance) =>
    <String, dynamic>{
      'biometricType': _$BiometricTypeEnumMap[instance.biometricType],
      'biometricValue': instance.biometricValue,
    };

const _$BiometricTypeEnumMap = {
  BiometricType.BiometricTypeUnknown: -1,
  BiometricType.BioMetricTypeFace: 0,
  BiometricType.BiometricTypeFingerprint: 1,
  BiometricType.BiometricTypeVoice: 2,
  BiometricType.BiometricTypeIris: 3,
};

SSWalletProfileVO _$SSWalletProfileVOFromJson(Map<String, dynamic> json) =>
    SSWalletProfileVO(
      json['profileId'] as String?,
      json['profileName'] as String?,
      $enumDecodeNullable(_$ProfileTypeEnumMap, json['profileType']),
      json['email'] as String?,
      json['address'] as String?,
      $enumDecodeNullable(_$EKYCStatusEnumMap, json['eKYCStatus']),
      json['profileMaxBalance'] as String?,
    );

Map<String, dynamic> _$SSWalletProfileVOToJson(SSWalletProfileVO instance) =>
    <String, dynamic>{
      'profileId': instance.profileId,
      'profileName': instance.profileName,
      'profileType': _$ProfileTypeEnumMap[instance.profileType],
      'email': instance.email,
      'address': instance.address,
      'eKYCStatus': _$EKYCStatusEnumMap[instance.eKYCStatus],
      'profileMaxBalance': instance.profileMaxBalance,
    };

const _$EKYCStatusEnumMap = {
  EKYCStatus.NotVerify: 101,
  EKYCStatus.Verified: 102,
  EKYCStatus.Pending: 103,
  EKYCStatus.AdminVerified: 104,
  EKYCStatus.AdminRejected: 105,
  EKYCStatus.Failed: 106,
  EKYCStatus.AdminRejectedPremium: 107,
  EKYCStatus.AdminRejectedAdvance: 108,
};

SSWalletCardVO _$SSWalletCardVOFromJson(Map<String, dynamic> json) =>
    SSWalletCardVO(
      json['cardId'] as String?,
      json['cardName'] as String?,
      json['cardNumber'] as String?,
      json['cardBalance'] as String?,
      $enumDecodeNullable(_$CardAccountTypeEnumMap, json['cardAccountType']),
      json['cardImage'] as String?,
      json['isDefaultCard'] as bool?,
      json['profileId'] as String?,
      $enumDecodeNullable(_$CardTypeEnumMap, json['cardType']),
      json['lastEditedDateTime'] as int?,
      $enumDecodeNullable(_$CardStatusTypeEnumMap, json['cardStatusType']),
      json['issuingBankName'] as String?,
      json['expiryDate'] as String?,
      json['cardSerialNo'] as String?,
      json['isSharedBalance'] as bool?,
      json['creditLimit'] as String?,
      json['issueCardId'] as String?,
    );

Map<String, dynamic> _$SSWalletCardVOToJson(SSWalletCardVO instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'cardName': instance.cardName,
      'cardNumber': instance.cardNumber,
      'cardBalance': instance.cardBalance,
      'cardAccountType': _$CardAccountTypeEnumMap[instance.cardAccountType],
      'cardImage': instance.cardImage,
      'isDefaultCard': instance.isDefaultCard,
      'profileId': instance.profileId,
      'cardType': _$CardTypeEnumMap[instance.cardType],
      'lastEditedDateTime': instance.lastEditedDateTime,
      'cardStatusType': _$CardStatusTypeEnumMap[instance.cardStatusType],
      'issuingBankName': instance.issuingBankName,
      'expiryDate': instance.expiryDate,
      'cardSerialNo': instance.cardSerialNo,
      'isSharedBalance': instance.isSharedBalance,
      'creditLimit': instance.creditLimit,
      'issueCardId': instance.issueCardId,
    };

const _$CardAccountTypeEnumMap = {
  CardAccountType.Unknown: -1,
  CardAccountType.EMoney: 0,
  CardAccountType.CreditDebit: 1,
  CardAccountType.CASA: 2,
  CardAccountType.Frozen: -2,
};

const _$CardTypeEnumMap = {
  CardType.CardTypeVisa: 0,
  CardType.CardTypeMaster: 1,
  CardType.CardTypeAmex: 2,
  CardType.CardTypeJcb: 3,
  CardType.CardTypeMaestro: 4,
  CardType.CardTypeCIMBNiagaDebit: 5,
  CardType.CardTypeCIMBNiagaBizcard: 6,
  CardType.CardTypeUnionPay: 7,
  CardType.CardTypeMccs: 8,
  CardType.CardTypeEwallet: 9,
};

const _$CardStatusTypeEnumMap = {
  CardStatusType.CardStatusTypeUnknown: -1,
  CardStatusType.CardStatusTypeInactive: 0,
  CardStatusType.CardStatusTypePendingActivation: 2,
  CardStatusType.CardStatusTypeActive: 3,
  CardStatusType.CardStatusTypeSuspended: 4,
  CardStatusType.CardStatusTypeTerminated: 5,
  CardStatusType.CardStatusTypePendingIssue: 6,
};

SSMerchantCategoryVO _$SSMerchantCategoryVOFromJson(
        Map<String, dynamic> json) =>
    SSMerchantCategoryVO(
      json['merchantCategoryId'] as String?,
      json['merchantCategoryName'] as String?,
      json['maxTxnLimit'] as String?,
      json['maxDailyLimit'] as String?,
    );

Map<String, dynamic> _$SSMerchantCategoryVOToJson(
        SSMerchantCategoryVO instance) =>
    <String, dynamic>{
      'merchantCategoryId': instance.merchantCategoryId,
      'merchantCategoryName': instance.merchantCategoryName,
      'maxTxnLimit': instance.maxTxnLimit,
      'maxDailyLimit': instance.maxDailyLimit,
    };

SSAddressVO _$SSAddressVOFromJson(Map<String, dynamic> json) => SSAddressVO(
      json['postalCode'] as String,
      json['addressLine1'] as String,
      json['addressLine2'] as String,
      json['city'] as String,
      json['state'] as String,
    );

Map<String, dynamic> _$SSAddressVOToJson(SSAddressVO instance) =>
    <String, dynamic>{
      'postalCode': instance.postalCode,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
    };

SSOccupationVO _$SSOccupationVOFromJson(Map<String, dynamic> json) =>
    SSOccupationVO(
      json['industryValue'] as String,
      $enumDecode(_$OccupationTypeEnumMap, json['occupationType']),
      $enumDecode(_$IndustryTypeEnumMap, json['industryType']),
    );

Map<String, dynamic> _$SSOccupationVOToJson(SSOccupationVO instance) =>
    <String, dynamic>{
      'occupationType': _$OccupationTypeEnumMap[instance.occupationType]!,
      'industryType': _$IndustryTypeEnumMap[instance.industryType]!,
      'industryValue': instance.industryValue,
    };

const _$OccupationTypeEnumMap = {
  OccupationType.Corporate: 'Corporate',
  OccupationType.Consultant: 'Consultant',
  OccupationType.Manager: 'Manager',
  OccupationType.MedicalWorker: 'MedicalWorker',
  OccupationType.Professional: 'Professional',
  OccupationType.PublicOfficial: 'PublicOfficial',
  OccupationType.Retiree: 'Retiree',
  OccupationType.Sales: 'Sales',
  OccupationType.SelfEmployed: 'SelfEmployed',
  OccupationType.Student: 'Student',
  OccupationType.Other: 'Other',
};

const _$IndustryTypeEnumMap = {
  IndustryType.Agriculture: 'Agriculture',
  IndustryType.Architecture: 'Architecture',
  IndustryType.ArmsManufacturer: 'ArmsManufacturer',
  IndustryType.ArtsDesign: 'ArtsDesign',
  IndustryType.Automobiles: 'Automobiles',
  IndustryType.Banking: 'Banking',
  IndustryType.Chemicals: 'Chemicals',
  IndustryType.Constructions: 'Constructions',
  IndustryType.Education: 'Education',
  IndustryType.Healthcare: 'Healthcare',
  IndustryType.ECOM: 'ECOM',
  IndustryType.ElectronicRetail: 'ElectronicRetail',
  IndustryType.Energy: 'Energy',
  IndustryType.Engineering: 'Engineering',
  IndustryType.Entertainment: 'Entertainment',
  IndustryType.Charities: 'Charities',
  IndustryType.Business: 'Business',
  IndustryType.Gaming: 'Gaming',
  IndustryType.Government: 'Government',
  IndustryType.Hospitality: 'Hospitality',
  IndustryType.Trade: 'Trade',
  IndustryType.Legal: 'Legal',
  IndustryType.Manufacturing: 'Manufacturing',
  IndustryType.Media: 'Media',
  IndustryType.Mining: 'Mining',
  IndustryType.Petroleum: 'Petroleum',
  IndustryType.PersonalAssistance: 'PersonalAssistance',
  IndustryType.Goods: 'Goods',
  IndustryType.Professional: 'Professional',
  IndustryType.RealEstate: 'RealEstate',
  IndustryType.UsedDealers: 'UsedDealers',
  IndustryType.SocialService: 'SocialService',
  IndustryType.Culture: 'Culture',
  IndustryType.Sports: 'Sports',
  IndustryType.Fintech: 'Fintech',
  IndustryType.Textiles: 'Textiles',
  IndustryType.Retail: 'Retail',
  IndustryType.Transportation: 'Transportation',
  IndustryType.Tourism: 'Tourism',
  IndustryType.Utilities: 'Utilities',
  IndustryType.Wholesale: 'Wholesale',
  IndustryType.Others: 'Others',
};

SSCardOrderVO _$SSCardOrderVOFromJson(Map<String, dynamic> json) =>
    SSCardOrderVO(
      json['issueCardId'] as int?,
      json['cardName'] as String?,
      json['industryTypeId'] as String?,
      json['occupationTypeId'] as String?,
      json['deliveryAddress'] == null
          ? null
          : SSAddressVO.fromJson(
              json['deliveryAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SSCardOrderVOToJson(SSCardOrderVO instance) =>
    <String, dynamic>{
      'issueCardId': instance.issueCardId,
      'cardName': instance.cardName,
      'industryTypeId': instance.industryTypeId,
      'occupationTypeId': instance.occupationTypeId,
      'deliveryAddress': instance.deliveryAddress?.toJson(),
    };

SSUpdateProfileModelVO _$SSUpdateProfileModelVOFromJson(
        Map<String, dynamic> json) =>
    SSUpdateProfileModelVO()
      ..isRefreshAll = json['isRefreshAll'] as bool?
      ..userProfile = json['userProfile'] == null
          ? null
          : SSUserProfileVO.fromJson(
              json['userProfile'] as Map<String, dynamic>)
      ..upgradeProgress = json['upgradeProgress'] == null
          ? null
          : SSUpgradeProgressVO.fromJson(
              json['upgradeProgress'] as Map<String, dynamic>)
      ..selectedWalletCard = json['selectedWalletCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['selectedWalletCard'] as Map<String, dynamic>)
      ..ekycOcrVO = json['ekycOcrVO'] == null
          ? null
          : SSEkycOcrVO.fromJson(json['ekycOcrVO'] as Map<String, dynamic>)
      ..hasPassportInfoError = json['hasPassportInfoError'] as bool?
      ..analytic = json['analytic'] == null
          ? null
          : SSAnalyticVO.fromJson(json['analytic'] as Map<String, dynamic>);

Map<String, dynamic> _$SSUpdateProfileModelVOToJson(
        SSUpdateProfileModelVO instance) =>
    <String, dynamic>{
      'isRefreshAll': instance.isRefreshAll,
      'userProfile': instance.userProfile?.toJson(),
      'upgradeProgress': instance.upgradeProgress?.toJson(),
      'selectedWalletCard': instance.selectedWalletCard?.toJson(),
      'ekycOcrVO': instance.ekycOcrVO?.toJson(),
      'hasPassportInfoError': instance.hasPassportInfoError,
      'analytic': instance.analytic?.toJson(),
    };

SSUpgradeProgressVO _$SSUpgradeProgressVOFromJson(Map<String, dynamic> json) =>
    SSUpgradeProgressVO(
      failCounter: json['failCounter'] as int?,
      failReasonMsg: json['failReasonMsg'] as String?,
    );

Map<String, dynamic> _$SSUpgradeProgressVOToJson(
        SSUpgradeProgressVO instance) =>
    <String, dynamic>{
      'failCounter': instance.failCounter,
      'failReasonMsg': instance.failReasonMsg,
    };

SSEkycOcrVO _$SSEkycOcrVOFromJson(Map<String, dynamic> json) => SSEkycOcrVO(
      ocrIdentificationNoFront: json['ocrIdentificationNoFront'] as String?,
      ocrFullName: json['ocrFullName'] as String?,
      ocrAddress: json['ocrAddress'] as String?,
      ocrFrontFaceDetected: json['ocrFrontFaceDetected'] as bool?,
      ocrRetryCounter: json['ocrRetryCounter'] as int?,
      idMatchingScore: (json['idMatchingScore'] as num?)?.toDouble(),
      nameMatchingScore: (json['nameMatchingScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SSEkycOcrVOToJson(SSEkycOcrVO instance) =>
    <String, dynamic>{
      'ocrIdentificationNoFront': instance.ocrIdentificationNoFront,
      'ocrFullName': instance.ocrFullName,
      'ocrAddress': instance.ocrAddress,
      'ocrFrontFaceDetected': instance.ocrFrontFaceDetected,
      'ocrRetryCounter': instance.ocrRetryCounter,
      'idMatchingScore': instance.idMatchingScore,
      'nameMatchingScore': instance.nameMatchingScore,
    };

SSAnalyticVO _$SSAnalyticVOFromJson(Map<String, dynamic> json) => SSAnalyticVO(
      loadingTimeStamp: (json['loadingTimeStamp'] as num?)?.toDouble(),
      fireToServerTimeStamp:
          (json['fireToServerTimeStamp'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SSAnalyticVOToJson(SSAnalyticVO instance) =>
    <String, dynamic>{
      'loadingTimeStamp': instance.loadingTimeStamp,
      'fireToServerTimeStamp': instance.fireToServerTimeStamp,
    };
