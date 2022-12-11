import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:player_que/Controllers/PlayerController.dart';
import 'package:player_que/Controllers/PlayerScreenController.dart';
import 'package:player_que/Screens/PlayerScreen.dart';

class BottomPlayer extends StatelessWidget {
  BottomPlayer({super.key});
  PlayerController playerController = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => playerController.playlistdata.isEmpty
        ? SizedBox()
        : GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlayerScreen()));
            },
            child: Container(
              color: playerController.bgColor.value,
              child: StreamBuilder<int?>(
                  stream: playerController.player.value.currentIndexStream,
                  builder: (context, snapshot) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width * .28,
                          child: Image.network(playerController
                              .playlistdata[snapshot.data ?? 0]['cover']),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .35,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playerController
                                    .playlistdata[snapshot.data ?? 0]['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                playerController
                                    .playlistdata[snapshot.data ?? 0]['author'],
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        StreamBuilder<bool>(
                            stream: playerController.player.value.playingStream,
                            builder: (context, snapshot) {
                              return Row(
                                children: [
                                  playerController.player.value.hasPrevious
                                      ? IconButton(
                                          onPressed: () {
                                            playerController.playPrevious();
                                          },
                                          icon: Icon(Icons.skip_previous,
                                              size: 30))
                                      : const SizedBox(),
                                  IconButton(
                                      onPressed: () {
                                        if (snapshot.data ?? true) {
                                          playerController.player.value.pause();
                                        } else {
                                          playerController.player.value.play();
                                        }
                                      },
                                      icon: Icon(
                                          snapshot.data ?? true
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 30)),
                                  playerController.player.value.hasNext
                                      ? IconButton(
                                          onPressed: () {
                                            playerController.playNext();
                                          },
                                          icon: Icon(Icons.skip_next, size: 30))
                                      : const SizedBox(),
                                ],
                              );
                            }),
                      ],
                    );
                  }),
            )));
  }
}
