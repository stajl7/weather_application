import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/domain/api/api.dart';
import 'package:weather_application/domain/hive/favorite_history.dart';
import 'package:weather_application/domain/hive/hive_boxes.dart';
import 'package:weather_application/domain/json_convertors/coord.dart';
import '../json_convertors/weather_data.dart';
import 'package:weather_application/ui/constants/constants.dart';

import '../../ui/resources/app_bg.dart';
import '../../ui/ui_theme/app_colors.dart';



class WeatherProvider extends ChangeNotifier {
  //Хранение координатов
  static Coord? _coords;

  Coord? get coords => _coords;
  
  //Хранение данных о погоде
  
  WeatherData? weatherData;
  
  //хранение текущие данных о погоде
  Current? current;
  
  //контроллер ввода
  TextEditingController searchController = TextEditingController();
  
  /* Главная функция, которую мы запустим в FutureBuiler */
   Future<WeatherData?> setUp({String? cityName}) async{
   
    final pref = await SharedPreferences.getInstance();
    
    cityName = pref.getString('city_name');
    
    
    _coords = await Api.getCoords(cityName: cityName ?? 'Ташкент');
    weatherData = await Api.getWeather(coords);
    current = weatherData?.current;
    setSevenDays();

    return weatherData;
   }
   
   /* текущее время */
   
   String? currentTime;
   
   
   String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000); //обрабатываем  
    
    currentTime = DateFormat('HH.mm a').format(setTime);

    
    return currentTime ?? 'Error';
   }
   
   /*текущий статус погоды */
   
   String currentStatus = 'Ошибка';
   String getCurrentStatus() {
    currentStatus = current?.weather?[0].description ?? 'Ошиибка';
    return capitalize(currentStatus);
   }
   
   /* получение текущей иконки в зависимости от погоды */
   
   String getIcon() {
    return '${Constants.weatherIconUrl}${current?.weather?[0].icon}.png';
   }
   
   
   /* метод превращения первой буквы в Заглавную, а остальные в строчные */
   String capitalize(String str) => str[0].toUpperCase() + str.substring(1);
   
   
   /* Изменение заднего фона*/
   String? currentBg;
   
   String setBg() {
    int id = current?.weather?[0].id ?? -1;
    if(id == -1 || current?.sunset == null || current?.sunrise == null || current?.dt == null){
      currentBg = AppBg.shinyDay;
    }
    
    try {
      if(current?.sunset <current?.dt) {
        if(id >= 200 && id <= 531) {
          AppColors.sevenDayColor = const Color.fromRGBO(35, 35, 35, 0.5);
          AppColors.blueColor = const Color(0xFFFFFFFF);
          AppColors.darkBlueColor = const Color(0xFFFFFFFF);
          AppColors.iconColor = const Color(0xFFFFFFFF);
          AppColors.blackColor = const Color(0xFFFFFFFF);
          
          currentBg = AppBg.rainyNight;
          
        }else if( id >= 600 && id <= 622){
          AppColors.sevenDayColor = const Color.fromRGBO(12, 23, 27, 0.5);
          
          currentBg = AppBg.snowNight;
          
          AppColors.darkBlueColor = const Color(0xFFFFFFFF);
          AppColors.blackColor = const Color(0xFFFFFFFF);
        }else if (id >= 700 && id <= 781){
          AppColors.sevenDayColor = const Color.fromRGBO(35, 35, 35, 0.5);
          
          currentBg = AppBg.fogNight;
          
          AppColors.darkBlueColor = const Color(0xFFFFFFFF);
          AppColors.blackColor = const Color(0xFFFFFFFF);
        }else if(id == 800){
          AppColors.sevenDayColor = const Color.fromRGBO(47, 97, 148, 0.5);
          
          currentBg = AppBg.shinyNight;
          
        }else if(id >= 801 && id <= 804) {
          AppColors.sevenDayColor = const Color.fromRGBO(12, 23, 27, 0.5);
          AppColors.blackColor = const Color(0xFFFFFFFF);
          AppColors.sunItemTectColor = const Color(0xFF999999);
          currentBg = AppBg.cloudyNight;
        }
      }else{
        if(id >= 200 && id <= 531) {
          AppColors.sevenDayColor = const Color.fromRGBO(106, 141, 135, 0.5);
          currentBg = AppBg.rainyDay;
        }else if( id >= 600 && id <= 622){
          AppColors.sevenDayColor = const Color.fromRGBO(109, 160, 192, 0.5);
           currentBg = AppBg.snowDay;
        }else if (id >= 700 && id <= 781){
          AppColors.sevenDayColor = const Color.fromRGBO(142, 141, 141, 0.5);
          currentBg = AppBg.fogDay;
        }else if(id == 800){
          AppColors.sevenDayColor = const Color.fromRGBO(80, 130, 155, 0.3);
          // AppColors.blackColor = const Color(0xFFFFFFFF);
          AppColors.sunItemTectColor = const Color(0xFF999999);
          currentBg = AppBg.shinyDay;
        }else if(id >= 801 && id <= 804) {
          AppColors.sevenDayColor = const Color.fromRGBO(140, 155, 170, 0.5);
          currentBg = AppBg.cloudyDay;
          AppColors.blackColor = const Color(0xFFFFFFFF);
          AppColors.sunItemTectColor = const Color(0xFF999999);
        }
      }
      
    } catch(e) {
      return AppBg.shinyDay;
    }
    
    return currentBg ?? AppBg.shinyDay;
   }
   
   
   // установка текущей погоды

    int kelvin = -273;

    int currentTemp = 0;

