import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/controller/bundle/bundle_screen_controlloer.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/screens/bundle/add_bundle_screen.dart';
import 'package:my_grocery_admin/screens/bundle/add_product_to_bundle_screen.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class BundleScreen extends StatefulWidget {
  static const id = 'BundleScreen';

  const BundleScreen({Key? key}) : super(key: key);

  @override
  State<BundleScreen> createState() => _BundleScreenState();
}

class _BundleScreenState extends State<BundleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BundleScreenController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<BundleScreenController>(context);
    var navController = Provider.of<NavController>(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomHeader(
            heading: 'Dashboard / Bundles',
            subHeading: 'Bundles',
            addButtonName: 'Add Bundle',
            showBackButton: false,
            addButtonFunction: () {
              navController.navigateTo(routeName: AddBundleScreen.id).then(
                    (value) => controller.getBundles(),
                  );
            },
          ),
        ),
        controller.loading
            ? const SliverToBoxAdapter(
                child: Text("Loading"),
              )
            : controller.listOfBundles.isEmpty
                ? const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 400,
                      child: Center(
                        child: Text('No Bundle to show'),
                      ),
                    ),
                  )
                : controller.isWeb
                    ? SliverToBoxAdapter(
                        child: DataTable2(
                          columnSpacing: 100,
                          decoration: const BoxDecoration(color: Colors.white),
                          border:
                              TableBorder.all(color: Colors.black54, width: .5),
                          horizontalMargin: 12,
                          minWidth: 800,
                          columns: [
                            DataColumn2(
                              label: Text(
                                'Bundle',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text(
                                'Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: Text(
                                'Description',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Center(
                                child: Text(
                                  'Unit Price',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text(
                                'Discount',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text(
                                'Is Active',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text(
                                '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              size: ColumnSize.S,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            controller.listOfBundles.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 80,
                                      child: AspectRatio(
                                        aspectRatio: 4 / 3,
                                        child: Image.network(
                                          AppConfig.BASE_URL +
                                              controller
                                                  .listOfBundles[index].image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // child: SelectableText()
                                      // height: 220,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    controller.listOfBundles[index].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    controller
                                        .listOfBundles[index].description!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: const Color(0xff6c757d),
                                        ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    controller.listOfBundles[index].unitPrice!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: const Color(0xff6c757d),
                                        ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    controller
                                        .listOfBundles[index].discountPrice!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: const Color(0xff6c757d),
                                        ),
                                  ),
                                ),
                                DataCell(
                                  controller.listOfBundles[index].isActive == 1
                                      ? Text(
                                          'Active',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          'Hidden',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                ),
                                DataCell(
                                  Center(
                                    child: PopupMenuButton(
                                      onSelected: (v) {
                                        switch (v) {
                                          case 1:
                                            {
                                              // String rawJson =
                                              // ;
                                              // Map<String, dynamic> map =
                                              // jsonDecode(rawJson);
                                              navController
                                                  .navigatorKey.currentState
                                                  ?.push(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddProductToBundleScreen(
                                                    bundle: controller
                                                        .listOfBundles[index],
                                                  ),
                                                ),
                                              );
                                            }
                                            break;
                                          case 2:
                                            // controller.deleteCategory(
                                            //   controller.categories[index].id
                                            //       .toString(),
                                            // );
                                            break;
                                          default:
                                            print('dsada');
                                        }
                                      },
                                      itemBuilder: (context) => const [
                                        PopupMenuItem(
                                          child: Text("add product"),
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child: Text("delete"),
                                          value: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    // : SliverList(
                    //     delegate: SliverChildBuilderDelegate((_, index) {
                    //       return Card(
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(16.0),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text(
                    //                     'Name : ${controller.categories[index].name}',
                    //                     style:
                    //                         Theme.of(context).textTheme.headline6,
                    //                   ),
                    //                   PopupMenuButton(
                    //                     onSelected: (v) {
                    //                       switch (v) {
                    //                         case 1:
                    //                           {}
                    //                           break;
                    //                         case 2:
                    //                           controller.deleteCategory(
                    //                             controller.categories[index].id
                    //                                 .toString(),
                    //                           );
                    //                           break;
                    //                         default:
                    //                           print('dsada');
                    //                       }
                    //                     },
                    //                     itemBuilder: (context) => const [
                    //                       PopupMenuItem(
                    //                         child: Text("edit"),
                    //                         value: 1,
                    //                       ),
                    //                       PopupMenuItem(
                    //                         child: Text("delete"),
                    //                         value: 2,
                    //                       ),
                    //                     ],
                    //                   )
                    //                 ],
                    //               ),
                    //               const SizedBox(
                    //                 height: 8,
                    //               ),
                    //               AspectRatio(
                    //                 aspectRatio: 4 / 3,
                    //                 child: Image.network(
                    //                   AppConfig.BASE_URL +
                    //                       controller.categories[index].image!,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 height: 8,
                    //               ),
                    //               Text(
                    //                 'Color : ${controller.categories[index].color}',
                    //                 style: Theme.of(context).textTheme.headline6,
                    //               ),
                    //               const SizedBox(
                    //                 height: 8,
                    //               ),
                    //               controller.categories[index].isActive == 1
                    //                   ? Text(
                    //                       'Active : Yes',
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .bodyText1!
                    //                           .copyWith(
                    //                               fontWeight: FontWeight.w500),
                    //                     )
                    //                   : Text(
                    //                       'Active : No',
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .bodyText1!
                    //                           .copyWith(
                    //                               fontWeight: FontWeight.w500),
                    //                     ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }, childCount: controller.categories.length),
                    //   ),
                    : const SizedBox()
      ],
    );
  }
}
