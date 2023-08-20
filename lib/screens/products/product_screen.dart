import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/controller/product/view_product_controller.dart';
import 'package:my_grocery_admin/screens/products/add_product_screen.dart';
import 'package:my_grocery_admin/screens/products/edit_product_screen.dart';
import 'package:my_grocery_admin/screens/products/view_product_variant_screen.dart';
import 'package:my_grocery_admin/screens/responsiveness.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  static const id = 'ProductScreen';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ViewProductController>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ViewProductController>(context);
    var navController = Provider.of<NavController>(context);
    return Container(
      color: Colors.white,
      child: controller.isLoading
          ? const Center(
              child: Text('Loading'),
            )
          // : controller.products.isEmpty
          //     ? Center(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             const Text('No Product to show'),
          //             const SizedBox(
          //               height: 16,
          //             ),
          //             ElevatedButton(
          //               onPressed: () {
          //                 navController
          //                     .navigateTo(routeName: AddProductScreen.id)
          //                     .then(
          //                       (value) => controller.getProducts(),
          //                     );
          //               },
          //               child: const Text('Add Product'),
          //             )
          //           ],
          //         ),
          //       )
          : Padding(
              padding: ResponsiveWidget.isSmallScreen(context)
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.symmetric(horizontal: 16),
              child: ResponsiveWidget.isSmallScreen(context)
                  ? CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: CustomHeader(
                            heading: 'Dashboard / Products',
                            subHeading: 'Products',
                            showAddButton: true,
                            showBackButton: false,
                            addButtonFunction: () => navController
                                .navigateTo(
                                  routeName: AddProductScreen.id,
                                )
                                .then(
                                  (value) => controller.getProducts(),
                                ),
                            addButtonName: 'Add Product',
                          ),
                        ),
                        controller.products.isEmpty
                            ? const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 400,
                                  child: Center(
                                    child: Text('No product found'),
                                  ),
                                ),
                              )
                            : SliverList(
                                delegate:
                                    SliverChildBuilderDelegate((_, index) {
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
                                                'Name : ${controller.products[index].name}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                              PopupMenuButton(
                                                onSelected: (v) {
                                                  switch (v) {
                                                    case 1:
                                                      {
                                                        navController
                                                            .navigatorKey
                                                            .currentState!
                                                            .push(
                                                                PageTransition(
                                                                    key: navController
                                                                        .navigatorKey,
                                                                    child:
                                                                        ViewProductVariantScreen(
                                                                      productId: controller
                                                                          .products[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                    ),
                                                                    type: PageTransitionType
                                                                        .bottomToTop));
                                                      }
                                                      break;
                                                    case 2:
                                                      navController.navigateTo(
                                                        routeName:
                                                            EditProductScreen
                                                                .id,
                                                      );
                                                      break;
                                                    case 3:
                                                      controller.deleteProduct(
                                                        controller
                                                            .products[index].id
                                                            .toString(),
                                                      );
                                                      break;
                                                    default:
                                                      print('dsada');
                                                  }
                                                },
                                                itemBuilder: (context) =>
                                                    const [
                                                  PopupMenuItem(
                                                    child: Text("view variant"),
                                                    value: 1,
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("edit"),
                                                    value: 2,
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("delete"),
                                                    value: 3,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          AspectRatio(
                                            aspectRatio: 4 / 3,
                                            child: Image.network(
                                              AppConfig.BASE_URL +
                                                  controller
                                                      .products[index].images!,
                                              fit: BoxFit.cover,
                                              headers: const {},
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'Category : ${controller.products[index].name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'description : ${controller.products[index].description}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          controller.products[index]
                                                      .isPopular ==
                                                  1
                                              ? Text(
                                                  'Popular : Yes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )
                                              : Text(
                                                  'Popular : No',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                }, childCount: controller.products.length),
                              )
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          CustomHeader(
                            heading: 'Dashboard / Products',
                            subHeading: 'Products',
                            showAddButton: true,
                            showBackButton: false,
                            addButtonFunction: () => navController
                                .navigateTo(
                                  routeName: AddProductScreen.id,
                                )
                                .then(
                                  (value) => controller.getProducts(),
                                ),
                            addButtonName: 'Add Product',
                          ),
                          controller.products.isEmpty
                              ? const SizedBox(
                                  height: 400,
                                  child: Center(
                                    child: Text('No Product to show'),
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
                                      label: Text(
                                        'Product',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      size: ColumnSize.L,
                                    ),
                                    DataColumn2(
                                      label: Center(
                                        child: Text(
                                          'Popular',
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
                                          'Category',
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
                                    controller.products.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: AspectRatio(
                                                    aspectRatio: 4 / 3,
                                                    child: Image.network(
                                                      AppConfig.BASE_URL +
                                                          controller
                                                              .products[index]
                                                              .images!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller.products[index]
                                                          .name!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                      controller.products[index]
                                                          .description!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            color: const Color(
                                                                0xff6c757d),
                                                          ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          controller.products[index]
                                                      .isPopular ==
                                                  1
                                              ? Text(
                                                  'Yes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )
                                              : Text(
                                                  'No',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller
                                                .products[index].description!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: PopupMenuButton(
                                              onSelected: (v) {
                                                switch (v) {
                                                  case 1:
                                                    {
                                                      navController.navigatorKey
                                                          .currentState!
                                                          .push(PageTransition(
                                                              key: navController
                                                                  .navigatorKey,
                                                              child:
                                                                  ViewProductVariantScreen(
                                                                productId: controller
                                                                    .products[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              ),
                                                              type: PageTransitionType
                                                                  .bottomToTop));
                                                    }
                                                    break;
                                                  case 2:
                                                    navController.navigateTo(
                                                      routeName:
                                                          EditProductScreen.id,
                                                    );
                                                    break;
                                                  case 3:
                                                    controller.deleteProduct(
                                                      controller
                                                          .products[index].id
                                                          .toString(),
                                                    );
                                                    break;
                                                  default:
                                                    print('dsada');
                                                }
                                              },
                                              itemBuilder: (context) => const [
                                                PopupMenuItem(
                                                  child: Text("view variant"),
                                                  value: 1,
                                                ),
                                                PopupMenuItem(
                                                  child: Text("edit"),
                                                  value: 2,
                                                ),
                                                PopupMenuItem(
                                                  child: Text("delete"),
                                                  value: 3,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
            ),
    );
  }
}
