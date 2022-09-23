import 'package:diresto/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diresto/provider/restaurant_provider.dart';
import '../../../data/model/restaurant.dart';
import '../../../utils/result_state_util.dart';
import '../detail_page.dart';

class ImageWidget extends StatelessWidget {
  final DetailPage widget;
  final RestaurantDetailList resto;

  const ImageWidget({
    Key? key,
    required this.widget,
    required this.resto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.hasData) {
          return SafeArea(
            top: true,
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: resto.pictureId,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    ApiService().restaurantImage('large', resto.pictureId),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
