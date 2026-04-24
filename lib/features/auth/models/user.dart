// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

class User {
    final dynamic landlordId;
    final String? currency;
    final String? id;
    final String? name;
    final String? email;
    final String? about;
    final bool? isActive;
    final bool? isBanned;
    final String? referralCode;
    final dynamic referredBy;
    final int? referralPoints;
    final String? createdAt;
    final int? v;
    final bool? adminPrivilege;
    final String? phone;
    final String? role;

    User({
        this.landlordId,
        this.currency,
        this.id,
        this.name,
        this.email,
        this.about,
        this.isActive,
        this.isBanned,
        this.referralCode,
        this.referredBy,
        this.referralPoints,
        this.createdAt,
        this.v,
        this.adminPrivilege,
        this.phone,
        this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        landlordId: json["landlordId"],
        currency: json["currency"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        about: json["about"],
        isActive: json["isActive"],
        isBanned: json["isBanned"],
        referralCode: json["referralCode"],
        referredBy: json["referredBy"],
        referralPoints: json["referralPoints"],
        createdAt: json["createdAt"],
        v: json["__v"],
        adminPrivilege: json["adminPrivilege"],
        phone: json["phone"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "landlordId": landlordId,
        "currency": currency,
        "_id": id,
        "name": name,
        "email": email,
        "about": about,
        "isActive": isActive,
        "isBanned": isBanned,
        "referralCode": referralCode,
        "referredBy": referredBy,
        "referralPoints": referralPoints,
        "createdAt": createdAt,
        "__v": v,
        "adminPrivilege": adminPrivilege,
        "phone": phone,
        "role": role,
    };
}
