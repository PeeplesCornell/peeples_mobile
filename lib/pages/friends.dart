import 'package:flutter/material.dart';
import 'package:peeples/widgets/friend_card.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var topBar = Container(
        margin: const EdgeInsets.fromLTRB(18, 0, 0, 7),
        child: const Column(children: [
          Text('Friends Activity',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ]));

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        scrolledUnderElevation: 0.0,
      ),
      body: topBar,
      FriendCard(),
    );
  }
}
