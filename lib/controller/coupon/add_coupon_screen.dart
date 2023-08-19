import 'package:flutter/material.dart';
import 'package:my_grocery_admin/models/coupon_model.dart';
import 'package:my_grocery_admin/repositories/coupon_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCouponScreenController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameTED = TextEditingController();
  TextEditingController codeTED = TextEditingController();
  TextEditingController descriptionTED = TextEditingController();
  TextEditingController validateDateTED = TextEditingController();
  TextEditingController typeTED = TextEditingController();
  late SharedPreferences preferences;

  String? validateFields(String? v) {
    if (v!.isEmpty) return 'This field is required';
    return null;
  }

  void saveName(String? v) {
    nameTED.text = v!;
  }

  void saveDescription(String? v) {
    descriptionTED.text = v!;
  }

  void saveCode(String? v) {
    codeTED.text = v!;
  }

  void saveValidateDate(String? v) {
    validateDateTED.text = v!;
  }

  void saveType(String? v) {
    typeTED.text = v!;
  }

  void addCoupon() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      loading = true;
      preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      CouponModel coupon = CouponModel();
      coupon.name = nameTED.text;
      coupon.code = codeTED.text;
      coupon.description = descriptionTED.text;
      coupon.validUpto = validateDateTED.text;
      coupon.type = typeTED.text;
      coupon.value = 'sdff';
      var response = await addCouponRepo(
        coupon,
        token!,
      );
      if (response) {
        loading = false;
        nameTED.clear();
        codeTED.clear();
        descriptionTED.clear();
        validateDateTED.clear();
        typeTED.clear();
        notifyListeners();
      } else {}
    }
  }
}
