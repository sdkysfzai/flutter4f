import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = 'no';
  String cityName = 'Iasi';
  String weatherMessage = 'All good';
  int tempmin = 0;
  int tempmax = 0;
  String weatherMin = 'min';
  String weatherMax = 'max';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        tempmin = 0;
        tempmax = 0;
        weatherMin = 'Unable to get weather data';
        weatherMax = 'Unable to get weather data';
        return;
      }
      double temp = weatherData['main']['temp'];
      double temp1 = weatherData['main']['temp_min'];
      double temp2 = weatherData['main']['temp_max'];
      temperature = temp.toInt();
      tempmin = temp1.toInt();
      tempmax = temp2.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      weatherMin = weather.getMessage(tempmin);
      weatherMax = weather.getMessage(tempmax);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/img/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                      print(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: TextStyle(
                        // fontFamily: 'Spartan MB',
                        fontSize: 100.0,
                      ),
                    ),
                    Text(
                      weatherIcon,
                      style: TextStyle(
                        fontSize: 100.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                                    SizedBox(width: 5,),

                  Container(
                    child: Text(
                      
                      'Min: $tempmin°',
                       style: TextStyle(
                        // fontFamily: 'Spartan MB',
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Max: $tempmax°',
                       style: TextStyle(
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                                    SizedBox(width: 5,),

                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    // fontFamily: 'Spartan MB',
                    fontSize: 60.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
