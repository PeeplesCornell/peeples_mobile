import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NotificationPop extends StatelessWidget {
  final VoidCallback handleVisible;
  const NotificationPop({Key? key, required this.handleVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Go inside and earn points"),
            IconButton(
                onPressed: () {
                  handleVisible();
                },
                icon: Icon(Icons.close))
          ],
        ),
        Row(
          children: [
            const Text("Levain Bakery on 3rd Ave"),
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
        const Row(
          children: [
            Text("Get 300+ points"),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "•",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            Text("4.5 mi",
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 98, 164, 67)))
          ],
        ),
        Row(children: [
          Image.asset(
            "assets/home/map.png",
            height: 152,
            width: 249,
          ),
          Image.network(
            "https://images.unsplash.com/photo-1515182629504-727d7753751f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80",
            fit: BoxFit.cover,
            width: 152,
            height: 146,
          ),
        ]),
        Row(children: [
          Image.asset(
            "assets/home/other.png",
            height: 20,
            width: 40,
          ),
          const Text("Others went to this place")
        ]),
        Divider(),
      ],
    );
  }
}
