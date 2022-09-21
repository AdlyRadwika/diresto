import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:diresto/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _list = 'list';
  static const String _images = 'images';
  static const String _detail = 'detail';
  static const String _search = 'search?q=';
  static const String _review = 'review';

  Future<Restaurant> restaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/$_list"));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the restaurant list');
    }
  }

  String restaurantImage(String imageSize, String pictureId) {
    final url = "$_baseUrl/$_images/$imageSize/$pictureId";
    return url;
  }

  Future<RestaurantDetail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/$_detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the restaurant detail');
    }
  }

  Future<RestaurantSearch> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/$_search$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('The page is currently empty start by searching the name, category, and menu.');
    }
  }
  
  Future<String> postCustomerReview(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/$_review"),
      body: {
        "id" : id,
        "name" : name,
        "review" : review
      }
    );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to send a review');
    }
  }
}