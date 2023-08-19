class ProductModel {
  ProductModel({
      this.id, 
      this.categoryId, 
      this.name, 
      this.description, 
      this.images, 
      this.isPopular, 
      this.createdAt, 
      this.updatedAt, 
      this.productVariants,});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    isPopular = json['is_popular'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product_variants'] != null) {
      productVariants = [];
      json['product_variants'].forEach((v) {
        productVariants?.add(ProductVariantModel.fromJson(v));
      });
    }
  }
  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? images;
  int? isPopular;
  String? createdAt;
  String? updatedAt;
  List<ProductVariantModel>? productVariants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['description'] = description;
    map['images'] = images;
    map['is_popular'] = isPopular;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (productVariants != null) {
      map['product_variants'] = productVariants?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProductVariantModel {
  ProductVariantModel({
      this.id, 
      this.productId, 
      this.variantName, 
      this.unitPrice, 
      this.discountPrice, 
      this.inStock, 
      this.createdAt, 
      this.updatedAt,});

  ProductVariantModel.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    variantName = json['variant_name'];
    unitPrice = json['unit_price'];
    discountPrice = json['discount_price'];
    inStock = json['in_stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? productId;
  String? variantName;
  String? unitPrice;
  String? discountPrice;
  int? inStock;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['variant_name'] = variantName;
    map['unit_price'] = unitPrice;
    map['discount_price'] = discountPrice;
    map['in_stock'] = inStock;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}