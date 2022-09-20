import 'package:diresto/data/api/api_service.dart';
import 'package:flutter/material.dart';

import 'package:diresto/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

late Restaurant _restaurant;
late RestaurantDetail _restaurantDetail;
late ResultState _state;
String _message = '';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService,}) {
    _fetchRestaurantList();
  }

  String get message => _message;

  Restaurant get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'The list is empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }

}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? restaurantId;

  RestaurantDetailProvider({required this.apiService, this.restaurantId,}) {
    _fetchRestaurantDetail(restaurantId!);
  }

  String get message => _message;

  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantDetail(id);
      if (restaurant.restaurant.toJson().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'The detail is empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}