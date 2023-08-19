import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/controller/product/view_product_controller.dart';
import 'package:provider/provider.dart';
import '../nav_controller.dart';

class PPP extends StatefulWidget {
  const PPP({Key? key}) : super(key: key);

  @override
  State<PPP> createState() => _PPPState();
}

class _PPPState extends State<PPP> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ViewProductController>(context,listen: false).getProducts();
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
          : controller.products.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('No Category to show'),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                // navController.navigateTo(
                //     routeName: AddCategoryScreen.id)
              },
              child: const Text('Add Category'),
            )
          ],
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard / Categories',
                    style:
                    Theme
                        .of(context)
                        .textTheme
                        .caption!
                        .copyWith(
                      color: const Color(0xff828f99),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Add Category'),
                    onPressed: () {
                      // navController
                                  //     .navigateTo(
                                  //   routeName: AddCategoryScreen.id,
                                  // )
                                  //     .then(
                                  //       (value) => controller.getCategories(),
                                  // )
                                  // ,
                                }
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Categories',
                style:
                Theme
                    .of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              DataTable2(
                columnSpacing: 100,
                decoration: const BoxDecoration(color: Colors.white),
                border:
                TableBorder.all(color: Colors.black54, width: .5),
                horizontalMargin: 12,
                minWidth: 800,
                columns: [
                  DataColumn2(
                    label: Text(
                      'Category',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text(
                        'Visibility',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text(
                        'Color',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      '',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.S,
                  ),
                ],
                rows: List<DataRow>.generate(
                  controller.products.length,
                      (index) =>
                      DataRow(
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
                                                .products[index].images!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // child: SelectableText()
                                    // height: 220,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller
                                            .products[index].name!,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      Text(
                                        controller.products[index]
                                            .description!,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                          color:
                                          const Color(0xff6c757d),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          DataCell(
                            controller.products[index].isPopular == 1
                                ? Text(
                              'Active',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  fontWeight: FontWeight.w500),
                            )
                                : Text(
                              'Hidden',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataCell(
                            Text(
                              controller.products[index].description!,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: const [
                                SizedBox(),
                                Icon(Icons.more_horiz),
                              ],
                            ),
                            onTap: () {},
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
