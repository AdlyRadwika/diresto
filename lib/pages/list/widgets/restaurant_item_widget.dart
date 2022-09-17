import 'package:flutter/material.dart';

import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/pages/route.dart' as route;

class RestaurantItemWidget extends StatelessWidget {
  final RestaurantElement resto;

  const RestaurantItemWidget({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(route.detailPage, arguments: resto);
            },
            isThreeLine: true,
            leading: Hero(
              tag: resto.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  resto.pictureId,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              resto.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                    const Icon(
                      Icons.location_on,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
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
                    const Icon(
                      Icons.star,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      resto.rating.toString(),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
          ),
        ],
      ),
    );
  }
}
