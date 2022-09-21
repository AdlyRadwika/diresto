import 'package:diresto/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String emptyWarning;
  final String labelText;
  final String hintText;

  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.emptyWarning,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        return TextFormField(
          controller: widget.textEditingController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.emptyWarning;
            }
            return null;
          },
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            isDense: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: widget.hintText,
            labelText: widget.labelText,
          ),
        );
      },
    );
  }
}
