import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../data/model/restaurant.dart';
import 'package:diresto/pages/detail/widgets/menu_widget.dart';
import 'package:diresto/pages/detail/widgets/image_widget.dart';

class DetailPage extends StatefulWidget {
  final RestaurantClass resto;

  const DetailPage({Key? key, required this.resto}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diresto's Detail Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageWidget(widget: widget),
            _buildDetailContent(context),
          ],
        ),
      ),
    );
  }

  Padding _buildDetailContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleRow(context),
          const SizedBox(
            height: 5,
          ),
          _buildLocationRow(context),
          const SizedBox(
            height: 15,
          ),
          _buildDescriptionColumn(context),
          const SizedBox(
            height: 15,
          ),
          _buildMenuColumn(context),
        ],
      ),
    );
  }

  Row _buildTitleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            widget.resto.name,
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
              widget.resto.rating.toString(),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontSize: 18,
                  ),
            )
          ],
        ),
      ],
    );
  }

  Row _buildLocationRow(BuildContext context) {
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
          widget.resto.city,
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

  Column _buildDescriptionColumn(BuildContext context) {
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
          widget.resto.description,
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

  Column _buildMenuColumn(BuildContext context) {
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
              itemCount: widget.resto.menus!.foods.length,
              itemBuilder: (context, index) {
                return MenuWidget(
                  widget: widget,
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
              itemCount: widget.resto.menus!.drinks.length,
              itemBuilder: (context, index) {
                return MenuWidget(
                  widget: widget,
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
