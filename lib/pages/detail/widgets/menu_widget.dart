import 'package:flutter/material.dart';

import '../../../data/model/restaurant.dart';
import '../../../widgets/custom_container_widget.dart';

class MenuWidget extends StatelessWidget {
  final Category menu;

  const MenuWidget({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      usePrimaryBorder: false,
      usePrimaryColor: true,
      widget: Text(
        menu.name,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
