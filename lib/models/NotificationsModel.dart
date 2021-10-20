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
    this.id,
    this.topic,
    this.content,
    this.created,
    this.modified,
    this.isActive,
  });

  String? id;
  String? topic;
  String? content;
  DateTime? created;
  DateTime? modified;
  String? isActive;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        topic: json["topic"],
        content: json["content"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "content": content,
        "created": created!.toIso8601String(),
        "modified": modified!.toIso8601String(),
        "is_active": isActive,
      };
}
