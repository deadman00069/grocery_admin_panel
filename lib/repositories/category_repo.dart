import 'dart:convert';
import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/models/category_model.dart';

Future<List<CategoryModel>> getAllCategoryRepo() async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'get-all-category');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<CategoryModel> categories = [];
    for (Map data in json.decode(response.body)['data']) {
      categories.add(CategoryModel.fromJson(data));
    }
    return categories;
  }
  return [];
}

Future<void> getProductFromCategory() async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'get-product-from-category');

  var response = await http.get(url);
  if (response.statusCode == 200) {}
}

Future<bool> addCategoryRepo({
  required CategoryModel category,
  required XFile image,
  required String token,
}) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'create-category');
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
  request.files.add(
    http.MultipartFile.fromBytes('image', list, filename: image.name),
  );
  request.fields['color'] = category.color!;
  request.fields['name'] = category.name!;
  request.fields['description'] = category.description!;
  http.Response response = await http.Response.fromStream(await request.send());
  if (response.statusCode == 201 &&
      json.decode(response.body)['status'] == true) {
    Fluttertoast.showToast(msg: json.decode(response.body)['message']);
    return true;
  }
  Fluttertoast.showToast(msg: json.decode(response.body)['message']);
  return false;
}

Future<bool> deleteCategoryRepo(String categoryId, String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'delete-category');
  var response = await http.post(url, body: {
    'category_id': categoryId,
  }, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
