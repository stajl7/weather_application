import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/domain/provider/weather_provider.dart';
import 'package:weather_application/ui/routes/app_navigator.dart';


class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MainAppWidget());
  }
}



class MainAppWidget extends StatelessWidget {
  const MainAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, //будет переводить приложение на язык устроновленом на тедефоне
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: AppNavigator.initRoute,
      routes: AppNavigator.routes,
      onGenerateRoute: AppNavigator.generate,
    );
  }
}