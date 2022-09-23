import 'package:diresto/data/model/restaurant.dart';
import 'package:flutter/material.dart';

import 'package:diresto/pages/detail/detail_page.dart';
import 'package:diresto/pages/list/list_page.dart';
import 'package:diresto/pages/splash/splash_page.dart';
import 'package:diresto/pages/search/search_page.dart';
import 'package:diresto/pages/review/review_page.dart';
import 'package:diresto/pages/home/home_page.dart';
import 'package:diresto/pages/settings/settings_page.dart';

import '../widgets/restaurant_item_widget.dart';

const listPage = 'list_page';
const detailPage = 'detail_page';
const splashPage = 'splash_page';
const searchPage = 'search_page';
const reviewPage = 'review_page';
const homePage = 'home_page';
const settingsPage = 'settings_page';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case listPage:
      return MaterialPageRoute(
        builder: (context) => const ListPage(),
      );
    case detailPage:
      DetailPageArguments arguments = settings.arguments as DetailPageArguments;
      return MaterialPageRoute(
        builder: (context) =>
            DetailPage(restaurantId: arguments.restoId, index: arguments.index),
      );
    case splashPage:
      return MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );
    case searchPage:
      return MaterialPageRoute(
        builder: (context) => const SearchPage(),
      );
    case reviewPage:
      RestaurantDetailList resto = settings.arguments as RestaurantDetailList;
      return MaterialPageRoute(
        builder: (context) => ReviewPage(resto: resto),
      );
    case homePage:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case settingsPage:
      return MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      );
    default:
      throw ('Page is not found!');
  }
}
