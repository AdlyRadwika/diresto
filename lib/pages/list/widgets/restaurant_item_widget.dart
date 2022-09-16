import 'package:flutter/material.dart';

import 'package:diresto/data/model/restaurant.dart';

class RestaurantItemWidget extends StatelessWidget {
  final RestaurantElement resto;

  const RestaurantItemWidget({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      isThreeLine: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          resto.pictureId,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        resto.name
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 3,),
              Text(
                resto.city
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.star),
              const SizedBox(width: 3,),
              Text(
                resto.rating.toString(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
