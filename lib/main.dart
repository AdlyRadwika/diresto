import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:diresto/data/preferences/preferences_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api/api_service.dart';
import 'package:diresto/provider/preferences_provider.dart';
import 'package:diresto/provider/restaurant_provider.dart';
import 'package:diresto/provider/scheduling_provider.dart';
import 'package:diresto/utils/navigation_util.dart';
import 'package:diresto/utils/background_service_util.dart';
import 'package:diresto/utils/notification_helper_util.dart';
import 'package:diresto/utils/theme_util.dart';
import 'package:diresto/pages/route.dart' as route;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => RestaurantListProvider(
                  apiService: ApiService(),
                )),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        ),
      ],
      child: MaterialApp(
        title: 'Diresto',
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  secondary: secondaryColor,
                ),
            textTheme: myTextTheme,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white,
              selectionColor: Colors.white.withOpacity(0.5),
              selectionHandleColor: Colors.grey,
            )),
        navigatorKey: navigatorKey,
        onGenerateRoute: route.controller,
        initialRoute: route.splashPage,
      ),
    );
  }
}
