import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diresto/data/api/api_service.dart';
import 'package:diresto/pages/route.dart' as route;
import 'package:diresto/utils/theme_util.dart';
import 'package:diresto/provider/restaurant_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (context) => RestaurantListProvider(apiService: ApiService()),
      child: MaterialApp(
        title: 'Diresto',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.white,
                secondary: secondaryColor,
              ),
          textTheme: myTextTheme,
        ),
        onGenerateRoute: route.controller,
        initialRoute: route.splashPage,
      ),
    );
  }
}
