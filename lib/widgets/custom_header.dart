import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:provider/provider.dart';

class CustomHeader extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String addButtonName;
  final bool showAddButton;
  final bool showBackButton;
  final Function? addButtonFunction;

  const CustomHeader({
    Key? key,
    required this.heading,
    required this.subHeading,
    this.addButtonName = '',
    this.showAddButton = true,
    this.showBackButton = false,
    this.addButtonFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navController = Provider.of<NavController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showBackButton
            ? Row(
                children: [
                  IconButton(
                    onPressed: () => navController.goBack(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            : const SizedBox(
                height: 24,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: const Color(0xff828f99),
                  ),
            ),
            showAddButton
                ? ElevatedButton(
                    child: Text(addButtonName),
                    onPressed: () {
                      addButtonFunction!.call();
                    },
                  )
                : const SizedBox()
          ],
        ),
        showAddButton
            ? const SizedBox(
                height: 4,
              )
            : const SizedBox(
                height: 16,
              ),
        Text(
          subHeading,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
