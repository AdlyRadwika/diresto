import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:diresto/provider/restaurant_provider.dart';
import '../../data/api/api_service.dart';
import '../../data/model/restaurant.dart';
import 'package:diresto/pages/detail/widgets/menu_widget.dart';
import 'package:diresto/pages/detail/widgets/image_widget.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;

  const DetailPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) => RestaurantDetailProvider(
        apiService: ApiService(),
        restaurantId: widget.restaurantId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Diresto's Detail Page"),
        ),
        body: SingleChildScrollView(
          child: _buildDetailContent(context),
        ),
      ),
    );
  }

  Consumer<RestaurantDetailProvider> _buildDetailContent(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.hasData) {
          return Column(
            children: [
              ImageWidget(widget: widget, resto: state.result.restaurant),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleRow(context, state.result.restaurant),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildLocationRow(context, state.result.restaurant),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildDescriptionColumn(context, state.result.restaurant),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildMenuColumn(context, state.result.restaurant),
                  ],
                ),
              ),
            ],
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

  Row _buildTitleRow(BuildContext context, RestaurantDetailList resto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            resto.name,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.star,
              size: 30,
              color: Colors.orangeAccent,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              resto.rating.toString(),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontSize: 18,
                  ),
            )
          ],
        ),
      ],
    );
  }

  Row _buildLocationRow(BuildContext context, RestaurantDetailList resto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          size: 24,
          color: Colors.black.withOpacity(0.65),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          resto.city,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 16,
                color: Colors.black.withOpacity(0.65),
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Column _buildDescriptionColumn(BuildContext context, RestaurantDetailList resto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          resto.description,
          style: Theme.of(context).textTheme.bodyText2,
          maxLines: isShowMore == true ? null : 3,
          overflow: isShowMore == true ? null : TextOverflow.fade,
        ),
        TextButton(
          onPressed: () {
            if (!isShowMore) {
              isShowMore = true;
              setState(() {});
            } else {
              isShowMore = false;
              setState(() {});
            }
          },
          child: Center(
            child: Text(
              isShowMore == true ? 'Show less' : 'Show more',
            ),
          ),
        )
      ],
    );
  }

  Column _buildMenuColumn(BuildContext context, RestaurantDetailList resto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Wrap(
          spacing: 5,
          children: [
            MasonryGridView.count(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              itemCount: resto.menus.foods.length,
              itemBuilder: (context, index) {
                return MenuWidget(
                  widget: widget,
                  resto: resto,
                  index: index,
                  isDrinks: false,
                );
              },
            ),
            const Divider(),
            MasonryGridView.count(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              itemCount: resto.menus.drinks.length,
              itemBuilder: (context, index) {
                return MenuWidget(
                  widget: widget,
                  resto: resto,
                  index: index,
                  isDrinks: true,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}