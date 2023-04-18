import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/widgets/google_sign_btn.dart';
import 'package:peeples/widgets/post_card.dart';
import 'package:peeples/widgets/post_scroll.dart';

import '../utils/authentication.dart';
import '../widgets/header.dart';
import '../widgets/notification_pop.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool shouldShowPopUp = true;
  @override
  void initState() {
    super.initState();
  }

  void handleShowPopUp() {
    setState(() {
      shouldShowPopUp = !shouldShowPopUp;
    });
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
        body: CustomScrollView(slivers: [
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
          SliverToBoxAdapter(
              child: Visibility(
                  visible: shouldShowPopUp,
                  child: Padding(
                    child: NotificationPop(
                      handleVisible: handleShowPopUp,
                    ),
                    padding: EdgeInsets.only(top: 16, left: 8, right: 8),
                  ))),
          PostListViewState()
        ]));
  }
}
