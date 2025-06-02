import 'package:flutter/material.dart';
import 'recommendation_model.dart';

class Rating {
  final Recommendation recommendation;
  final int stars;
  final String comment;

  Rating({
    required this.recommendation,
    required this.stars,
    required this.comment,
  });
}

class RatingsProvider extends ChangeNotifier {
  final List<Rating> _ratings = [];

  List<Rating> get ratings => List.unmodifiable(_ratings);

  void addRating(Rating rating) {
    _ratings.add(rating);
    notifyListeners();
  }

  void removeRating(Rating rating) {
    _ratings.remove(rating);
    notifyListeners();
  }

  List<Rating> getRatingsFor(Recommendation r) {
    return _ratings.where((x) => x.recommendation.id == r.id).toList();
  }
}
