class OnlineUsers {
  bool? status;
  List<UserList>? response;

  OnlineUsers({this.status, this.response});

  OnlineUsers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response!.add(new UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
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
  String? created;
  String? modified;
  String? isActive;
  String? emailVerifyCode;
  String? isOnline;
  String? isLogin;

  UserList(
      {this.id,
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
        this.isLogin});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerified = json['email_verified'];
    username = json['username'];
    password = json['password'];
    profilePic = json['profile_pic'];
    contact = json['contact'];
    paypalId = json['paypal_id'];
    isPaid = json['is_paid'];
    referralLink = json['referral_link'];
    referrerId = json['referrer_id'];
    created = json['created'];
    modified = json['modified'];
    isActive = json['is_active'];
    emailVerifyCode = json['email_verify_code'];
    isOnline = json['is_online'];
    isLogin = json['is_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['username'] = this.username;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['contact'] = this.contact;
    data['paypal_id'] = this.paypalId;
    data['is_paid'] = this.isPaid;
    data['referral_link'] = this.referralLink;
    data['referrer_id'] = this.referrerId;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['is_active'] = this.isActive;
    data['email_verify_code'] = this.emailVerifyCode;
    data['is_online'] = this.isOnline;
    data['is_login'] = this.isLogin;
    return data;
  }
}
