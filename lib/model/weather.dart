import 'package:dio/dio.dart';
import 'dart:async';
import '../conf/dafault.dart';

class Weather {
  final String cond;
  final String tmp;
  final String hum;

  Weather({this.cond, this.tmp, this.hum});

  factory Weather.init() {
    return Weather(cond: '', tmp: '', hum: '');
  }

  static Weather _fromJson(Map<String, dynamic> json) {
    var data = json['HeWeather6'][0]['now'];
    return Weather(
        cond: data['cond_txt'],
        tmp: data['tmp'] + '°',
        hum: '湿度 ' + data['hum'] + '%');
  }

  static Future<Weather> fetchData(String location) async {
    try {
      Response<Map<String, dynamic>> response = await Dio().get(
          'https://free-api.heweather.com/s6/weather/now?location=$location&key=$key');

      return _fromJson(response.data);
    } catch (e) {
      print(e);
      return Weather.init();
    }
  }
}
