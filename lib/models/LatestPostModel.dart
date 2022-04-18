// To parse this JSON data, do
//
//     final latestPostModel = latestPostModelFromJson(jsonString);

import 'dart:convert';

LatestPostModel latestPostModelFromJson(String str) =>
    LatestPostModel.fromJson(json.decode(str));

String latestPostModelToJson(LatestPostModel data) =>
    json.encode(data.toJson());

class LatestPostModel {
  LatestPostModel({
    this.status,
    this.response,
  });

  bool? status;
  List<Response>? response;

  factory LatestPostModel.fromJson(Map<String, dynamic> json) =>
      LatestPostModel(
        status: json["status"],
        response: List<Response>.from(
            json["response"].map((x){

              return Response.fromJson(x);
            })),
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
    this.title,
    this.content,
    this.comments,
    this.votes,
    this.favourites,
    this.created,
    this.modified,
    this.isActive,
    this.name,
    this.profilePic,
    this.is_liked_ornot

  });

  String? id;
  String? userId;
  String? title;
  String? content;
  String? comments;
  String? votes;
  String? favourites;
  DateTime? created;
  String? modified;
  String? isActive;
  String? name;
  String? profilePic;
  String? is_liked_ornot;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        content: json["content"],
        comments: json["pstcmntcnt"],
        votes: json["pstlikecnt"],
        favourites: json["favourites"],
        created: DateTime.parse(json["created"]),
        modified: json["modified"],
        isActive: json["is_active"],
        name: json["name"],
        profilePic: json["profile_pic"],
    is_liked_ornot: json["is_liked_ornot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "content": content,
        "comments": comments,
        "votes": votes,
        "favourites": favourites,
        "created": created?.toIso8601String(),
        "modified": modified,
        "is_active": isActive,
        "name": name,
        "profile_pic": profilePic,
        "is_liked_ornot": is_liked_ornot,
      };
}
