import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant.dart';
import '../../utils/result_state_util.dart';
import '../../widgets/review_widget.dart';
import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/pages/review/widgets/input_review_widget.dart';
import 'package:diresto/provider/restaurant_provider.dart';

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
          actions: [
            IconButton(
              onPressed: () => _buildInputReviewModal(context),
              tooltip: 'Add Review',
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: _buildReviewList(),
        ),
      ),
    );
  }

  Consumer<RestaurantDetailProvider> _buildReviewList() {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.hasData) {
          return Column(
            children: [
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                reverse: true,
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

  void _buildInputReviewModal(BuildContext context) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      isDismissible: true,
      enableDrag: true,
      bounce: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (context) => RestaurantDetailProvider(
              apiService: ApiService(), restaurantId: resto.id),
          child: Wrap(
            children: [
              InputReviewWidget(
                resto: resto,
              )
            ],
          ),
        );
      },
    );
  }
}
