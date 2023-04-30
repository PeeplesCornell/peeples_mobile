import 'package:flutter/material.dart';
import 'package:peeples/models/FriendModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/time_helper.dart';

class FriendCard extends StatelessWidget {
  // final FriendModel friend;
  // const FriendCard({Key? key, required this.friend}) : super(key: key);
  const FriendCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var merchant_row = Row(
      children: [
        CircleAvatar(
            radius: 46, child: Image.asset('assets/home/merchavatar.png')),
        const Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Merchant Name',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                RatingBarIndicator(
                  rating: 4.5,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 18.0,
                ),
              ],
            ),
            const Text('Location', style: TextStyle(fontSize: 15)),
          ],
        )
      ],
    );

    var card_content = Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(33, 10, 0, 20),
            child: Image.asset(
              "assets/home/merchimg.png",
              height: 168,
              width: 118,
            )),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(4.92, 0, 8.74, 0),
                child: Image.asset("assets/home/review_icon.png")),
            const Text(
                "I really enjoyed the taste of the soft cream, as it really captured the hints of mango, just like in the photo. I would recommend making it a bit less sweet ...view more",
                style: TextStyle(fontSize: 15)),
          ],
        )
      ],
    );

    var card_container = SizedBox(
      height: 231,
      child: Container(
          // margin: const EdgeInsets.only(left: 14),
          decoration: const BoxDecoration(
              border: Border(
            left: BorderSide(width: 1, color: Color(0x4D000000)),
          )),
          child: Align(alignment: Alignment.centerLeft, child: card_content)),
    );

    var friend_row = Row(
      children: [
        CircleAvatar(radius: 32, child: Image.asset('assets/home/friend.png')),
        const Padding(
          padding: EdgeInsets.fromLTRB(17, 0, 9, 0),
          child: Text('Jasamin Kim',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        const Text('300+',
            style: TextStyle(fontSize: 15, color: Color(0xFF3B9244))),
        const Text('points', style: TextStyle(fontSize: 15)),
      ],
    );

    var activity_card = Column(
      children: [
        merchant_row,
        card_container,
        friend_row,
      ],
    );

    return Padding(
        padding: const EdgeInsets.fromLTRB(17, 35, 36, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Text(TimeHelper.calculateTime(history.time),
          //     style: const TextStyle(fontSize: 15)),
          activity_card,
        ]));
  }
}
