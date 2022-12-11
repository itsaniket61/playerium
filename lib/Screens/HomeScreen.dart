import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Components/ItemsRow.dart';
import 'package:player_que/Components/MyAdBanner.dart';
import 'package:player_que/Controllers/HomeScreenController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeScreenController.data.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : homeScreenController.data[0] == 'xx'
            ? Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/no-internet.png'),
                    ElevatedButton(
                      onPressed: () {
                        homeScreenController.getSections();
                      },
                      child: Text("Retry"),
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () => homeScreenController.getSections(),
                child: ListView.builder(
                    itemCount: homeScreenController.data.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          ItemsRow(
                            title: homeScreenController.data[i]['title'],
                            list: homeScreenController.data[i]['videos'],
                          ),
                          MyAddBanner(),
                        ],
                      );
                    }),
              ));
  }
}
