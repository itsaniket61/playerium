import 'package:flutter/material.dart';
import 'package:player_que/Components/GridCard.dart';

class ItemsRow extends StatelessWidget {
  var title, list;
  ItemsRow({this.title, this.list});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              this.title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width / 2,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return GridCard(
                    cardId: list[i]['id'],
                    cardTitle: list[i]['title'],
                    cardImage: list[i]['thumbnail_url'],
                  );
                }),
          ),
        ],
      ),
    );
    ;
  }
}
