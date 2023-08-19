import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/models/coupon_model.dart';

Future<List<CouponModel>> getCouponsRepo(String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'get-all-coupons');
  var response = await http.post(url, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    List<CouponModel> coupons = [];
    for (Map data in json.decode(response.body)['data']) {
      coupons.add(CouponModel.fromJson(data));
    }
    return coupons;
  }
  return [];
}

Future<bool> addCouponRepo(CouponModel coupon, String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'create-coupon');
  try {
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': coupon.name,
      'code': coupon.code,
      'description': coupon.description,
      'valid_upto': coupon.validUpto,
      'value': coupon.value,
      'type': coupon.type,
    });
    if (response.statusCode == 201 &&
        json.decode(response.body)['status'] == true) {
      Fluttertoast.showToast(msg: json.decode(response.body)['message']);
      return true;
    }
    Fluttertoast.showToast(msg: json.decode(response.body)['message']);
    return false;
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    return false;
  }
}

Future<bool> updateCouponRepo(CouponModel coupon, String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'update-coupon');
  try {
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'coupon_id': coupon.id.toString(),
      'name': coupon.name,
      'code': coupon.code,
      'description': coupon.description,
      'valid_upto': coupon.validUpto,
      'type': coupon.type.toString(),
      'is_active': coupon.isActive.toString(),
    });
    if (response.statusCode == 200 &&
        json.decode(response.body)['status'] == true) {
      Fluttertoast.showToast(msg: json.decode(response.body)['message']);
      return true;
    }
    Fluttertoast.showToast(msg: json.decode(response.body)['message']);
    return false;
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    return false;
  }
}

Future<bool> deleteCouponRepo(String couponId, String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'delete-coupon');
  try {
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'coupon_id': couponId,
    });
    if (response.statusCode == 200 &&
        json.decode(response.body)['status'] == true) {
      Fluttertoast.showToast(msg: json.decode(response.body)['message']);
      return true;
    }
    Fluttertoast.showToast(msg: json.decode(response.body)['message']);
    return false;
  } catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
    );
    return false;
  }
}