//обработка текущей температуры
   
   int setCurrentTemp() {
    currentTemp = ((current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
   }
   
   
   
   
   
   // установка максимальной температуры
   
   int maxTemp = 0;
   
   String setMaxTemp() {
    maxTemp = ((weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin).round();
    return maxTemp.toString();
   }
   //установка минимальной температуры
   
   int minTemp = 0;
   
   String setMinTemp() {
    minTemp = ((weatherData?.daily?[0].temp?.min ?? - kelvin) +kelvin).round();
    return minTemp.toString();
   }
   
   
   
   //установка дней недели
   
   final List<String> _date = [];
   List<String> get date => _date;
   
   
   List<Daily> _daily = [];
   List<Daily> get daily => _daily;
   
   void  setSevenDays() {
    _daily = weatherData!.daily!;
    
    for(var i = 0; i < _daily.length; i++) {
      if(i == 0 && _daily.isNotEmpty) {
        _date.clear();
      }
      
      if(i == 0) {
        date.add('Сегодня');
        
      }else {
        var timeNum = _daily[i].dt * 1000;
        var itemDate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        _date.add(capitalize(DateFormat('EEEE', 'ru' ).format(itemDate),),);
      }
    }
   }
   
   
   // получение иконок для каждого дня в зависимости от погоды
   
   final String _iconUrPath = 'http://openweathermap.org/img/wn/';
   
   
   String setDailyIcons(int index) {
    final String getIcon = '${weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_iconUrPath$getIcon.png';
    return setIcon;
   }
   
   //получение дневной температуры на каждый день 
   
   int dailyTemp = 0;
   int setDailyTemp(int index) {
    dailyTemp = ((weatherData?.daily?[index].temp?.morn ?? -kelvin) + kelvin).round();
    return dailyTemp;
   }
   
   //получние дневной температуры
   
   int nightTemp = 0;
   int setNightTemp(int index) {
    nightTemp = ((weatherData?.daily?[index].temp?.night ?? -kelvin) + kelvin).round();
    return nightTemp;
   }
   
   //Добавление в массив данных о погодных условиях 
   
   
   final List<dynamic> weatherValues = [];
   
   dynamic setValues(int index) {
      weatherValues.add(current?.windSpeed ?? 0);
      weatherValues.add(((current?.feelsLike ?? - kelvin) +kelvin).roundToDouble());
      weatherValues.add((current?.humidity ?? 0) /1);
      weatherValues.add((current?.visibility ?? 0) / 1000);
      return weatherValues[index];
    }
    
    //текущее время восхода
    
    String sunRise = '';
    
    String setCurrentSunRise() {
      final getSunTime = (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
      final setRunSise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
      sunRise = DateFormat('HH:mm a').format(setRunSise);
      return sunRise;
    }
    
    
    
    // Установка текущего города
    
    void setCurrentCity(BuildContext context, {String? cityName}) async{
      if(searchController.text != null && searchController.text != ''){
        cityName = searchController.text;
        
        final pref = await SharedPreferences.getInstance();
        await pref.setString('city_name', cityName);
        await setUp(cityName: pref.getString('key')).then((value) => Navigator.pop(context)).then((value) => searchController.clear());
        notifyListeners();
      }
    }
    
    
    
    //текущее время заката
        String sunSet = '';
    
    String setCurrentSunRet() {
      final getSetTime = (current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);
      final setRunSise = DateTime.fromMillisecondsSinceEpoch(getSetTime * 1000);
      sunSet = DateFormat('HH:mm a').format(setRunSise);
      return sunSet;
    }
    
    
    //Добавления в избранное 
    
    Future<void> setFavorite(BuildContext context, {String? cityName}) async{
      var box = Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox);
      
      box.add(
        FavoriteHistory(
          weatherData?.timezone?? 'Error', 
          currentBg ?? AppBg.shinyDay, 
          AppColors.darkBlueColor.value),
      ).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Город $cityName Добавляем в избранное'),),
      ),);
    
    
    }
    
    
    
    //Удаление из избранного
    
    Future<void> deleteFavorite(int index)  async{
      var box = Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox);
      box.deleteAt(index);
    }
    
    
    
   
}
