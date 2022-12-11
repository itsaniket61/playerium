import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Controllers/PlayerController.dart';

class AudioProgressIndicator extends StatelessWidget {
  AudioProgressIndicator({super.key});
  PlayerController playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: playerController.player.value.positionStream,
        builder: (context, snapshot) {
          playerController.getImagePalette();
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ProgressBar(
              onSeek: (v) {
                playerController.player.value.seek(v);
              },
              progress: snapshot.data ?? const Duration(seconds: 0),
              total: playerController.player.value.duration ??
                  const Duration(seconds: 1),
              barHeight: 3,
              buffered: playerController.player.value.bufferedPosition,
              baseBarColor: Colors.white12,
              bufferedBarColor: Colors.white30,
              progressBarColor: Colors.white,
              thumbColor: Colors.white,
              thumbRadius: 5,
              thumbGlowRadius: 10,
            ),
          );
        });
  }
}
