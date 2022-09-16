import 'package:diresto/pages/detail/widgets/image_widget.dart';
import 'package:flutter/material.dart';

import '../../data/model/restaurant.dart';

class DetailPage extends StatefulWidget {
  final RestaurantElement resto;
  
  const DetailPage({Key? key, required this.resto}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageWidget(widget: widget),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.resto.name,
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold
                          ),
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
                          const SizedBox(width: 3,),
                          Text(
                            widget.resto.rating.toString(),
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 24,
                        color: Colors.black.withOpacity(0.65),
                      ),
                      const SizedBox(width: 3,),
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
                  ),
                  const SizedBox(height: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        widget.resto.description,
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: isShowMore == true ? null : 3,
                        overflow: isShowMore == true ? null : TextOverflow.fade,
                      ),
                      TextButton(
                        onPressed: () {
                          if(!isShowMore) {
                            isShowMore = true;
                            setState(() {});
                          } else {
                            isShowMore = false;
                            setState(() {});
                          }
                        },
                        child: Center(
                          child: Text( isShowMore == true
                            ? 'Show less'
                            : 'Show more',
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Menu',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Wrap(
                        children: [
                          GridView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 60
                            ),
                            itemCount: widget.resto.menus.foods.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Text(
                                  widget.resto.menus.foods[index].name,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}