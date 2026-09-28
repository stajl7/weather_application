import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/domain/provider/weather_provider.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          model.getIcon(), 
          scale: 1.1, 
          width: 50,),
        const SizedBox(width: 25,),
        Text(
          model.getCurrentStatus(), 
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.darkBlueColor),
        ),
      ],
    );
  }
}