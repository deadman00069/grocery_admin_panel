import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/product/add_product_variant_screen_controller.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class AddProductVariantScreen extends StatelessWidget {
  static const id = 'AddProductVariantScreen';
  final int productId;

  const AddProductVariantScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<AddProductVariantScreenController>(context);
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: controller.isWeb
              ? const EdgeInsets.all(16)
              : const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(
                heading:
                    'Dashboard / Products / Product Variants / Add Variant',
                subHeading: 'Add Variant',
                showBackButton: true,
                showAddButton: false,
              ),
              Center(
                child: SizedBox(
                  width: controller.isWeb
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: controller.key,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Add Product Variant',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            TextFormField(
                              controller: controller.variantNameTED,
                              validator: controller.validateVariantName,
                              onSaved: controller.saveName,
                              decoration: const InputDecoration(
                                hintText: 'abe',
                                label: Text('Variant Name'),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: controller.unitPriceTED,
                              validator: controller.validateUnitPrice,
                              onSaved: controller.saveUnitPrice,
                              decoration: const InputDecoration(
                                hintText: '23.00',
                                label: Text('Unit Price'),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: controller.discountPriceTED,
                              validator: controller.validateDiscount,
                              onSaved: controller.saveDiscount,
                              decoration: const InputDecoration(
                                hintText: '23.00',
                                label: Text('Discount Price'),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            ElevatedButton(
                              child: const Text('Add Variant'),
                              onPressed: () => controller.addVariant(productId),
                            )
                          ],
                        ),
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
