import 'package:flutter/material.dart';

import '../detail_page.dart';
import 'package:diresto/pages/route.dart' as route;

class ImageWidget extends StatelessWidget {
  final DetailPage widget;

  const ImageWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Stack(
        children: [
          SizedBox(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, route.listPage, (route) => false);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                    iconSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}