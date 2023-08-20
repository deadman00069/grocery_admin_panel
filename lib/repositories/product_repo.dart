import 'dart:convert';
import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/models/product_model.dart';

Future<List<ProductModel>> getAllProductRepo() async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'get-all-product');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<ProductModel> products = [];
    for (Map data in json.decode(response.body)['data']['data']) {
      products.add(ProductModel.fromJson(data));
    }
    return products;
  } else {
    return [];
  }
}

Future<List<ProductVariantModel>> getProductVariantRepo(
    String productId) async {
  Uri url = Uri.parse(
      AppConfig.BASE_API_URL + 'get-product-variants?product_id=$productId');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<ProductVariantModel> variants = [];
    for (Map data in json.decode(response.body)['data']) {
      variants.add(ProductVariantModel.fromJson(data));
    }
    return variants;
  }
  return [];
}

Future<bool> addProductRepo(
    {required String catId,
    required String name,
    required String desc,
    required XFile image,
    required String token}) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'create-product');

  var request = http.MultipartRequest(
    'POST',
    url,
  );
  request.headers.addAll({
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  Uint8List data = await image.readAsBytes();
  List<int> list = data.cast();
  request.files
      .add(http.MultipartFile.fromBytes('image', list, filename: image.name));
  request.fields['cat_id'] = catId;
  request.fields['name'] = name;
  request.fields['description'] = desc;
  http.Response response = await http.Response.fromStream(await request.send());
  if (response.statusCode == 201 &&
      json.decode(response.body)['status'] == true) {
    Fluttertoast.showToast(msg: json.decode(response.body)['message']);
    return true;
  }
  Fluttertoast.showToast(msg: json.decode(response.body)['message']);
  return false;
}

Future<bool> deleteProductRepo(String productId, String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'delete-product');
  var response = await http.post(url, body: {
    'product_id': productId,
  }, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> addProductVariantRepo(
    ProductVariantModel variant, String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'create-product-variant');
  var response = await http.post(url, body: {
    'product_id': variant.productId.toString(),
    'variant_name': variant.variantName,
    'unit_price': variant.unitPrice,
    'discount_price': variant.discountPrice,
  }, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 201) {
    return true;
  }
  return false;
}

Future<bool> deleteProductVariant(String variantId, String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'delete-product-variant');
  var response = await http.post(url, body: {
    'variant_id': variantId,
  }, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
