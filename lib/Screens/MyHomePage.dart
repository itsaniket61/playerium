import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Components/BottomNavBar.dart';
import 'package:player_que/Components/BottomPlayer.dart';
import 'package:player_que/Controllers/BottomNavController.dart';
import 'package:player_que/Controllers/PlayerScreenController.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  BottomNavController navController = Get.put(BottomNavController());
  PlayerScreenController playerScreenController =
      Get.put(PlayerScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            children: [Icon(Icons.music_note), Text("Playerium")],
          ),
        ),
        body: navController.widgets.value[navController.currIndex.value],
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
