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

class AutomaticDispose extends StatefulWidget {
  final VoidCallback onDisposed;
  final Widget child;

  const AutomaticDispose(
      {Key? key, required this.onDisposed, required this.child})
      : super(key: key);

  @override
  _AutomaticDisposeState createState() => _AutomaticDisposeState();
}

class _AutomaticDisposeState extends State<AutomaticDispose> {
  @override
  void dispose() {
    widget.onDisposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class AutomaticDispose extends StatefulWidget {
  final VoidCallback onDisposed;
  final Widget child;

  const AutomaticDispose(
      {Key? key, required this.onDisposed, required this.child})
      : super(key: key);

  @override
  _AutomaticDisposeState createState() => _AutomaticDisposeState();
}

class _AutomaticDisposeState extends State<AutomaticDispose> {
  @override
  void dispose() {
    widget.onDisposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
            snap: true,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(0),
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
          AutomaticDispose(
              child: PostListViewState(),
              onDisposed: () =>
                  ref.read(firebaseProvider.notifier).resetPage()),
        ]));
  }
}
