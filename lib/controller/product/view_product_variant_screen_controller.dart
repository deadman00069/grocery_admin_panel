import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_grocery_admin/models/product_model.dart';
import 'package:my_grocery_admin/repositories/product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProductVariantScreenController extends ChangeNotifier {
  bool isLoading = false;
  List<ProductVariantModel> variants = [];
  late SharedPreferences preferences;
  bool isWeb = false;
  bool isMobile = false;

  init() {
    if (kIsWeb) {
      isWeb = true;
    } else {
      isMobile = true;
    }
  }

  void getVariants(String productId) async {
    isLoading = true;
    variants = await getProductVariantRepo(productId);
    isLoading = false;
    notifyListeners();
  }

  void deleteVariant(String variantId, String productId) async {
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    var response = await deleteProductVariant(
      variantId,
      token!,
    );
    if (response) {
      Fluttertoast.showToast(msg: 'Delete success');
      getVariants(productId);
    } else {
      Fluttertoast.showToast(msg: 'Delete Fails');
    }
  }
}
