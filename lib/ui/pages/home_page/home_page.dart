import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/domain/provider/weather_provider.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';

import '../../components/current_weather_status/current_weather_status.dart';
import '../../components/max_min_temp/max_min_temp.dart';
import '../../components/seven_days_weather_widget/seven_days_weather_widget.dart';
import '../../components/sunrise_sunset_widget/sunrise_sunset_widget.dart';
import '../../components/weather_app_bar/weather_app_bar.dart';
import '../../components/weather_info_items/weather_info_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(
          context,
          listen: false,
        ).setUp(),
        builder: (context, snapshot) {

          // Пока данные загружаются
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [
                  Colors.blue,
                  Colors.black,
                ],
              ),
            );
          }

          // Если во время загрузки произошла ошибка
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Ошибка загрузки погоды:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ),
            );
          }

          // Если setUp завершился
          return const HomePageWidget();
        },
      ),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(model.setBg()),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const WeatherAppBar(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 10,
              ),
              children: [

                // Было:
                // '${model.date.last} ${model.setCurrentTime()}'
                //
                // Теперь проверяем, что date не пустой
                Text(
                  '${model.date.isNotEmpty ? model.date.last : ''} '
                  '${model.setCurrentTime()}',
                  textAlign: TextAlign.center,
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 14,
                    color: AppColors.darkBlueColor,
                  ),
                ),

                const SizedBox(height: 36),

                const CurrentWeatherStatus(),

                const SizedBox(height: 28),

                Text(
                  '${model.setCurrentTemp()}°C',
                  textAlign: TextAlign.center,
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 90,
                    color: AppColors.darkBlueColor,
                  ),
                ),

                const SizedBox(height: 18),

                const MaxMinTemp(),

                const SizedBox(height: 40),

                const SevenDaysWeatherWidget(),

                const SizedBox(height: 28),

                const SizedBox(
                  height: 380,
                  child: WeatherInfoItems(),
                ),

                const SizedBox(height: 28),

                const SunRiseSunSetWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}