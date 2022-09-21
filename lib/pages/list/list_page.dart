import 'package:diresto/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:provider/provider.dart';

import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/pages/route.dart' as route;
import 'package:diresto/widgets/restaurant_item_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<Restaurant> _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().restaurantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diresto'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, route.searchPage),
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ]
      ),
      body: _buildList(context),
    );
  }
}

Widget _buildList(BuildContext context) {
  return Consumer<RestaurantListProvider>(
    builder: (context, state, _) {
      if(state.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantItemWidget(resto: state.result.restaurants[index]);
          },
        );
      } else if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator(),);
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: EmptyWidget(
            packageImage: PackageImage.Image_2,
            hideBackgroundAnimation: true,
            title: 'There is something wrong',
            subTitle: state.message,
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
            subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
          ),
        );
      }
      return const Center(child: CircularProgressIndicator(),);
    },
  );
}