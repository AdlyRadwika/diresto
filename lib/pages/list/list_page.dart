import 'package:flutter/material.dart';
import 'package:empty_widget/empty_widget.dart';

import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/pages/list/widgets/restaurant_item_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diresto'),
      ),
      body: FutureBuilder<String> (
        future: 
          DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          final List<RestaurantElement> resto = parseRestaurants(snapshot.data);
          return snapshot.hasError
            ? Center(
              child: EmptyWidget(
                packageImage: PackageImage.Image_2,
                title: 'There is something wrong',
                subTitle: snapshot.error.toString(),
              ),
            )
            : resto.isEmpty
              ? const Center(child: CircularProgressIndicator(),)
              : ListView.builder(
                  itemCount: resto.length,
                  itemBuilder: (context, index) {
                    return RestaurantItemWidget(resto: resto[index]);
                  },
                );
        },
      ),
    );
  }
}
