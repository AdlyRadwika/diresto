import 'package:flutter/material.dart';

import 'package:diresto/pages/detail/detail_page.dart';
import 'package:diresto/pages/list/list_page.dart';
import 'package:diresto/pages/splash/splash_page.dart';
import 'package:diresto/pages/search/search_page.dart';

const listPage = 'list_page';
const detailPage = 'detail_page';
const splashPage = 'splash_page';
const searchPage = 'search_page';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case listPage:
      return MaterialPageRoute(
        builder: (context) => const ListPage(),
      );
    case detailPage:
      String restoId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => DetailPage(restaurantId: restoId),
      );
    case splashPage:
      return MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );
    case searchPage:
      return MaterialPageRoute(builder: (context) => const SearchPage(),);
    default:
      throw ('Page is not found!');
  }
}
