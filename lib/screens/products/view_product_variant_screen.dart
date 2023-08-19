import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/controller/product/view_product_variant_screen_controller.dart';
import 'package:my_grocery_admin/screens/products/add_variant_screen.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ViewProductVariantScreen extends StatefulWidget {
  static const id = 'ViewProductVariantScreen';

  final String productId;

  const ViewProductVariantScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ViewProductVariantScreen> createState() =>
      _ViewProductVariantScreenState();
}

class _ViewProductVariantScreenState extends State<ViewProductVariantScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ViewProductVariantScreenController>(context, listen: false)
        .init();
    Provider.of<ViewProductVariantScreenController>(context, listen: false)
        .getVariants(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    var navController = Provider.of<NavController>(context);
    var controller = Provider.of<ViewProductVariantScreenController>(context);
    return Container(
      color: Colors.white,
      child: controller.isLoading
          ? const Center(
              child: Text('Loading'),
            )
          : controller.isWeb
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomHeader(
                          heading: 'Dashboard / Products /Product Variant',
                          subHeading: 'Product Variants',
                          showBackButton: true,
                          showAddButton: true,
                          addButtonFunction: () => navController
                              .navigatorKey.currentState!
                              .push(
                                PageTransition(
                                    key: navController.navigatorKey,
                                    child: AddProductVariantScreen(
                                      productId: int.parse(widget.productId),
                                    ),
                                    type: PageTransitionType.bottomToTop),
                              )
                              .then(
                                (value) =>
                                    controller.getVariants(widget.productId),
                              ),
                          addButtonName: 'Add Variant',
                        ),
                        controller.variants.isEmpty
                            ? const SizedBox(
                                height: 400,
                                child: Center(
                                  child: Text('No Varient to show'),
                                ),
                              )
                            : DataTable2(
                                columnSpacing: 100,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                border: TableBorder.all(
                                    color: Colors.black54, width: .5),
                                horizontalMargin: 12,
                                minWidth: 800,
                                columns: [
                                  DataColumn2(
                                    label: Center(
                                      child: Text(
                                        'Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Center(
                                      child: Text(
                                        'Unit Price',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Center(
                                      child: Text(
                                        'Discount Price',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Center(
                                      child: Text(
                                        'In Stock',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  controller.variants.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Center(
                                          child: Text(
                                            controller
                                                .variants[index].variantName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            controller
                                                .variants[index].unitPrice!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            controller
                                                .variants[index].discountPrice!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        controller.variants[index].inStock! == 1
                                            ? Center(
                                                child: Text(
                                                  'Yes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  'No',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: PopupMenuButton(
                                            onSelected: (v) {
                                              switch (v) {
                                                case 1:
                                                  controller.deleteVariant(
                                                    controller
                                                        .variants[index].id
                                                        .toString(),
                                                    widget.productId,
                                                  );
                                                  break;
                                                default:
                                                  print('dsada');
                                              }
                                            },
                                            itemBuilder: (context) => const [
                                              PopupMenuItem(
                                                child: Text("delete"),
                                                value: 1,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: CustomHeader(
                        heading: 'Dashboard / Products /Product Variant',
                        subHeading: 'Product Variants',
                        showBackButton: true,
                        showAddButton: true,
                        addButtonFunction: () =>
                            navController.navigatorKey.currentState!
                                .push(
                                  PageTransition(
                                      key: navController.navigatorKey,
                                      child: AddProductVariantScreen(
                                        productId: int.parse(widget.productId),
                                      ),
                                      type: PageTransitionType.bottomToTop),
                                )
                                .then(
                                  (value) =>
                                      controller.getVariants(widget.productId),
                                ),
                        addButtonName: 'Add Variant',
                      ),
                    ),
                    controller.variants.isEmpty
                        ? const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 400,
                              child: Center(
                                child: Text('No varient available'),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate((_, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Name : ${controller.variants[index].variantName}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          PopupMenuButton(
                                            onSelected: (v) {
                                              switch (v) {
                                                case 1:
                                                  controller.deleteVariant(
                                                    controller
                                                        .variants[index].id
                                                        .toString(),
                                                    widget.productId,
                                                  );
                                                  break;
                                                default:
                                                  print('dsada');
                                              }
                                            },
                                            itemBuilder: (context) => const [
                                              PopupMenuItem(
                                                child: Text("delete"),
                                                value: 1,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Unit Price : ${controller.variants[index].unitPrice}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Discount Price : ${controller.variants[index].discountPrice}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      controller.variants[index].inStock! == 1
                                          ? Text(
                                              'In-Stock : Yes',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            )
                                          : Text(
                                              'In-Stock - No',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            }, childCount: controller.variants.length),
                          )
                  ],
                ),
    );
  }
}
