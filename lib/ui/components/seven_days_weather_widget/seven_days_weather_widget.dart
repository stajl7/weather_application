import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/domain/provider/weather_provider.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';

class SevenDaysWeatherWidget extends StatelessWidget {
  const SevenDaysWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
      color: AppColors.sevenDayColor,
      ),
      height: 350,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: ((context, index) {
        return SevenDaysWidget(
          text: model.date[index],
          daylyIcon: model.setDailyIcons(index),
          dayTemp: model.setDailyTemp(index),
          nightTemp: model.setNightTemp(index),
        );
      }), separatorBuilder: (context, index) => const SizedBox(height: 16), itemCount: model.date.length),
    );
  }
}

class SevenDaysWidget extends StatelessWidget {
  const SevenDaysWidget({super.key, 
  required this.text, 
  required this.daylyIcon, 
  this.dayTemp = 0, 
  this.nightTemp = 0
  });
  
  final String text, daylyIcon;
  final int dayTemp, nightTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 130,
          child: Text( text, style: AppStyle.fontStyle.copyWith(color: AppColors.blackColor),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Image.network(daylyIcon, width: 30, height: 30, color: Colors.white),
        const SizedBox(
          width: 20,
        ),
        Text('$dayTemp °C', style: AppStyle.fontStyle,),
        const SizedBox(
          width: 20,
        ),
        Text('$nightTemp °C', style: AppStyle.fontStyle.copyWith(color: AppColors.nightTempColor),
        ),
        
      ],
    );
  }
}