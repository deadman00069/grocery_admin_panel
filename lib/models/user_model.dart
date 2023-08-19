class UserModel {
  UserModel({
      this.id, 
      this.userTypeId, 
      this.name, 
      this.email, 
      this.phoneNo, 
      this.dob, 
      this.avatarUrl, 
      this.fcmToken, 
      this.createdAt, 
      this.updatedAt,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    userTypeId = json['user_type_id'];
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
  int? userTypeId;
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
    map['user_type_id'] = userTypeId;
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