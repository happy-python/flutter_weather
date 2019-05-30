import 'dart:async';
import 'package:dio/dio.dart';
import '../conf/dafault.dart';

class City {
  final String name;

  City({this.name});

  static List<City> _fromJson(Map<String, dynamic> json) {
    List<City> cities = List<City>();
    var data = json['HeWeather6'][0]['basic'];
    for (var city in data) {
      cities.add(City(name: city['location']));
    }
    return cities;
  }

  static Future<List<City>> fetchData() async {
    try {
      Response<Map<String, dynamic>> response =
          await Dio().get('https://search.heweather.net/top?group=cn&key=$key');

      return _fromJson(response.data);
    } catch (e) {
      print(e);
      return List<City>();
    }
  }
}
