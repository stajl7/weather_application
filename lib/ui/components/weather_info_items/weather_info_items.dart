import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/domain/provider/weather_provider.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';

class WeatherInfoItems extends StatelessWidget {
  const WeatherInfoItems({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
      itemBuilder: (context, index) {
        return SizedBox(
          width: 181,
          height: 181,
          child: Card(
            color: AppColors.sevenDayColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              leading: SvgPicture.asset(
                WeatherInfoIcons.weatherInfoIcons[index],
                color: AppColors.blackColor,
              ),
              title: Text(
                '${model.setValues(index)}${WeatherInfoUnits.weatherInfoUnits[index]}',
                style: AppStyle.fontStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 16,),
              ),
              subtitle: Text(WeatherInfoDescription.weatherInfoDescription[index],
              style: AppStyle.fontStyle.copyWith(fontSize: 10, color: AppColors.blackColor)),
            ),
            
          ),
        );
      },
    );
  }
}

class WeatherInfoIcons {
  static List<String> weatherInfoIcons = [
    'assets/icons/wind_speed.svg',
    'assets/icons/feels_like.svg',
    'assets/icons/raindrops.svg',
    'assets/icons/visibility.svg',
  ];
}

class WeatherInfoDescription {
  static List<String> weatherInfoDescription = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];
}

class WeatherInfoUnits {
  static List<String> weatherInfoUnits = [
    'км/ч',
    '°',
    '%',
    'км',
  ];
}

class ClassName {}
