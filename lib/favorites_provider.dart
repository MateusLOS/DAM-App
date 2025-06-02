import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recommendation_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Recommendation> _favorites = [];

  List<Recommendation> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  void toggleFavorite(Recommendation r) {
    final exists = _favorites.any((item) => item.id == r.id && item.type == r.type);
    if (exists) {
      _favorites.removeWhere((item) => item.id == r.id && item.type == r.type);
    } else {
      _favorites.add(r);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Recommendation r) {
    return _favorites.any((item) => item.id == r.id && item.type == r.type);
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _favorites.map((r) => json.encode(r.toJson())).toList();
    await prefs.setStringList('favorites', encoded);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getStringList('favorites') ?? [];
    _favorites.clear();
    _favorites.addAll(encoded.map((s) => Recommendation.fromJson(json.decode(s))));
    notifyListeners();
  }
}
