import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Components/AudioProgressIndicator.dart';
import 'package:player_que/Components/BottomPlayer.dart';
import 'package:player_que/Components/MyAdBanner.dart';
import 'package:player_que/Components/PlaylistArea.dart';
import 'package:player_que/Controllers/PlayerController.dart';
import 'package:player_que/Controllers/PlaylistAreaController.dart';

class PlayerScreen extends StatelessWidget {
  PlayerScreen({super.key});
  PlayerController playerController = Get.put(PlayerController());
  PlaylistAreaController playlistAreaController =
      Get.put(PlaylistAreaController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Obx(() {
      return Container(
        width: double.infinity,
        color: playerController.bgColor.value,
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => playlistAreaController.isExpanded.isFalse
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.music_note,
                              size: 30,
                            ),
                            Text(
                              "Playerium",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  : SizedBox()),
              Obx(() {
                return playlistAreaController.isExpanded.isTrue
                    ? BottomPlayer()
                    : StreamBuilder<int?>(
                        stream:
                            playerController.player.value.currentIndexStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              SizedBox(
                                child: Image.network(
                                  playerController
                                          .playlistdata[snapshot.data ?? 0]
                                      ['cover'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  playerController
                                          .playlistdata[snapshot.data ?? 0]
                                      ['title'],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        });
              }),
              AudioProgressIndicator(),
              Obx(() {
                return playlistAreaController.isExpanded.isFalse
                    ? StreamBuilder(
                        stream: playerController.player.value.playingStream,
                        builder: (context, snapshot) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                playerController.player.value.hasPrevious
                                    ? IconButton(
                                        iconSize: 55,
                                        onPressed: () {
                                          playerController.playPrevious();
                                        },
                                        icon: Icon(Icons.skip_previous))
                                    : const SizedBox(),
                                IconButton(
                                    iconSize: 75,
                                    onPressed: () {
                                      if (snapshot.data ?? true) {
                                        playerController.player.value.pause();
                                      } else {
                                        playerController.player.value.play();
                                      }
                                    },
                                    icon: Icon(
                                      snapshot.data ?? true
                                          ? Icons.pause_circle_filled
                                          : Icons.play_circle_fill,
                                    )),
                                playerController.player.value.hasNext
                                    ? IconButton(
                                        iconSize: 55,
                                        onPressed: () {
                                          playerController.playNext();
                                        },
                                        icon: Icon(Icons.skip_next))
                                    : const SizedBox(),
                              ],
                            ),
                          );
                        })
                    : Center();
              }),
              SizedBox(height: 10),
              PlayListArea(),
            ],
          ),
        ),
      );
    })));
  }
}
