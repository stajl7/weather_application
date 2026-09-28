import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/domain/hive/favorite_history.dart';
import 'package:weather_application/domain/hive/hive_boxes.dart';
import 'package:weather_application/domain/provider/weather_provider.dart';
import 'package:weather_application/ui/resources/app_bg.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<Box<FavoriteHistory>>(
        valueListenable: Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox).listenable(),
        
        builder: (context, value, _){
          
          return ListView.separated(
          padding: const EdgeInsets.only(left: 16, right: 16,top: 16),
          itemCount: value.length,
          separatorBuilder: (context, i ) => const SizedBox(height: 10),
          itemBuilder: (context, i){
            return  FavoriteCard(
              index: i,
              value: value,
            );
          },
        );
        }
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({Key? key, required this.index, required this.value}) : super(key: key);

  final int index;
  final Box<FavoriteHistory> value;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(value.getAt(index)?.bg ?? AppBg.shinyNight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrentFavoriteItems(
            index: index,
            value: value,
          ),
          IconButton(onPressed: () {
            model.deleteFavorite(index);
          }, 
          icon: Icon(Icons.delete, 
          color: AppColors.redColor),
          ),
      ]),
    );
  }
}

class CurrentFavoriteItems extends StatelessWidget {
  const CurrentFavoriteItems({Key? key, required this.index, required this.value}) : super(key: key);

  final int index;
  final Box<FavoriteHistory> value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Текущее место', 
        style: AppStyle.fontStyle.copyWith(
          color: AppColors.blackColor,
          fontSize: 18,
        ),
        ),
        const SizedBox(height: 6,),
        Text(
          value.getAt(index)?.cityName ??'Error', 
        style: AppStyle.fontStyle.copyWith(
          color: AppColors.blackColor, 
          fontSize: 18, 
          fontWeight: FontWeight.w700,),
        ),
        const SizedBox(height: 4,),
        Text(value.getAt(index)?.cityName ??'Error', 
        style: AppStyle.fontStyle.copyWith(
          color: AppColors.blackColor, 
          fontSize: 12, 
          fontWeight: FontWeight.w700,),
        ),
      ],
    );
  }
}