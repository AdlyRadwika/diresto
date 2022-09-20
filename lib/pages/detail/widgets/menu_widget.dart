import 'package:flutter/material.dart';

import '../detail_page.dart';

class MenuWidget extends StatelessWidget {
  final DetailPage widget;
  final int index;
  final bool? isDrinks;

  const MenuWidget({
    Key? key,
    required this.widget,
    required this.index,
    required this.isDrinks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isDrinks == true
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),),
      child: Text(
        isDrinks == true
            ? widget.resto.menus.drinks[index].name
            : widget.resto.menus.foods[index].name,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
