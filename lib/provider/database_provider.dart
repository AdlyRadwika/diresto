import 'package:diresto/data/model/restaurant.dart';
import 'package:diresto/utils/error_util.dart';
import 'package:flutter/material.dart';

import '../data/db/database_helper.dart';
import '../utils/result_state_util.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<RestaurantList> _favorites = [];

  List<RestaurantList> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'There is no data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantList resto) async {
    try {
      await databaseHelper.insertFavorite(resto);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = ErrorUtil.convertErrorMessage('$e');
      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = ErrorUtil.convertErrorMessage('$e');
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteResto = await databaseHelper.getFavoriteById(id);
    return favoriteResto.isNotEmpty;
  }
}
