import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';

import '../../../domain/provider/weather_provider.dart';

class SearchPageAppBar extends StatelessWidget {
  const SearchPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return SafeArea(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.blackColor, size: 26,),
            ),
            SizedBox(
              height: 35,
              width: 315,
              child: TextFormField(
                controller: model.searchController,
                cursorColor: AppColors.blackColor.withOpacity(0.5),
                decoration: InputDecoration(
                  hintText: 'Введите город/регион',
                  hintStyle: AppStyle.fontStyle.copyWith(
                    fontSize: 14, 
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  fillColor: AppColors.inputColor,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(onPressed: () {
              model.setCurrentCity(context);
            }, 
            icon: Icon(Icons.search, color: AppColors.blackColor, size: 24,),
            ),
          ],
        ),
      ),
    );
  }
}
