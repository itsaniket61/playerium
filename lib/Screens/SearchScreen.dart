import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Components/MyAdBanner.dart';
import 'package:player_que/Controllers/BottomNavController.dart';
import 'package:player_que/Controllers/PlayerController.dart';
import 'package:player_que/Controllers/SearchScreenController.dart';
import 'package:player_que/Screens/PlayerScreen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());
  PlayerController playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (txt) {
                    searchScreenController.getSearch(txt);
                  },
                ),
              ),
              Obx(() => searchScreenController.searchedItems.isEmpty
                  ? SizedBox()
                  : Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: searchScreenController.searchedItems.value[0] ==
                              'xx'
                          ? Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/no-internet.png'),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  searchScreenController.searchedItems.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () async {
                                    Get.snackbar("Please wait...",
                                        "Track is Loading...");
                                    var cardId = searchScreenController
                                        .searchedItems.value[i]['vid'];
                                    await playerController.clearPlaylist();
                                    await playerController.play(cardId);
                                    Get.to(PlayerScreen());
                                    await playerController
                                        .addRelatedQueue(cardId);
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Container(
                                          child: Image.network(
                                              searchScreenController
                                                  .searchedItems
                                                  .value[i]['cover']),
                                        ),
                                        title: Text(searchScreenController
                                            .searchedItems.value[i]['title']),
                                      ),
                                      SizedBox(height: 10)
                                    ],
                                  ),
                                );
                              }),
                    )),
              SizedBox(height: 15),
              MyAddBanner()
            ],
          ),
        ),
      ],
    );
  }
}
