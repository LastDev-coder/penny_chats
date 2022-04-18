// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.status,
    this.response,
  });

  bool? status;
  List<Response>? response;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        status: json["status"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.nid,
    this.n_for,
    this.notification,
    this.c_date,

  });

  String? nid;
  String? n_for;
  String? notification;

  String? c_date;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    nid: json["nid"],
    n_for: json["n_for"],
    notification: json["notification"],
    c_date: json["c_date"],

      );

  Map<String, dynamic> toJson() => {
        "nid": nid,
        "n_for": n_for,
        "notification": notification,
        "c_date": c_date,

      };
}
