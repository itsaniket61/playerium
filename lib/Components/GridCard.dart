import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player_que/Controllers/PlayerController.dart';

class GridCard extends StatelessWidget {
  final cardImage, cardTitle, cardId;
  GridCard({this.cardTitle, this.cardImage, this.cardId});
  PlayerController pController = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await pController.clearPlaylist();
        await pController.play(this.cardId);
        await pController.addRelatedQueue(this.cardId);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              Container(
                child: Image.network(
                  this.cardImage,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/dummy-cover.png',
                        width: MediaQuery.of(context).size.width / 2.5);
                  },
                ),
              ),
              Text(
                this.cardTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          )),
    );
  }
}
