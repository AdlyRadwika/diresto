import 'package:flutter/material.dart';

import 'package:diresto/data/model/restaurant.dart';

import 'package:diresto/pages/detail/detail_page.dart';
import 'package:diresto/pages/list/list_page.dart';

const listPage = 'list_page';
const detailPage = 'detail_page';

Route<dynamic> controller (RouteSettings settings) {
  switch (settings.name) {
    case listPage:
      return MaterialPageRoute(builder: (context) => const ListPage(),);
    case detailPage:
      RestaurantElement resto = settings.arguments as RestaurantElement;
      return MaterialPageRoute(builder: (context) => DetailPage(resto: resto),);
    default:
      throw('Page is not found!');
  }
}