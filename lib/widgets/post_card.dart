import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peeples/utils/time_helper.dart';

import '../models/Post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user_row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(post.userAvatar),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.userName, style: const TextStyle(fontSize: 16)),
                Text(post.location, style: const TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
        Text(TimeHelper.calculateTime(post.visitTime),
            style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );

    var merchant_row = Column(
      children: [
        Row(
          children: [
            Text(post.merchantName, style: const TextStyle(fontSize: 16)),
            const Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            RatingBarIndicator(
              rating: 2.75,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 18.0,
            ),
          ],
        ),
        Row(
          children: [
            Text(post.location, style: const TextStyle(fontSize: 12)),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "•",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const Text("4.5 mi",
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 98, 164, 67))),
          ],
        )
      ],
    );

    var post_content = Image.network(
      post.content,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: 248,
    );

    var userName = post.userName;
    var points = post.earnings;

    var earnings = Row(
      children: [
        Text("$userName earned $points+ points!",
            style: const TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );

    var interactions = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(children: [
              Image.asset(
                "assets/home/other.png",
                height: 20,
                width: 40,
              ),
              const Text("Others went to this place")
            ])),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: post.comments.map((e) => Text(e)).toList(),
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          user_row,
          const Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          merchant_row,
          const Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          post_content,
          const Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          earnings,
          const Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          interactions,
        ],
      ),
    );
  }
}
