import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:weather_application/domain/provider/weather_provider.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';

class SunRiseSunSetWidget extends StatelessWidget {
  const SunRiseSunSetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.sevenDayColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RowItemWidget(
            icon: 'assets/icons/sunrise_icon.svg',
            text: 'Восход ${model.setCurrentSunRise()}',
          ),
          RowItemWidget(
            icon: 'assets/icons/sunset_icon.svg',
            text: 'Закат ${model.setCurrentSunRet()}',
          ),
        ],
      ),
    );
  }
}

class RowItemWidget extends StatelessWidget {
  const RowItemWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            AppColors.iconColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.sunItemTectColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}