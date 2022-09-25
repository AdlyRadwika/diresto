import 'package:flutter/material.dart';

import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/pages/route.dart' as route;
import 'package:provider/provider.dart';

import '../provider/database_provider.dart';
import '../utils/navigation_util.dart';

class RestaurantItemWidget extends StatelessWidget {
  final RestaurantList resto;
  final int index;

  const RestaurantItemWidget(
      {Key? key, required this.resto, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(resto.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    DetailPageArguments arguments =
                        DetailPageArguments(restoId: resto.id, index: index);
                    Navigation.intentWithData(route.detailPage, arguments);
                  },
                  isThreeLine: true,
                  leading: Hero(
                    tag: resto.pictureId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ApiService()
                            .restaurantImage('small', resto.pictureId),
                        width: 125,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            resto.city,
                            style: Theme.of(context).textTheme.overline,
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
                            size: 16,
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            resto.rating.toString(),
                            style: Theme.of(context).textTheme.overline,
                          )
                        ],
                      ),
                    ],
                  ),
                  trailing: isFavorite
                      ? IconButton(
                          onPressed: () {
                            provider.removeFavorite(resto.id);
                          },
                          icon: const Icon(
                            Icons.favorite,
                            size: 26,
                            color: Colors.redAccent,
                          ),
                          splashColor: Colors.transparent,
                          tooltip: 'Favorite',
                        )
                      : IconButton(
                          onPressed: () {
                            provider.addFavorite(resto);
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 26,
                            color: Colors.redAccent,
                          ),
                          splashColor: Colors.transparent,
                          tooltip: 'Favorite',
                        ),
                ),
                const Divider(
                  height: 2,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class DetailPageArguments {
  final String restoId;
  final int index;

  DetailPageArguments({required this.restoId, required this.index});
}
