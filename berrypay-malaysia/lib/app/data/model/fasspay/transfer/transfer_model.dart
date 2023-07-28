import 'package:json_annotation/json_annotation.dart';
part 'transfer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Requestp2p {
  final String? walletId;
  final String? cardId;
  final List<ContactDetail>? contactDetail;

  Requestp2p({
    this.walletId,
    this.cardId,
    this.contactDetail,
  });

  factory Requestp2p.fromJson(Map<String, dynamic> json) =>
      _$Requestp2pFromJson(json);
  Map<String, dynamic> toJson() => _$Requestp2pToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContactDetail {
  final String? amount;
  final String? walletId;

  ContactDetail({this.amount, this.walletId});

  factory ContactDetail.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ContactDetailToJson(this);
}
