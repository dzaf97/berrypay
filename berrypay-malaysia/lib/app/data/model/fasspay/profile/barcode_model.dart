import 'package:json_annotation/json_annotation.dart';

part 'barcode_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SSBarcodeModelVO {
  SSBarcodeModelVO({
    this.hasPassportInfoError,
    this.isRefreshAll,
    this.userProfile,
  });
  bool? hasPassportInfoError;
  bool? isRefreshAll;
  UserProfile? userProfile;

  factory SSBarcodeModelVO.fromJson(Map<String, dynamic> json) =>
      _$SSBarcodeModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSBarcodeModelVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserProfile {
  UserProfile({
    this.isChecked,
    this.prepaidStatus,
    this.profileSettings,
  });

  bool? isChecked;
  bool? prepaidStatus;
  ProfileSettings? profileSettings;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileSettings {
  ProfileSettings({
    this.isAgentTopUpEnable,
    this.isP2PEnable,
    this.isTopUpEnable,
    this.profileBarcodeData,
    this.walletAccountType,
    this.walletId,
  });

  bool? isAgentTopUpEnable;
  bool? isP2PEnable;
  bool? isTopUpEnable;
  String? profileBarcodeData;
  int? walletAccountType;
  String? walletId;

  factory ProfileSettings.fromJson(Map<String, dynamic> json) =>
      _$ProfileSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileSettingsToJson(this);
}
