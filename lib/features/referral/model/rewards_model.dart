// To parse this JSON data, do
//
//     final rewardsModel = rewardsModelFromJson(jsonString);

import 'dart:convert';

RewardsModel rewardsModelFromJson(String str) => RewardsModel.fromJson(json.decode(str));

String rewardsModelToJson(RewardsModel data) => json.encode(data.toJson());

class RewardsModel {
    final String? referralCode;
    final int? referralPoints;
    final String? referralLink;

    RewardsModel({
        this.referralCode,
        this.referralPoints,
        this.referralLink,
    });

    factory RewardsModel.fromJson(Map<String, dynamic> json) => RewardsModel(
        referralCode: json["referralCode"],
        referralPoints: json["referralPoints"],
        referralLink: json["referralLink"],
    );

    Map<String, dynamic> toJson() => {
        "referralCode": referralCode,
        "referralPoints": referralPoints,
        "referralLink": referralLink,
    };
}
