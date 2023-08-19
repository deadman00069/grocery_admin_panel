import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_grocery_admin/models/category_model.dart';
import 'package:my_grocery_admin/repositories/category_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCategoryScreenController extends ChangeNotifier {
  bool isLoading = false;

  final picker = ImagePicker();
  TextEditingController nameTED = TextEditingController();
  TextEditingController colorTED = TextEditingController();
  TextEditingController descriptionTED = TextEditingController();
  XFile? image;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late SharedPreferences preferences;

  void pickImage() async {
    image = await (picker.pickImage(source: ImageSource.gallery));
    notifyListeners();
  }

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

  void saveColor(String? v) {
    colorTED.text = v!;
  }

  Future<void> addCategory() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      CategoryModel category = CategoryModel();
      category.name = nameTED.text;
      category.description = descriptionTED.text;
      category.color = colorTED.text;
      var response = await addCategoryRepo(
        category: category,
        image: image!,
        token: token!,
      );
      print('tttttttttttt');
      print(response);
      if (response) {
        colorTED.clear();
        nameTED.clear();
        descriptionTED.clear();
        image = null;
        notifyListeners();
      }
    }
  }
}
