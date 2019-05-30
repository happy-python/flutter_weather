import 'package:flutter/material.dart';
import '../model/city.dart';
import 'weather.dart';

class CityWidget extends StatefulWidget {
  @override
  _CityWidgetState createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  List<City> cities = [];

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    var data = await City.fetchData();
    setState(() {
      cities = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: cities.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(cities[index].name),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherWidget(
                            cityName: cities[index].name,
                          )));
            },
          );
        },
      ),
    );
  }
}
