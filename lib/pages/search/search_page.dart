import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/provider/restaurant_provider.dart';
import 'package:diresto/pages/search/widgets/search_field_widget.dart';
import '../../widgets/restaurant_item_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (context) => RestaurantSearchProvider(
        apiService: ApiService(),
        query: searchController.text,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: SearchFieldWidget(searchController: searchController),
        ),
        body: _buildSearchList(),
      ),
    );
  }

  Consumer<RestaurantSearchProvider> _buildSearchList() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              return RestaurantItemWidget(
                  resto: state.result.restaurants[index]);
            },
          );
        } else if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.noData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: EmptyWidget(
              packageImage: PackageImage.Image_4,
              hideBackgroundAnimation: true,
              title: 'There is something wrong',
              subTitle: state.message,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
