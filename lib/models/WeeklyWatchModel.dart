// To parse this JSON data, do
//
//     final weeklyWatchModel = weeklyWatchModelFromJson(jsonString);

import 'dart:convert';

WeeklyWatchModel weeklyWatchModelFromJson(String str) =>
    WeeklyWatchModel.fromJson(json.decode(str));

String weeklyWatchModelToJson(WeeklyWatchModel data) =>
    json.encode(data.toJson());

class WeeklyWatchModel {
  WeeklyWatchModel({
    this.status,
    this.response,
  });

  bool? status;
  List<Response>? response;

  factory WeeklyWatchModel.fromJson(Map<String, dynamic> json) =>
      WeeklyWatchModel(
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
    this.id,
    this.userId,
    this.stock,
    this.alert,
    this.description,
    this.status,
    this.created,
    this.modified,
  });

  String? id;
  String? userId;
  String? stock;
  DateTime? alert;
  String? description;
  String? status;
  DateTime? created;
  DateTime? modified;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        userId: json["user_id"],
        stock: json["stock"],
        alert: DateTime.parse(json["alert"]),
        description: json["description"],
        status: json["status"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "stock": stock,
        "alert":
            "${alert?.year.toString().padLeft(4, '0')}-${alert?.month.toString().padLeft(2, '0')}-${alert?.day.toString().padLeft(2, '0')}",
        "description": description,
        "status": status,
        "created":
            "${created?.year.toString().padLeft(4, '0')}-${created?.month.toString().padLeft(2, '0')}-${created?.day.toString().padLeft(2, '0')}",
        "modified":
            "${modified?.year.toString().padLeft(4, '0')}-${modified?.month.toString().padLeft(2, '0')}-${modified?.day.toString().padLeft(2, '0')}",
      };
}
