// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:loginv1/controllers/controllers.dart';
import 'package:loginv1/services/weather.dart';

import 'package:loginv1/ui/pages/fav.dart';
import 'package:loginv1/ui/pages/home.dart';
import 'package:loginv1/ui/pages/homeuser.dart';
import 'package:loginv1/ui/pages/location_screen.dart';
import 'package:loginv1/ui/pages/profile.dart';
import 'package:loginv1/ui/pages/chat.dart';
import 'package:loginv1/ui/pages/settings.dart';

import '/controllers/task_controller.dart';

import '../../constants/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Widget>> getScreens;

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  /// IMPORTANT don't use this directly in the FutureBuilder
  Future<List<Widget>> _getScreens() async {
    bool isAdmin = await Get.find<AuthController>().isAdmin();
    return [
      Home(isAdmin: isAdmin),
      ChatScreen(),
      Fav(),
      Settings(),
      HomeUI(),
    ];
  }

  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  final _taskController = Get.put(TaskController());
  late var notifyHelper;
  bool animate = false;
  double left = 630;
  double top = 900;
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    getScreens = _getScreens();

    _timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
        animate = true;
        left = 30;
        top = top / 3;
      });
    });
  }

  int _currentIndex = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.chat, size: 30),
      Icon(Icons.favorite, size: 30),
      Icon(Icons.settings, size: 30),
      Icon(Icons.person, size: 30),
    ];
    return FutureBuilder<List<Widget>>(
        future: getScreens,
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                debugPrintStack(stackTrace: snapshot.stackTrace);
                return Text('Error: ${snapshot.error}');
              }
              return Container(
                color: Colors.white,
                child: ClipRect(
                  child: SafeArea(
                      top: false,
                      child: Scaffold(
                        extendBody: true,
                        appBar: AppBar(
                            backgroundColor: secClr,
                            elevation: 0,
                            leading: GestureDetector(
                              onTap: () {
                                getLocationData();
                              },
                              child: Icon(
                                Icons.cloud,
                                color: darkGreyClr,
                              ),
                            ),
                            actions: [
                              Icon(
                                Icons.navigation_rounded,
                                color: darkGreyClr,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ]),
                        backgroundColor: secClr,
                        body: snapshot.data![_currentIndex],
                        bottomNavigationBar: CurvedNavigationBar(
                          key: navigationKey,
                          items: items,
                          color: Colors.white,
                          backgroundColor: Colors.transparent,
                          height: 60,
                          index: _currentIndex,
                          onTap: (index) =>
                              setState(() => this._currentIndex = index),
                        ),
                      )),
                ),
              );
          }
        });
  }
}
