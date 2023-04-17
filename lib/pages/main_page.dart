import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/widgets/google_sign_btn.dart';
import 'package:peeples/widgets/post_card.dart';
import 'package:peeples/widgets/post_scroll.dart';

import '../utils/authentication.dart';
import '../widgets/header.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Building HomePage");
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          children: [
            ListTile(
              title: const Text("History"),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              title: const Text('Friends'),
              onTap: () {
                Navigator.pushNamed(context, '/friends');
              },
            ),
            ListTile(
              title: const Text('Points'),
              onTap: () {
                Navigator.pushNamed(context, '/points');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        )),
        appBar: null,
        body: FutureBuilder(
          future: ref.read(firebaseProvider.notifier).setup(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Flex(
                direction: Axis.vertical,
                children: [
                  const Header(),
                  Expanded(
                    child: PostListViewState(),
                  )
                ],
              );
            } else {
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Colors.deepPurple,
                ),
              );
            }
          },
        ));
  }
}
