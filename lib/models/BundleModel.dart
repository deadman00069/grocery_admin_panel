class BundleModel {
  BundleModel({
      this.id, 
      this.name, 
      this.image, 
      this.description, 
      this.unitPrice, 
      this.discountPrice, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  BundleModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    unitPrice = json['unit_price'];
    discountPrice = json['discount_price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? image;
  String? description;
  String? unitPrice;
  String? discountPrice;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['description'] = description;
    map['unit_price'] = unitPrice;
    map['discount_price'] = discountPrice;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}