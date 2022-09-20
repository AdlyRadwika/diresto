import 'package:flutter/material.dart';

import '../../../data/model/restaurant.dart';
import '../detail_page.dart';

class MenuWidget extends StatelessWidget {
  final DetailPage widget;
  final List<Category> menu;
  final int index;

  const MenuWidget({
    Key? key,
    required this.widget,
    required this.menu,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),),
      child: Text(
        menu[index].name,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
