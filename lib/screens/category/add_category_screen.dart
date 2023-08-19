import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/category/add_category_screen.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/screens/responsiveness.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatelessWidget {
  static const id = 'AddCategoryScreen';

  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<AddCategoryScreenController>(context);
    var navController = Provider.of<NavController>(context);
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveWidget.isSmallScreen(context)
              ? const EdgeInsets.all(16.0)
              : const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomHeader(
                heading: 'Dashboard / Categories / Add Category',
                subHeading: 'Add Categories',
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
                          TextFormField(
                            controller: controller.colorTED,
                            validator: controller.validateFields,
                            onSaved: controller.saveColor,
                            decoration: const InputDecoration(
                              hintText: 'Color',
                              label: Text('Color'),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          controller.image != null
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
                                ),
                          const SizedBox(
                            height: 16,
                          ),
                          controller.image != null
                              ? ElevatedButton(
                                  onPressed: () => controller.pickImage(),
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
                            onPressed: () => controller.addCategory(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Text('Add Category'),
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
