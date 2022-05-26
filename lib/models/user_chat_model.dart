
class UserChatModel {
  bool? status;
  List<Messages>? messages;

  UserChatModel({this.status, this.messages});

  UserChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['response'] != null) {
      messages = [];
      json['response'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? iD;
  String? user;
  String? time;
  String? message;
  String? pic;
  String?  uid;
  String? isReport ;

  Messages({this.iD, this.user, this.time, this.message, this.pic,  this.isReport});

  Messages.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    user = json['User'];
    time = json['time'];
    message = json['Message'];
    pic = json['pic'];
    uid = json['uid'];
    isReport = json['report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['User'] = this.user;
    data['time'] = this.time;
    data['Message'] = this.message;
    data['pic'] = this.pic;
    data['uid'] = this.uid;
    data['report'] = this.isReport;

    return data;
  }
}
