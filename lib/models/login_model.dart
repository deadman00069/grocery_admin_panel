class LoginModel {
  LoginModel({
      this.status, 
      this.user, 
      this.token,});

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
  bool? status;
  User? user;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.phoneNo, 
      this.dob, 
      this.avatarUrl, 
      this.fcmToken, 
      this.createdAt, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    dob = json['dob'];
    avatarUrl = json['avatar_url'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? email;
  String? phoneNo;
  String? dob;
  String? avatarUrl;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['dob'] = dob;
    map['avatar_url'] = avatarUrl;
    map['fcm_token'] = fcmToken;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}