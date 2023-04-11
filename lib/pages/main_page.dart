import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/widgets/google_sign_btn.dart';

import '../utils/authentication.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(authenticationProvider);
  }

  @override
  Widget build(BuildContext context) {
    final _user = ref.watch(authenticationProvider);
    // if (!ref.watch(isSignedInProvider)) {
    //   Navigator.of(context).pushReplacementNamed('/');
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _user?.displayName?.toString() ?? 'No Name',
            ),
            const GoogleSignButton(),
          ],
        ),
      ),
    );
  }
}
