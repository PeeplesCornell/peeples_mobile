import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/home/main.jpg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: 248,
        ),
        const Positioned(
          top: 150,
          child: Text(
            'Explore Midtown South',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: MediaQuery.of(context).padding.left,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 18),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )),
      ],
    );
  }
}
