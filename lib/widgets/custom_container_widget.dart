import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget widget;
  final bool usePrimaryColor;
  final bool usePrimaryBorder;

  const CustomContainer(
      {Key? key,
      required this.widget,
      required this.usePrimaryColor,
      required this.usePrimaryBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: usePrimaryColor == true
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        border: usePrimaryBorder == true
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget,
    );
  }
}
