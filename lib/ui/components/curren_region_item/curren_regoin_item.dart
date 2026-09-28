import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';
import '../../../domain/provider/weather_provider.dart';

class CurrenRegionItem extends StatelessWidget {
  const CurrenRegionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 382,

        // Вместо фиксированного height: 96
        constraints: const BoxConstraints(
          minHeight: 96,
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(model.setBg()),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CurrentTimeZone(
                currentCity: model.weatherData?.timezone,
                currentZone: model.weatherData?.timezone,
              ),
            ),
            CurrentTemp(
              icon: model.getIcon(),
              currentTemp: model.setCurrentTemp(),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentTimeZone extends StatelessWidget {
  const CurrentTimeZone({
    super.key,
    required this.currentCity,
    required this.currentZone,
  });

  final String? currentCity;
  final String? currentZone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Текущее место',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            color: AppColors.blackColor,
          ),
        ),
        Text(
          currentZone ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          currentCity ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class CurrentTemp extends StatelessWidget {
  const CurrentTemp({
    super.key,
    required this.icon,
    required this.currentTemp,
  });

  final String icon;
  final int currentTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          icon,
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 4),
        Text(
          '$currentTemp C°',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}