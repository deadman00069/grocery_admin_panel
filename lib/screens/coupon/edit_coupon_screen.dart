import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/coupon/edit_coupon_screen_controller.dart';
import 'package:my_grocery_admin/models/coupon_model.dart';
import 'package:my_grocery_admin/screens/responsiveness.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class EditCouponScreen extends StatefulWidget {
  final CouponModel coupon;

  const EditCouponScreen({Key? key, required this.coupon}) : super(key: key);

  @override
  State<EditCouponScreen> createState() => _EditCouponScreenState();
}

class _EditCouponScreenState extends State<EditCouponScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EditCouponScreenController>(context, listen: false)
        .init(widget.coupon);
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<EditCouponScreenController>(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? const EdgeInsets.all(0)
            : const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(
                heading: 'Dashboard / Coupons / Edit Coupons',
                subHeading: 'Edit Coupons',
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
                            controller: controller.codeTED,
                            validator: controller.validateFields,
                            onSaved: controller.saveCode,
                            decoration: const InputDecoration(
                              hintText: 'Code',
                              label: Text('Code'),
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
                            controller: controller.validateDateTED,
                            validator: controller.validateFields,
                            onSaved: controller.saveValidateDate,
                            decoration: const InputDecoration(
                              hintText: 'Valid Date',
                              label: Text('Date'),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownSearch<String>(
                            selectedItem: controller.typeTED.text == '1'
                                ? 'Percentage'
                                : 'Fixed',
                            validator: (_) {
                              if (controller.typeTED.text == '') {
                                return 'This field is required';
                              }
                              return null;
                            },
                            mode: Mode.MENU,
                            items: const ['Percentage', 'Fixed'],
                            label: "Type",
                            // hint: "country in menu mode",
                            onChanged: (v) {
                              if (v == 'Percentage') {
                                controller.typeTED.text = '1';
                              } else {
                                controller.typeTED.text = '2';
                              }
                            },
                            // popupItemBuilder: _customPopupItemBuilderExample2,
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
                                return const Text('Select a Type');
                              }
                              return Text(c);
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownSearch<String>(
                            selectedItem: controller.isActiveTED.text == '1'
                                ? 'Activated'
                                : 'DeActivated',
                            validator: (_) {
                              if (controller.isActiveTED.text == '') {
                                return 'This field is required';
                              }
                              return null;
                            },
                            mode: Mode.MENU,
                            items: const ['Activated', 'DeActivated'],
                            label: "Type",
                            // hint: "country in menu mode",
                            onChanged: (v) {
                              if (v == 'Activated') {
                                controller.isActiveTED.text = '1';
                              } else {
                                controller.isActiveTED.text = '2';
                              }
                            },
                            // popupItemBuilder: _customPopupItemBuilderExample2,
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
                                return const Text('Select a Type');
                              }
                              return Text(c);
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          ElevatedButton(
                            onPressed: () => controller.updateCoupon(
                              widget.coupon.id!,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Text('Update Coupon'),
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
