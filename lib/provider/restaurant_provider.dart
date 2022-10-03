import 'package:flutter/material.dart';

import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/data/model/restaurant.dart';

import '../utils/error_util.dart';
import '../utils/result_state_util.dart';


late Restaurant _restaurant;
late RestaurantDetail _restaurantDetail;
late RestaurantSearch _restaurantSearch;
late ResultState _state;
String _message = '';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({
    required this.apiService,
  }) {
    fetchRestaurantList();
  }

  String get message => _message;

  Restaurant get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantList() async {
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
      _message = ErrorUtil.convertErrorMessage('$e');
      return _message;
    }
  }
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? restaurantId;

  RestaurantDetailProvider({required this.apiService, this.restaurantId}) {
    fetchRestaurantDetail(restaurantId!);
  }

  String get message => _message;

  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantDetail(String id) async {
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
      _message = ErrorUtil.convertErrorMessage('$e');
      return _message;
    }
  }

  Future<String> sendCustomerReview(
      String restoId, String username, String userReview) async {
    final review =
        await apiService.postCustomerReview(restoId, username, userReview);
    notifyListeners();
    return review;
  }

  fetchRestaurantDetailAgain(String restoId) {
    fetchRestaurantDetail(restoId);
    notifyListeners();
  }
}

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String? query;

  RestaurantSearchProvider({required this.apiService, this.query}) {
    _fetchRestaurantSearch(query!);
  }

  String get message => _message;

  RestaurantSearch get result => _restaurantSearch;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message =
            '"$query" is not included in any restaurant. Start searching by name, category, and menu.';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = ErrorUtil.convertErrorMessage('$e');
      return _message;
    }
  }

  searchTheRestaurant(String query) {
    this.query = query;
    _fetchRestaurantSearch(this.query!);
    notifyListeners();
  }
}
