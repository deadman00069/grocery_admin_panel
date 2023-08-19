import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_grocery_admin/models/product_model.dart';
import 'package:my_grocery_admin/repositories/product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductVariantScreenController extends ChangeNotifier {
  bool isLoading = false;
  TextEditingController variantNameTED = TextEditingController();
  TextEditingController unitPriceTED = TextEditingController();
  TextEditingController discountPriceTED = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late SharedPreferences preferences;
  bool isWeb = false;
  bool isMobile = false;

  AddProductVariantScreenController(){
    init();
  }
  init() {
    if (kIsWeb) {
      isWeb = true;
      notifyListeners();
    } else {
      isMobile = true;
      notifyListeners();
    }
  }

  String? validateVariantName(String? v) {
    if (v!.isEmpty) return 'This field is required';
    return null;
  }

  String? validateUnitPrice(String? v) {
    if (v!.isEmpty) return 'This field is required';
    return null;
  }

  String? validateDiscount(String? v) {
    if (v!.isEmpty) return 'This field is required';
    return null;
  }

  void saveName(String? v) {
    variantNameTED.text = v!;
  }

  void saveUnitPrice(String? v) {
    unitPriceTED.text = v!;
  }

  void saveDiscount(String? v) {
    discountPriceTED.text = v!;
  }

  void addVariant(int productId) async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      ProductVariantModel variant = ProductVariantModel();
      variant.productId = productId;
      variant.variantName = variantNameTED.text;
      variant.unitPrice = unitPriceTED.text;
      variant.discountPrice = discountPriceTED.text;
      bool response = await addProductVariantRepo(
        variant,
        token!,
      );
      if (response) {
        Fluttertoast.showToast(msg: 'Variant add success');
        variantNameTED.clear();
        unitPriceTED.clear();
        discountPriceTED.clear();
      } else {
        Fluttertoast.showToast(msg: 'Variant add fails');
      }
    }
  }
}
