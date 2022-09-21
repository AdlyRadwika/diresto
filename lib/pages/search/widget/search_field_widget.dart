import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/api/api_service.dart';
import '../../../provider/restaurant_provider.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        return TextField(
          controller: searchController,
          autofocus: true,
          onChanged: (value) {
            Provider.of<RestaurantSearchProvider>(context, listen: false)
                .searchTheRestaurant(value);
          },
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: searchController.clear,
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              tooltip: 'Clear',
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
