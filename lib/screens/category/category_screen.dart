import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/controller/category/category_screen_controller.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/screens/category/add_category_screen.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static const id = 'CategoryScreen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryScreenController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CategoryScreenController>(context);
    var navController = Provider.of<NavController>(context);
    return Container(
      color: Colors.white,
      child: controller.loading
          ? const Center(
              child: Text('Loading'),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CustomHeader(
                    heading: 'Dashboard / Categories',
                    subHeading: 'Categories',
                    showBackButton: false,
                    showAddButton: true,
                    addButtonName: 'Add Category',
                    addButtonFunction: () => navController
                        .navigateTo(
                          routeName: AddCategoryScreen.id,
                        )
                        .then(
                          (value) => controller.getCategories(),
                        ),
                  ),
                ),
                controller.categories.isEmpty
                    ? const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 400,
                          child: Center(
                            child: Text('No Category to show'),
                          ),
                        ),
                      )
                    : controller.isWeb
                        ? SliverToBoxAdapter(
                            child: DataTable2(
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
                                    'Category',
                                    style: Theme.of(context)
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
                                      'Color',
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
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  size: ColumnSize.S,
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                controller.categories.length,
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
                                                          .categories[index]
                                                          .image!,
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
                                                      .categories[index].name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                Text(
                                                  controller.categories[index]
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
                                      controller.categories[index].isActive == 1
                                          ? Text(
                                              'Active',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            )
                                          : Text(
                                              'Hidden',
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
                                        controller.categories[index].color!,
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
                                                {}
                                                break;
                                              case 2:
                                                controller.deleteCategory(
                                                  controller
                                                      .categories[index].id
                                                      .toString(),
                                                );
                                                break;
                                              default:
                                                print('dsada');
                                            }
                                          },
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                              child: Text("edit"),
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
                                            'Name : ${controller.categories[index].name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          PopupMenuButton(
                                            onSelected: (v) {
                                              switch (v) {
                                                case 1:
                                                  {}
                                                  break;
                                                case 2:
                                                  controller.deleteCategory(
                                                    controller
                                                        .categories[index].id
                                                        .toString(),
                                                  );
                                                  break;
                                                default:
                                                  print('dsada');
                                              }
                                            },
                                            itemBuilder: (context) => const [
                                              PopupMenuItem(
                                                child: Text("edit"),
                                                value: 1,
                                              ),
                                              PopupMenuItem(
                                                child: Text("delete"),
                                                value: 2,
                                              ),
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
                                                  .categories[index].image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Color : ${controller.categories[index].color}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      controller.categories[index].isActive == 1
                                          ? Text(
                                              'Active : Yes',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            )
                                          : Text(
                                              'Active : No',
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
                            }, childCount: controller.categories.length),
                          ),
              ],
            ),
    );
  }
}
