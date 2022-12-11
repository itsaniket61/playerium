import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Components/MyAdBanner.dart';
import 'package:player_que/Controllers/PlayerController.dart';
import 'package:player_que/Controllers/PlaylistAreaController.dart';

class PlayListArea extends StatelessWidget {
  PlayListArea({super.key});
  PlaylistAreaController playlistAreaController =
      Get.put(PlaylistAreaController());
  PlayerController playerController = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Upcoming",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: playlistAreaController.expand,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Obx(() {
                  return Text(
                    playlistAreaController.isExpanded.isFalse
                        ? "Expand"
                        : "Collaps",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                })),
              ),
            )
          ],
        ),
        Obx(() {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: playlistAreaController.isExpanded.isTrue
                ? MediaQuery.of(context).size.height / 1.5
                : 0,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<int?>(
                stream: playerController.player.value.currentIndexStream,
                builder: (context, snapshot) {
                  return Obx(() => ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: playerController.playlistdata.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            if (playerController.player.value.currentIndex ==
                                i) {
                              if (playerController.player.value.playing) {
                                playerController.player.value.pause();
                              } else {
                                playerController.player.value.play();
                              }
                              return;
                            }
                            playerController.player.value.seek(
                              Duration(seconds: 0),
                              index: i,
                            );
                            if (playerController.playlist.length != i + 5) {
                              playerController.addRelatedQueue(
                                  playerController.playlistdata[i]['vid']);
                            }
                          },
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.network(
                                    playerController.playlistdata[i]['cover']),
                                title: Text(
                                  playerController.playlistdata[i]['title'],
                                ),
                                trailing: snapshot.data == i
                                    ? Icon(Icons.multitrack_audio)
                                    : Icon(Icons.play_arrow_outlined),
                              ),
                              i % 4 == 0
                                  ? MyAddBanner()
                                  : SizedBox(height: 5)
                            ],
                          ),
                        );
                      }));
                }),
          );
        })
      ],
    );
  }
}
