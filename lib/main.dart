import 'package:flutter/material.dart';

import 'package:diresto/pages/route.dart' as route;
import 'package:diresto/utils/theme_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: route.listPage,
    );
  }
}