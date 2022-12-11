import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Screens/HomeScreen.dart';
import 'package:player_que/Screens/SearchScreen.dart';

class BottomNavController extends GetxController {
  var currIndex = 0.obs;
  var widgets = <Widget>[
    HomeScreen(),
    SearchScreen(),
  ].obs;
}
