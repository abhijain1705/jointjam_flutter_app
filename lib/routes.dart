import 'package:flutter/widgets.dart';
import 'package:jointjam/screens/home/home.dart';
import 'package:jointjam/screens/splash/splash.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
