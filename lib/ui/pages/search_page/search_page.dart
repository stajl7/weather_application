import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/ui/ui_theme/app_colors.dart';
import 'package:weather_application/ui/ui_theme/app_style.dart';
import '../../../domain/provider/weather_provider.dart';
import '../../components/curren_region_item/curren_regoin_item.dart';
import '../../components/favorite_list/favorite_list.dart';
import '../../components/search_page_appbar/search_page_appbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WeatherSearchBody(),
    );
  }
}


class WeatherSearchBody extends StatelessWidget {
  const WeatherSearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            model.setBg(),
          ),
          fit:BoxFit.cover,
        ),
      ),
          child: Column(children: [
            const SearchPageAppBar(),
            const SizedBox(height: 15,),
            const CurrenRegionItem(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 16),
                child: Text('Избранное', 
                style: AppStyle.fontStyle.copyWith(
                  fontSize:16, 
                  fontWeight: FontWeight.w700, 
                  color: AppColors.blackColor
                  ),
                ),
              ),
            ),
            const FavoriteList(),
          ],
          ),
    );
  }
}