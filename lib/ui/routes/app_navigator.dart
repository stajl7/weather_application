import 'package:flutter/material.dart';
import 'package:weather_application/ui/pages/animated_splash_screen/animated_splesh_screen.dart';
import '../pages/error_page/error_page.dart';
import '../pages/search_page/search_page.dart';
import 'app_router.dart';

class AppNavigator {
  
  static String initRoute = AppRoutes.home;
  static Map<String, WidgetBuilder> get routes{
    
    return {
      AppRoutes.home: (_) => const AnimatedScreen(),
      AppRoutes.search: (_) => const SearchPage()
    };
  }
  
  static Route generate(RouteSettings settings) {
    final _settings = RouteSettings(
      name: '/404',
      arguments: settings.arguments,
    );
    return MaterialPageRoute(
      settings: _settings,
      builder: (_) => const ErrorPage(),
    
    );
  }
  
}