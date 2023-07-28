// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSBarcodeModelVO _$SSBarcodeModelVOFromJson(Map<String, dynamic> json) =>
    SSBarcodeModelVO(
      hasPassportInfoError: json['hasPassportInfoError'] as bool?,
      isRefreshAll: json['isRefreshAll'] as bool?,
      userProfile: json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SSBarcodeModelVOToJson(SSBarcodeModelVO instance) =>
    <String, dynamic>{
      'hasPassportInfoError': instance.hasPassportInfoError,
      'isRefreshAll': instance.isRefreshAll,
      'userProfile': instance.userProfile?.toJson(),
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      isChecked: json['isChecked'] as bool?,
      prepaidStatus: json['prepaidStatus'] as bool?,
      profileSettings: json['profileSettings'] == null
          ? null
          : ProfileSettings.fromJson(
              json['profileSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'isChecked': instance.isChecked,
      'prepaidStatus': instance.prepaidStatus,
      'profileSettings': instance.profileSettings?.toJson(),
    };

ProfileSettings _$ProfileSettingsFromJson(Map<String, dynamic> json) =>
    ProfileSettings(
      isAgentTopUpEnable: json['isAgentTopUpEnable'] as bool?,
      isP2PEnable: json['isP2PEnable'] as bool?,
      isTopUpEnable: json['isTopUpEnable'] as bool?,
      profileBarcodeData: json['profileBarcodeData'] as String?,
      walletAccountType: json['walletAccountType'] as int?,
      walletId: json['walletId'] as String?,
    );

Map<String, dynamic> _$ProfileSettingsToJson(ProfileSettings instance) =>
    <String, dynamic>{
      'isAgentTopUpEnable': instance.isAgentTopUpEnable,
      'isP2PEnable': instance.isP2PEnable,
      'isTopUpEnable': instance.isTopUpEnable,
      'profileBarcodeData': instance.profileBarcodeData,
      'walletAccountType': instance.walletAccountType,
      'walletId': instance.walletId,
    };
