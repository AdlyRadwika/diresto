import 'package:flutter/material.dart';

import '../../../data/model/restaurant.dart';

class MenuWidget extends StatelessWidget {
  final Category menu;

  const MenuWidget({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        menu.name,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
