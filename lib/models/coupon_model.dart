class CouponModel {
  CouponModel({
      this.id, 
      this.name, 
      this.code, 
      this.description, 
      this.validUpto, 
      this.type, 
      this.isActive, 
      this.value,
      this.createdAt,
      this.updatedAt,});

  CouponModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    validUpto = json['valid_upto'];
    type = json['type'];
    isActive = json['is_active'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? code;
  String? description;
  String? validUpto;
  String? type;
  int? isActive;
  String? value;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['description'] = description;
    map['valid_upto'] = validUpto;
    map['type'] = type;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}