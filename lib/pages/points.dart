import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  const Points({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
      ),
      body: const Center(
        child: Text('Points'),
      ),
    );
  }
}
