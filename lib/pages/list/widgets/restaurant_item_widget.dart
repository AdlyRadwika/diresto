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
        resto.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
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
                resto.city,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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