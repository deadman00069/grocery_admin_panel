import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/product/add_product_screen_controller.dart';
import 'package:my_grocery_admin/models/category_model.dart';
import 'package:my_grocery_admin/screens/responsiveness.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const id = 'AddProductScreen';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddProductScreenController>(context, listen: false).init();
    Provider.of<AddProductScreenController>(context, listen: false)
        .getCategories();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<AddProductScreenController>(context);
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveWidget.isSmallScreen(context)
              ? const EdgeInsets.all(0)
              : const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomHeader(
                heading: 'Dashboard / Products / Add Product',
                subHeading: 'Add Product',
                showBackButton: true,
                showAddButton: false,
              ),
              SizedBox(
                width: ResponsiveWidget.isSmallScreen(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2,
                child: Card(
                  elevation: 10,
                  child: Form(
                    key: controller.key,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Basic information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            controller: controller.nameTED,
                            validator: controller.validateFields,
                            onSaved: controller.saveName,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              label: Text('Name'),
                            ),
                          ),
                          TextFormField(
                            controller: controller.descriptionTED,
                            validator: controller.validateFields,
                            onSaved: controller.saveDescription,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                              label: Text('Description'),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownSearch<CategoryModel>(
                            validator: (_) {
                              if (controller.catIdTED.text == '') {
                                return 'This field is required';
                              }
                              return null;
                            },
                            mode: Mode.MENU,
                            items: controller.categories,
                            label: "Category",
                            // hint: "country in menu mode",
                            onChanged: (v) =>
                                controller.catIdTED.text = v!.id.toString(),
                            popupItemBuilder: _customPopupItemBuilderExample2,
                            dropdownButtonBuilder: (_) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_downward,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                            dropdownBuilder: (_, c) {
                              if (c == null) {
                                return const Text('Select a category');
                              }
                              return Text(c.name!);
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          controller.isWeb
                              ? controller.image != null
                                  ? SizedBox(
                                      width: 250,
                                      height: 250,
                                      child: Image.network(
                                        controller.image!.path,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: 250,
                                      height: 250,
                                      color: Colors.black12,
                                    )
                              : controller.image != null
                                  ? SizedBox(
                                      width: 250,
                                      height: 250,
                                      child: Image.file(
                                        File(controller.image!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: 250,
                                      height: 250,
                                      color: Colors.black12,
                                    ),
                          const SizedBox(
                            height: 16,
                          ),
                          controller.image != null
                              ? ElevatedButton(
                                  onPressed: () {
                                    controller.pickImage();
                                  },
                                  child: const Text('Upload another image'),
                                )
                              : ElevatedButton(
                                  onPressed: () => controller.pickImage(),
                                  child: const Text('Upload product image'),
                                ),
                          const SizedBox(
                            height: 32,
                          ),
                          ElevatedButton(
                            onPressed: () => controller.addProduct(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Text('Add Product'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _customPopupItemBuilderExample2(
    BuildContext context, CategoryModel? item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.name ?? ''),
      subtitle: Text(item?.description?.toString() ?? ''),
      // leading: CircleAvatar(
      //
      //     ),
    ),
  );
}
