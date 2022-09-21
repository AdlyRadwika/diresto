import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/provider/restaurant_provider.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant.dart';
import '../../widget/review_widget.dart';

class ReviewPage extends StatelessWidget {
  final RestaurantDetailList resto;

  const ReviewPage({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) => RestaurantDetailProvider(
        apiService: ApiService(),
        restaurantId: resto.id,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("${resto.name}'s Reviews"),
        ),
        body: SingleChildScrollView(child: buildReviewList()),
      ),
    );
  }

  Consumer<RestaurantDetailProvider> buildReviewList() {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.hasData) {
          return Column(
            children: [
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: state.result.restaurant.customerReviews.length,
                itemBuilder: (context, index) {
                  return ReviewWidget(
                    review: state.result.restaurant.customerReviews[index],
                  );
                },
              ),
            ],
          );
        } else if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
