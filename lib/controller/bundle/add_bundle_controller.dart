import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_grocery_admin/models/BundleModel.dart';
import 'package:my_grocery_admin/repositories/bundle_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBundleScreenController extends ChangeNotifier {
  bool isLoading = false;
  final picker = ImagePicker();
  TextEditingController unitPriceTED = TextEditingController();
  TextEditingController discountTED = TextEditingController();
  TextEditingController nameTED = TextEditingController();
  TextEditingController descriptionTED = TextEditingController();
  XFile? image;
  GlobalKey<FormState> key = GlobalKey<FormState>();
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

  void pickImage() async {
    image = await (picker.pickImage(source: ImageSource.gallery));
    notifyListeners();
  }

  String? validateFields(String? v) {
    if (v!.isEmpty) return 'This field is required';
    return null;
  }

  void saveUnitPrice(String? v) {
    unitPriceTED.text = v!;
  }

  void saveDiscount(String? v) {
    discountTED.text = v!;
  }

  void saveName(String? v) {
    nameTED.text = v!;
  }

  void saveDescription(String? v) {
    descriptionTED.text = v!;
  }

  void addBundle() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      var bundle = BundleModel();
      bundle.name = nameTED.text;
      bundle.description = descriptionTED.text;
      bundle.unitPrice = unitPriceTED.text;
      bundle.discountPrice = discountTED.text;
      var response = await addBundleRepo(
          image: image!, token: token!, bundleModel: bundle);
      if (response) {
        unitPriceTED.clear();
        discountTED.clear();
        nameTED.clear();
        descriptionTED.clear();
        image = null;
        notifyListeners();
      }
    }
  }
}
