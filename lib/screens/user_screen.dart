import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/user_screen_controller.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static const id = 'ViewAllUserScreen';

  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserScreenController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<UserScreenController>(context);
    return Container(
      color: Colors.white,
      child: controller.loading
          ? const Center(
              child: Text('Loading'),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: CustomHeader(
                      heading: 'Dashboard / Products / Users',
                      subHeading: 'Users',
                      showBackButton: false,
                      showAddButton: false,
                    ),
                  ),
                  controller.users.isEmpty
                      ? const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 400,
                            child: Center(
                              child: Text('No user Found'),
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
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Center(
                                      child: Text(
                                        'E-mail',
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
                                        'Phone-No',
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
                                  controller.users.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Center(
                                          child: Text(
                                            controller.users[index].name!,
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
                                            controller.users[index].email!,
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
                                        Text(
                                          controller.users[index].phoneNo!,
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
                                                  break;
                                                case 3:
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
                                              'Name : ${controller.users[index].name}',
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
                                                    break;
                                                  case 3:
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
                                          'Email : ${controller.users[index].email}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Phone no : ${controller.users[index].phoneNo}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }, childCount: controller.users.length),
                            ),
                ],
              ),
            ),
    );
  }
}
