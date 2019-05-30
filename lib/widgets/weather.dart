import 'package:flutter/material.dart';
import '../model/weather.dart';

class WeatherWidget extends StatefulWidget {
  final String cityName;

  WeatherWidget({@required this.cityName});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Weather weather = Weather.init();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    var data = await Weather.fetchData(widget.cityName);
    setState(() {
      weather = data;
      Future.delayed(Duration(milliseconds: 500)).then((onValue) {
        setState(() {
          loading = false;
        });
      });
    });
  }

  // 判断当前显示什么组件
  Widget currentShow() {
    return loading
        ? CircularProgressIndicator(
            strokeWidth: 2.0,
          )
        : Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      weather.tmp,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 80.0,
                      ),
                    ),
                    Text(
                      weather.cond,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                      ),
                    ),
                    Text(
                      weather.hum,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
          ),
          top: 0.0,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.cityName),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: currentShow(),
          ),
        ),
      ],
    );
  }
}
