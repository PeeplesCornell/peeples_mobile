import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/pages/main_page.dart';
import 'package:peeples/widgets/history_scroll.dart';

import '../utils/authentication.dart';

class History extends ConsumerWidget {
  History({Key? key}) : super(key: key);

  var topBar = Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 0, 7),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Your History',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(112, 34),
              backgroundColor: const Color(0xFFF3F3F3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
            ),
            onPressed: () {},
            child: const Text('filter',
                style: TextStyle(fontSize: 15, color: Colors.black)))
      ]));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        scrolledUnderElevation: 0.0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        topBar,
        SizedBox(
          height: 670,
          child: AutomaticDispose(
              child: HistoryListViewState(),
              onDisposed: () =>
                  ref.read(firebaseProvider.notifier).resetPage()),
        )
      ]),
    );
  }
}
