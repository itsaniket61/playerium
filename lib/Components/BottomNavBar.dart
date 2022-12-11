import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:player_que/Components/BottomPlayer.dart';
import 'package:player_que/Controllers/BottomNavController.dart';
import 'package:player_que/Controllers/PlayerController.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  BottomNavController navController = Get.put(BottomNavController());
  PlayerController playerController = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 6.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BottomAppBar(
            child: BottomPlayer(),
          ),
          Divider(
            color: Colors.white,
            height: 2,
          ),
          BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: navController.currIndex.value,
              onTap: (i) {
                if (i < navController.widgets.length) {
                  navController.currIndex.value = i;
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
              ]),
        ],
      ),
    );
  }
}
