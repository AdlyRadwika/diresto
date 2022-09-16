import 'package:flutter/material.dart';

import '../detail_page.dart';

class ImageWidget extends StatelessWidget {
  final DetailPage widget;

  const ImageWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Image.network(
          widget.resto.pictureId,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}