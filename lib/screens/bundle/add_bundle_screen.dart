import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/bundle/add_bundle_controller.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

import '../responsiveness.dart';

class AddBundleScreen extends StatefulWidget {
  static const id = 'add_bundle_screen';

  const AddBundleScreen({Key? key}) : super(key: key);

  @override
  State<AddBundleScreen> createState() => _AddBundleScreenState();
}

class _AddBundleScreenState extends State<AddBundleScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddBundleScreenController>(context,listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<AddBundleScreenController>(context);
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
                heading: 'Dashboard / Bundle / Add Bundle',
                subHeading: 'Add Bundle',
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
                          TextFormField(
                            controller: controller.unitPriceTED,
                            validator: controller.validateFields,
                            onSaved: controller.saveUnitPrice,
                            decoration: const InputDecoration(
                              hintText: 'Unit price',
                              label: Text('Unit Price'),
                            ),
                          ),
                          TextFormField(
                            controller: controller.discountTED,
                            validator: controller.validateFields,
                            onSaved: controller.saveDiscount,
                            decoration: const InputDecoration(
                              hintText: 'Discount ',
                              label: Text('Discount'),
                            ),
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
                            onPressed: () => controller.addBundle(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Text('Add Bundle'),
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
