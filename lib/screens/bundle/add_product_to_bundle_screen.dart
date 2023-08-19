import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/bundle/add_product_to_bundle_controller.dart';
import 'package:my_grocery_admin/models/BundleModel.dart';
import 'package:my_grocery_admin/models/product_model.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

import '../responsiveness.dart';

class AddProductToBundleScreen extends StatefulWidget {
  static const id = 'add_product_to_bundle_screen';
  final BundleModel? bundle;

  const AddProductToBundleScreen({
    Key? key,
    this.bundle,
  }) : super(key: key);

  @override
  State<AddProductToBundleScreen> createState() =>
      _AddProductToBundleScreenState();
}

class _AddProductToBundleScreenState extends State<AddProductToBundleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddProductToBundleScreenController>(context, listen: false)
        .init();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Looolll");
    debugPrint("${widget.bundle!.id}");
    var controller = Provider.of<AddProductToBundleScreenController>(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? const EdgeInsets.all(0)
            : const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(
                heading: 'Dashboard / Bundle / Add Product to Bundle',
                subHeading: ' Add Product to Bundle',
                showAddButton: false,
                showBackButton: true,
                addButtonFunction: () {},
              ),
              SizedBox(
                width: ResponsiveWidget.isSmallScreen(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2,
                child: Card(
                  elevation: 10,
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
                          height: 16,
                        ),
                        DropdownSearch<ProductModel>(
                          validator: (_) {
                            if (controller.selectedProduct == null) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          mode: Mode.MENU,
                          items: controller.listOfProducts,
                          label: "Category",
                          // hint: "country in menu mode",
                          onChanged: (v) => controller.onProductSelected(v!),
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
                          height: 18,
                        ),
                        controller.selectedProduct == null
                            ? const SizedBox()
                            : DropdownSearch<ProductVariantModel>(
                                validator: (_) {
                                  if (controller.selectedVariantId == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                mode: Mode.MENU,
                                items:
                                    controller.selectedProduct!.productVariants,
                                label: "Category",
                                // hint: "country in menu mode",
                                onChanged: (v) =>
                                    controller.selectedVariantId = v!.id,
                                popupItemBuilder:
                                    _customPopupItemBuilderExample3,
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
                                  return Text(c.variantName!);
                                },
                              ),
                        const SizedBox(
                          height: 24,
                        ),
                        if (controller.selectedProduct != null)
                          ElevatedButton(
                            onPressed: () {
                              controller.addProductToBundle(widget.bundle!.id!);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Text('Add Bundle'),
                            ),
                          ),
                      ],
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
    BuildContext context, ProductModel? item, bool isSelected) {
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

Widget _customPopupItemBuilderExample3(
    BuildContext context, ProductVariantModel? item, bool isSelected) {
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
      title: Text(item?.variantName ?? ''),
      subtitle: Text('Unit Price : ${item?.unitPrice?.toString()}'),
      // leading: CircleAvatar(
      //
      //     ),
    ),
  );
}
