import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/coupon/coupon_screen_controller.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/screens/coupon/add_coupon_screen.dart';
import 'package:my_grocery_admin/screens/coupon/edit_coupon_screen.dart';
import 'package:my_grocery_admin/widgets/custom_header.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatefulWidget {
  static const id = 'CouponScreen';

  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CouponScreenController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CouponScreenController>(context);
    var navController = Provider.of<NavController>(context);
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
                  SliverToBoxAdapter(
                    child: CustomHeader(
                      heading: 'Dashboard / Coupons',
                      subHeading: 'Coupons',
                      addButtonName: 'Add Coupon',
                      showBackButton: false,
                      addButtonFunction: () {
                        navController
                            .navigateTo(routeName: AddCouponScreen.id)
                            .then(
                              (value) => controller.getCoupons(),
                            );
                      },
                    ),
                  ),
                  controller.coupons.isEmpty
                      ? const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 400,
                            child: Center(
                              child: Text('No coupon Found'),
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
                                        'Code',
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
                                        'Type',
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
                                        'Active',
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
                                        'Valid Date',
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
                                  controller.coupons.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Center(
                                          child: Text(
                                            controller.coupons[index].name!,
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
                                            controller.coupons[index].code!,
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
                                          controller.coupons[index].type! == '1'
                                              ? 'Percentage'
                                              : 'Fixed',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          controller.coupons[index].isActive! ==
                                                  1
                                              ? 'Activated'
                                              : 'Deactivated',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          controller.coupons[index].validUpto!,
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
                                                  navController.navigatorKey
                                                      .currentState!
                                                      .push(
                                                        PageTransition(
                                                            key: navController
                                                                .navigatorKey,
                                                            child:
                                                                EditCouponScreen(
                                                              coupon: controller
                                                                      .coupons[
                                                                  index],
                                                            ),
                                                            type: PageTransitionType
                                                                .bottomToTop),
                                                      )
                                                      .then(
                                                        (value) => controller
                                                            .getCoupons(),
                                                      );
                                                  break;
                                                case 2:
                                                  controller
                                                      .deleteCoupon(
                                                        controller
                                                            .coupons[index].id
                                                            .toString(),
                                                      )
                                                      .then(
                                                        (value) => controller
                                                            .getCoupons(),
                                                      );
                                                  break;
                                                case 3:
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
                                              'Name : ${controller.coupons[index].name}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            PopupMenuButton(
                                              onSelected: (v) {
                                                switch (v) {
                                                  case 1:
                                                    navController.navigatorKey
                                                        .currentState!
                                                        .push(
                                                      PageTransition(
                                                          key: navController
                                                              .navigatorKey,
                                                          child:
                                                          EditCouponScreen(
                                                            coupon: controller
                                                                .coupons[
                                                            index],
                                                          ),
                                                          type: PageTransitionType
                                                              .bottomToTop),
                                                    )
                                                        .then(
                                                          (value) => controller
                                                          .getCoupons(),
                                                    );
                                                    break;
                                                  case 2:
                                                    controller
                                                        .deleteCoupon(
                                                      controller
                                                          .coupons[index].id
                                                          .toString(),
                                                    )
                                                        .then(
                                                          (value) => controller
                                                          .getCoupons(),
                                                    );
                                                    break;
                                                  case 3:
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
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Code : ${controller.coupons[index].code}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        controller.coupons[index].isActive == 1
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
                                        controller.coupons[index].type == '1'
                                            ? Text(
                                                'Type : Percentage',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              )
                                            : Text(
                                                'Type : Fixed',
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
                              }, childCount: controller.coupons.length),
                            ),
                ],
              )),
    );
  }
}
