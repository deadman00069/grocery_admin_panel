import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:my_grocery_admin/models/coupon_model.dart';
import 'package:my_grocery_admin/repositories/coupon_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponScreenController extends ChangeNotifier {
  bool loading = false;
  List<CouponModel> coupons = [];
  late SharedPreferences preferences;
  bool isWeb = false;
  bool isMobile = false;

  void init() {
    checkPlatform();
    getCoupons();
  }

  void checkPlatform() {
    if (kIsWeb) {
      isWeb = true;
    } else if (Platform.isAndroid) {
      isMobile = true;
    }
  }

  Future<void> getCoupons() async {
    loading = true;
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    coupons = await getCouponsRepo(token!);
    loading = false;
    notifyListeners();
  }

  Future<void> deleteCoupon(String couponId) async {
    loading = true;
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    await deleteCouponRepo(couponId, token!);
    notifyListeners();
  }
}
