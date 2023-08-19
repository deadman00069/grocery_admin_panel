import 'dart:convert';
import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/models/BundleModel.dart';

Future<List<BundleModel>> getBundlesRepo() async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + "get-all-bundles");
  var response = await http.post(url);
  if (response.statusCode == 200) {
    List<BundleModel> bundles = [];
    for (Map data in json.decode(response.body)['data']) {
      bundles.add(BundleModel.fromJson(data));
    }
    return bundles;
  }
  return [];
}

Future<bool> addBundleRepo(
    {required XFile image,
    required String token,
    required BundleModel bundleModel}) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + "create-bundle");
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
  request.fields['unit_price'] = bundleModel.unitPrice!;
  request.fields['discount_price'] = bundleModel.discountPrice!;
  request.fields['name'] = bundleModel.name!;
  request.fields['description'] = bundleModel.description!;
  http.Response response = await http.Response.fromStream(await request.send());
  if (response.statusCode == 201 &&
      json.decode(response.body)['status'] == true) {
    Fluttertoast.showToast(msg: json.decode(response.body)['message']);
    return true;
  }
  Fluttertoast.showToast(msg: json.decode(response.body)['message']);
  return false;
}

Future<bool> addProductToBundleRepo(
    {required int bundleId,
    required int variantId,
    required String token}) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + "add-product-to-bundle");
  var response = await http.post(url, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  }, body: {
    'product_variant_id': variantId.toString(),
    'bundle_id': bundleId.toString()
  });
  if (response.statusCode == 201) {
    return true;
  }
  return false;
}
