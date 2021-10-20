// To parse this JSON data, do
//
//     final postUserDataModel = postUserDataModelFromJson(jsonString);

import 'dart:convert';

PostUserDataModel postUserDataModelFromJson(String str) =>
    PostUserDataModel.fromJson(json.decode(str));

String postUserDataModelToJson(PostUserDataModel data) =>
    json.encode(data.toJson());

class PostUserDataModel {
  PostUserDataModel({
    this.status,
    this.response,
  });

  bool? status;
  Response? response;

  factory PostUserDataModel.fromJson(Map<String, dynamic> json) =>
      PostUserDataModel(
        status: json["status"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response!.toJson(),
      };
}

class Response {
  Response({
    this.id,
    this.name,
    this.email,
    this.emailVerified,
    this.username,
    this.password,
    this.profilePic,
    this.contact,
    this.paypalId,
    this.isPaid,
    this.referralLink,
    this.referrerId,
    this.created,
    this.modified,
    this.isActive,
    this.emailVerifyCode,
    this.isOnline,
    this.isLogin,
  });

  String? id;
  String? name;
  String? email;
  String? emailVerified;
  String? username;
  String? password;
  String? profilePic;
  String? contact;
  String? paypalId;
  String? isPaid;
  String? referralLink;
  String? referrerId;
  DateTime? created;
  DateTime? modified;
  String? isActive;
  String? emailVerifyCode;
  String? isOnline;
  String? isLogin;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerified: json["email_verified"],
        username: json["username"],
        password: json["password"],
        profilePic: json["profile_pic"],
        contact: json["contact"],
        paypalId: json["paypal_id"],
        isPaid: json["is_paid"],
        referralLink: json["referral_link"],
        referrerId: json["referrer_id"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        isActive: json["is_active"],
        emailVerifyCode: json["email_verify_code"],
        isOnline: json["is_online"],
        isLogin: json["is_login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified": emailVerified,
        "username": username,
        "password": password,
        "profile_pic": profilePic,
        "contact": contact,
        "paypal_id": paypalId,
        "is_paid": isPaid,
        "referral_link": referralLink,
        "referrer_id": referrerId,
        "created": created!.toIso8601String(),
        "modified": modified!.toIso8601String(),
        "is_active": isActive,
        "email_verify_code": emailVerifyCode,
        "is_online": isOnline,
        "is_login": isLogin,
      };
}
