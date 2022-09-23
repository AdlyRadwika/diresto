import 'package:diresto/provider/database_provider.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/result_state_util.dart';
import '../../widgets/restaurant_item_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: _buildFavoriteList(),
    );
  }

  Widget _buildFavoriteList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return RestaurantItemWidget(
                resto: provider.favorites[index],
                index: index,
              );
            },
          );
        } else {
          return Center(
            child: EmptyWidget(
              packageImage: PackageImage.Image_4,
              hideBackgroundAnimation: true,
              title: 'There is something wrong',
              subTitle: provider.message,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }
      },
    );
  }
}
