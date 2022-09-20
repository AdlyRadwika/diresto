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
}