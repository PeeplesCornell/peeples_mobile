import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final sub_menu = {
    'History': '/history',
    'Friends': '/friends',
    'Points': '/points',
    'Settings': '/settings',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          children: sub_menu.entries
              .map((e) => ListTile(
                    title: Text(e.key),
                    onTap: () {
                      Navigator.pushNamed(context, e.value);
                    },
                  ))
              .toList(),
        )),
        appBar: null,
        body: FutureBuilder(
          future: ref.read(firebaseProvider.notifier).setup(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Expanded(
                      child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 248,
                        floating: true,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Header(),
                          expandedTitleScale: 1.3,
                        ),
                      ),
                      PostListViewState(),
                    ],
                  ))
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
