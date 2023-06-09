import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatelessWidget{

  final double score;

  const RatingBarWidget({required final this.score});


  @override
  Widget build(final BuildContext context)=>_ratingBar(score);

  Widget _ratingBar(final double score) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: RatingBar.builder(
        onRatingUpdate: (v){},
        initialRating: score,
        minRating: 1,
        wrapAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 20.0,
        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
        itemBuilder: (final context, final _) => const Icon(
          Icons.star,
          color: Colors.amber,
        )),
  );
}