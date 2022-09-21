import 'package:flutter/material.dart';

import '../data/model/restaurant.dart';

class ReviewWidget extends StatelessWidget {
  final CustomerReview review;

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          child: FittedBox(
            child: Icon(Icons.person),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                review.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white
                ),
              )
            ),
            Text(
              review.date,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.50)
              ),
            ),
          ],
        ),
        subtitle: Text(
          review.review,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
