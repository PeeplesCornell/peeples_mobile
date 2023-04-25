import 'package:flutter/material.dart';

class QuestionnaireHeader extends StatelessWidget {
  final String? headerImage;
  final String? profileImage;
  const QuestionnaireHeader({this.headerImage, this.profileImage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/home/main.jpg',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 150,
              ),
              const Positioned(
                  bottom: -24,
                  left: 20,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*r_3WfxcZiSTE9EYjLwMzYg.jpeg"),
                  )),
              const Positioned(
                  bottom: -65,
                  left: 20,
                  child: Text(
                    "Levain Bakery on 3rd Ave",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
