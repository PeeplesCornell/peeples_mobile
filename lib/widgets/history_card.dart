import 'package:flutter/material.dart';
import '../models/HistoryModel.dart';
import '../utils/time_helper.dart';

class HistoryCard extends StatelessWidget {
  final HistoryModel history;
  const HistoryCard({Key? key, required this.history}) : super(key: key);
  //const HistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var type = history.type;
    var points = history.points;
    var cardText = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(history.merchantName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Type: $type', style: const TextStyle(fontSize: 15)),
            Row(children: [
              const Text('Points: ', style: TextStyle(fontSize: 15)),
              Text(points,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ]),
          ])
        ]);

    var cardContent = Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            history.merchantImg,
            height: 148,
            width: 148,
          ),
          SizedBox(
            width: 244,
            height: 148,
            child: Container(
                margin: const EdgeInsets.only(left: 14),
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Color(0x4D000000)),
                  bottom: BorderSide(width: 1, color: Color(0x4D000000)),
                )),
                child: Align(alignment: Alignment.centerLeft, child: cardText)),
          )
        ],
      ),
    );

    return Padding(
        padding: const EdgeInsets.fromLTRB(18, 19, 18, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(TimeHelper.calculateTime(history.time),
              style: const TextStyle(fontSize: 15)),
          cardContent,
        ]));
  }
}
